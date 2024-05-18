import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:task_manager/core/exceptions/error_handler.dart';
import 'package:task_manager/core/exceptions/failure.dart';
import 'package:task_manager/features/auth/models/user_model.dart';
import 'package:task_manager/features/auth/repositories/auth_repository.dart';
import 'package:task_manager/features/auth/services/auth_services.dart';

@Singleton(as: AuthRepository)
class TodosRepositoryImpl implements AuthRepository {
  final AuthServices _authServices;

  TodosRepositoryImpl(
    this._authServices,
  );

  @override
  Future<Either<Failure, UserModel>> login({
    required UserModel user,
  }) async {
    try {
      final response = await _authServices.login(user: user);

      return Right(response);
    } on DioException catch(error){
      return Left(ErrorHandler.handleDioError(error));

    } catch (error) {
      return Left(ErrorHandler.handle(error));
    }
  }

  @override
  Future<Either<Failure, UserModel>> refresh() async {
    try {
      final response = await _authServices.refresh();

      return Right(response);
    } catch (error) {
      return Left(ErrorHandler.handle(error));
    }
  }
}
