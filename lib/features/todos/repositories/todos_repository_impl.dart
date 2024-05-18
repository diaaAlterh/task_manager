import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:task_manager/core/exceptions/error_handler.dart';
import 'package:task_manager/core/exceptions/failure.dart';
import 'package:task_manager/features/todos/models/todo_model.dart';
import 'package:task_manager/features/todos/models/todos_list_model.dart';
import 'package:task_manager/features/todos/repositories/todos_repository.dart';
import 'package:task_manager/features/todos/services/todos_services.dart';

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

      return Right(response);
    } catch (error) {
      return Left(ErrorHandler.handle(error).failure);
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
      return Left(ErrorHandler.handle(error).failure);
    }
  }

  @override
  Future<Either<Failure, TodoModel>> updateTodo({
    required TodoModel todo,
  }) async {
    final id=todo.id.toString();
    todo.id=null;
    try {
      final response = await _todosServices.updateTodo(
        todo: todo,
        id: id,
      );

      return Right(response);
    } catch (error) {
      return Left(ErrorHandler.handle(error).failure);
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
      return Left(ErrorHandler.handle(error).failure);
    }
  }
}
