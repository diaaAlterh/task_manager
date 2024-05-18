import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:task_manager/core/exceptions/failure.dart';
import 'package:task_manager/features/todos/models/todos_list_model.dart';

part 'todos_state.freezed.dart';

@freezed
class TodosState with _$TodosState {
  const factory TodosState.initial() = Initial;

  const factory TodosState.loading() = Loading;

  const factory TodosState.loaded(TodosListModel? items) = Loaded;

  const factory TodosState.error(Failure error) = Error;
}
