import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:injectable/injectable.dart';
import 'package:task_manager/core/utils/general.dart';
import 'package:task_manager/features/todos/cubit/todos_cubit/todos_state.dart';
import 'package:task_manager/features/todos/models/todo_model.dart';
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
    todosController?.dispose();
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
      emit(const TodosState.loading());
    }

    final result =
        await _todosRepository.getTodosList(limit: limit, skip: _index * limit);

    result.fold((l) {
      if (_index == 0) {
        emit(TodosState.error(l));
      }
      todosController?.error = l;
    }, (result) {
      if (_index == 0) {
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
    });
  }

  Future<void> updateTodo({
    required TodoModel todo,
  }) async {
    final result = await _todosRepository.updateTodo(todo: todo);

    result.fold((l) {}, (result) {
      _updatedTodos.add(result);
      showToast(message: 'todo_updated'.tr());
      final currentItems =
          List<TodoModel>.from(todosController?.itemList ?? []);
      int index = currentItems.indexWhere((element) => element.id == result.id);
      if (index != -1) {
        currentItems[index] = result;
      }
      todosController?.itemList = currentItems;
    });
  }

  Future<void> deleteTodo({
    required int id,
  }) async {
    final result = await _todosRepository.deleteTodo(id: id);

    result.fold((l) {}, (result) {
      _deletedTodos.add(result);
      showToast(message: 'todo_deleted'.tr());

      final currentItems =
          List<TodoModel>.from(todosController?.itemList ?? []);
      currentItems.remove(result);
      todosController?.itemList = currentItems;
    });
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
