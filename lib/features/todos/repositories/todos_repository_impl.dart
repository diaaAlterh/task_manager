import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:task_manager/core/exceptions/error_handler.dart';
import 'package:task_manager/core/exceptions/failure.dart';
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
}
