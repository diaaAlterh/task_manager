import 'package:dartz/dartz.dart';
import 'package:task_manager/features/todos/models/todos_list_model.dart';

import '../../../core/exceptions/failure.dart';

abstract class TodosRepository {
  Future<Either<Failure, TodosListModel>> getTodosList({
    required int limit,
    required int skip,
  });
}
