import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:injectable/injectable.dart';
import 'package:task_manager/core/utils/constants.dart';
import 'package:task_manager/core/utils/general.dart';
import 'package:task_manager/features/todos/cubit/todos_cubit/todos_state.dart';
import 'package:task_manager/features/todos/models/todo_model.dart';
import 'package:task_manager/features/todos/models/todos_list_model.dart';
import 'package:task_manager/features/todos/repositories/todos_repository.dart';

@lazySingleton
class TodosCubit extends Cubit<TodosState> {
  final TodosRepository _todosRepository;

  TodosCubit(this._todosRepository) : super(const TodosState.initial());

  PagingController<int, TodoModel>? todosController;

  final List<TodoModel> _addedTodos = [];
  final List<TodoModel> _deletedTodos = [];
  final List<TodoModel> _updatedTodos = [];

  int _index = 0;

  clear() {
    _index = 0;
    _addedTodos.clear();
    _updatedTodos.clear();
    _deletedTodos.clear();
    todosController?.dispose();
  }

  refresh() {
    _index = 0;
    _addedTodos.clear();
    _updatedTodos.clear();
    _deletedTodos.clear();
    todosController?.refresh();
  }

  void initController() {
    todosController =
        PagingController(firstPageKey: 0, invisibleItemsThreshold: 1);
    todosController?.addPageRequestListener((index) {
      _index = index;
      getTodosList();
    });
  }

  Future<void> getTodosList({
    int limit = 10,
  }) async {
    if (_index == 0) {
      List<TodoModel> localTodos =
          await _todosRepository.getLocalTodos(key: Constants.todosKey);
      if (localTodos.isEmpty) {
        emit(const TodosState.loading());
      } else {
        todosController?.appendLastPage(localTodos);
        emit(TodosState.loaded(TodosListModel(todos: localTodos)));
        _addedTodos.addAll(
            await _todosRepository.getLocalTodos(key: Constants.addedTodosKey));
        _updatedTodos.addAll(await _todosRepository.getLocalTodos(
            key: Constants.updatedTodosKey));
        _deletedTodos.addAll(await _todosRepository.getLocalTodos(
            key: Constants.deletedTodosKey));
        _addAddedTodos();
        _updateUpdatedTodos();
        _deleteDeletedTodos();
      }
    }

    final result =
        await _todosRepository.getTodosList(limit: limit, skip: _index * limit);

    result.fold((l) {
      if (_index == 0) {
        emit(TodosState.error(l));
      }
      todosController?.error = l;
    }, (result) async {
      if (_index == 0) {
        todosController?.itemList = [];
        emit(TodosState.loaded(result));
        _addAddedTodos();
      }

      bool isLastPage = (result.limit ?? 0) < limit;

      _index = _index + 1;
      if (isLastPage) {
        todosController?.appendLastPage((result.todos ?? []));
      } else {
        todosController?.appendPage(result.todos ?? [], _index);
      }
      _deleteDeletedTodos();
      _updateUpdatedTodos();
    });
  }

  Future<void> addTodo({
    required TodoModel todo,
  }) async {
    final result = await _todosRepository.addTodo(todo: todo);

    result.fold((l) {}, (result) {
      _addedTodos.add(result);
      showToast(message: 'todo_added'.tr());
      var currentItems = List<TodoModel>.from(todosController?.itemList ?? []);
      currentItems = [result, ...currentItems];
      todosController?.itemList = currentItems;
      _todosRepository.saveTodosToLocal(
          todos: _addedTodos, key: Constants.addedTodosKey);
    });
  }

  Future<void> updateTodo({
    required TodoModel todo,
  }) async {
    if (_addedTodos.contains(todo)) {
      if (_updatedTodos.contains(todo)) {
        _updatedTodos[_updatedTodos
            .indexWhere((element) => element.id == todo.id)] = todo;
      } else {
        _updatedTodos.add(todo);
      }
      showToast(message: 'todo_updated'.tr());
      final currentItems =
          List<TodoModel>.from(todosController?.itemList ?? []);
      int index = currentItems.indexWhere((element) => element.id == todo.id);
      if (index != -1) {
        currentItems[index] = todo;
      }
      todosController?.itemList = currentItems;
      _todosRepository.saveTodosToLocal(
          todos: _updatedTodos, key: Constants.updatedTodosKey);
    } else {
      final result = await _todosRepository.updateTodo(todo: todo);

      result.fold((l) {}, (result) {
        _updatedTodos.add(result);
        showToast(message: 'todo_updated'.tr());
        final currentItems =
            List<TodoModel>.from(todosController?.itemList ?? []);
        int index =
            currentItems.indexWhere((element) => element.id == result.id);
        if (index != -1) {
          currentItems[index] = result;
        }
        todosController?.itemList = currentItems;
        _todosRepository.saveTodosToLocal(
            todos: _updatedTodos, key: Constants.updatedTodosKey);
      });
    }
  }

  Future<void> deleteTodo({
    required TodoModel todo,
  }) async {
    if (_addedTodos.contains(todo)) {
      _addedTodos.remove(todo);
      showToast(message: 'todo_deleted'.tr());

      final currentItems =
          List<TodoModel>.from(todosController?.itemList ?? []);
      currentItems.remove(todo);
      todosController?.itemList = currentItems;
      _todosRepository.saveTodosToLocal(
          todos: _addedTodos, key: Constants.addedTodosKey);
    } else {
      final result =
          await _todosRepository.deleteTodo(id: todo.id?.toInt() ?? 0);

      result.fold((l) {}, (result) {
        _deletedTodos.add(result);
        showToast(message: 'todo_deleted'.tr());

        final currentItems =
            List<TodoModel>.from(todosController?.itemList ?? []);
        currentItems.remove(result);
        todosController?.itemList = currentItems;
        _todosRepository.saveTodosToLocal(
            todos: _deletedTodos, key: Constants.deletedTodosKey);
      });
    }
  }

  _deleteDeletedTodos() {
    final currentItems = List<TodoModel>.from(todosController?.itemList ?? []);
    for (var element in _deletedTodos) {
      currentItems.remove(element);
    }
    todosController?.itemList = currentItems;
  }

  _updateUpdatedTodos() {
    final currentItems = List<TodoModel>.from(todosController?.itemList ?? []);
    for (var element in _updatedTodos) {
      int index =
          currentItems.indexWhere((element2) => element2.id == element.id);
      if (index != -1) {
        currentItems[index] = element;
      }
    }
    todosController?.itemList = currentItems;
  }

  _addAddedTodos() {
    var currentItems = List<TodoModel>.from(todosController?.itemList ?? []);
    currentItems = [..._addedTodos, ...currentItems];
    todosController?.itemList = currentItems;
  }
}
