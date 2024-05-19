import 'package:dartz/dartz.dart';
import 'package:task_manager/features/auth/models/user_model.dart';

import '../../../core/exceptions/failure.dart';

abstract class AuthRepository {
  Future<Either<Failure, UserModel>> login({
    required UserModel user,
  });
  Future<Either<Failure, UserModel>> refresh();
}
