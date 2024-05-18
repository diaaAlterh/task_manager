import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:task_manager/core/exceptions/failure.dart';
import 'package:task_manager/features/auth/models/user_model.dart';

part 'auth_state.freezed.dart';

@freezed
class AuthState with _$AuthState {
  const factory AuthState.initial() = Initial;

  const factory AuthState.loading() = Loading;

  const factory AuthState.loaded(UserModel? items) = Loaded;

  const factory AuthState.error(Failure error) = Error;
}
