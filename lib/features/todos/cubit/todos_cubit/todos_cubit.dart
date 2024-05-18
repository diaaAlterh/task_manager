import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:injectable/injectable.dart';
import 'package:task_manager/features/todos/cubit/todos_cubit/todos_state.dart';
import 'package:task_manager/features/todos/models/todo_model.dart';
import 'package:task_manager/features/todos/repositories/todos_repository.dart';

@lazySingleton
class TodosCubit extends Cubit<TodosState> {
  final TodosRepository _todosRepository;

  TodosCubit(this._todosRepository) : super(const TodosState.initial());

  PagingController<int, TodoModel>? todosController;

  int index = 0;

  clear() {
    index = 0;
    todosController?.dispose();
  }

  void initController() {
    todosController =
        PagingController(firstPageKey: 0, invisibleItemsThreshold: 1);
    todosController?.addPageRequestListener((index) {
      this.index = index;
      getTodosList();
    });
  }

  Future<void> getTodosList({
    int limit = 10,
  }) async {
    if (index == 0) {
      emit(const TodosState.loading());
    }

    final result =
        await _todosRepository.getTodosList(limit: limit, skip: index * limit);

    result.fold((l) {
      if (index == 0) {
        emit(TodosState.error(l));
      }
      todosController?.error = l;
    }, (result) {
      if (index == 0) {
        emit(TodosState.loaded(result));
      }

      bool isLastPage = (result.limit ?? 0) < limit;

      index = index + 1;
      if (isLastPage) {
        todosController?.appendLastPage(result.todos ?? []);
      } else {
        todosController?.appendPage(result.todos ?? [], index);
      }
    });
  }
}
