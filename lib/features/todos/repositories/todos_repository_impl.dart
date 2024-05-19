import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task_manager/core/exceptions/error_handler.dart';
import 'package:task_manager/core/exceptions/failure.dart';
import 'package:task_manager/features/todos/models/todo_model.dart';
import 'package:task_manager/features/todos/models/todos_list_model.dart';
import 'package:task_manager/features/todos/repositories/todos_repository.dart';
import 'package:task_manager/features/todos/services/todos_services.dart';

import '../../../core/utils/constants.dart';

@Singleton(as: TodosRepository)
class TodosRepositoryImpl implements TodosRepository {
  final TodosServices _todosServices;

  TodosRepositoryImpl(
    this._todosServices,
  );

  @override
  Future<Either<Failure, TodosListModel>> getTodosList({
    required int limit,
    required int skip,
  }) async {
    try {
      final response = await _todosServices.getTodosList(
        limit: limit.toString(),
        skip: skip.toString(),
      );
      _saveTodosInLocalStorage(response.todos ?? []);

      return Right(response);
    } catch (error) {
      return Left(ErrorHandler.handle(error));
    }
  }

  @override
  Future<Either<Failure, TodoModel>> addTodo({
    required TodoModel todo,
  }) async {
    try {
      final response = await _todosServices.addTodo(
        todo: todo,
      );

      return Right(response);
    } catch (error) {
      return Left(ErrorHandler.handle(error));
    }
  }

  @override
  Future<Either<Failure, TodoModel>> updateTodo({
    required TodoModel todo,
  }) async {
    final id = todo.id.toString();
    todo.id = null;
    try {
      final response = await _todosServices.updateTodo(
        todo: todo,
        id: id,
      );

      return Right(response);
    } catch (error) {
      return Left(ErrorHandler.handle(error));
    }
  }

  @override
  Future<Either<Failure, TodoModel>> deleteTodo({
    required int id,
  }) async {
    try {
      final response = await _todosServices.deleteTodo(
        id: id.toString(),
      );

      return Right(response);
    } catch (error) {
      return Left(ErrorHandler.handle(error));
    }
  }

  _saveTodosInLocalStorage(List<TodoModel> todos) async {
    // Decode the stored list of TodoModel objects from shared preferences
    List<TodoModel> localTodos = await getLocalTodos(key: Constants.todosKey);

    // Update existing items
    for (int index = 0; index < localTodos.length; index++) {
      TodoModel? todo;
      try {
        todo = todos.firstWhere(
          (element) => element.id == localTodos[index].id,
        );
      } catch (error) {}
      if (todo != null) {
        localTodos[index] = todo;
      }
    }

    // Add new items
    for (var newTodo in todos) {
      var exists = localTodos.any((localTodo) => localTodo.id == newTodo.id);
      if (!exists) {
        localTodos.add(newTodo);
      }
    }

// Encode the updated list back to a list of strings for storing in shared preferences
    await saveTodosToLocal(todos: localTodos, key: Constants.todosKey);
  }

  @override
  Future<List<TodoModel>> getLocalTodos({required String key}) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return (sharedPreferences.getStringList(key) ?? [])
        .map((e) => TodoModel.fromJson(json.decode(e)))
        .toList();
  }

  @override
  Future<void> saveTodosToLocal(
      {required List<TodoModel> todos, required String key}) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    List<String> encodedTodos =
        todos.map((todo) => json.encode(todo.toJson())).toList();
    sharedPreferences.setStringList(key, encodedTodos);
  }
}
