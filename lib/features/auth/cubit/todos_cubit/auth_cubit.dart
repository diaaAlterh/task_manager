import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:task_manager/core/utils/general.dart';
import 'package:task_manager/features/auth/models/user_model.dart';
import 'package:task_manager/features/auth/repositories/auth_repository.dart';
import 'auth_state.dart';

@lazySingleton
class AuthCubit extends Cubit<AuthState> {
  final AuthRepository _authRepository;

  AuthCubit(this._authRepository) : super(const AuthState.initial());

  Future<void> login({
    required String userName,
    required String password,
  }) async {
    emit(const AuthState.loading());

    final result = await _authRepository.login(
        user: UserModel(username: userName, password: password));

    result.fold((l) {
      showToast(message: l.statusMessage,isErrorMessage: true);
      emit(AuthState.error(l));
    }, (result) {
      emit(AuthState.loaded(result));
    });
  }

  Future<void> refreshToken({
    required String userName,
    required String password,
  }) async {
    emit(const AuthState.loading());

    final result = await _authRepository.refresh();

    result.fold((l) {
      emit(AuthState.error(l));
    }, (result) {
      emit(AuthState.loaded(result));
    });
  }
}