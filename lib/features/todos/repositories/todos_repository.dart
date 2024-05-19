import 'package:dartz/dartz.dart';
import 'package:task_manager/features/todos/models/todo_model.dart';
import 'package:task_manager/features/todos/models/todos_list_model.dart';

import '../../../core/exceptions/failure.dart';

abstract class TodosRepository {
  Future<Either<Failure, TodosListModel>> getTodosList({
    required int limit,
    required int skip,
  });

  Future<Either<Failure, TodoModel>> addTodo({
    required TodoModel todo,
  });

  Future<Either<Failure, TodoModel>> updateTodo({
    required TodoModel todo,
  });

  Future<Either<Failure, TodoModel>> deleteTodo({
    required int id,
  });

  Future<void> saveTodosToLocal(
      {required List<TodoModel> todos, required String key});

  Future<List<TodoModel>> getLocalTodos({required String key});
}
