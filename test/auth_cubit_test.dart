import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:task_manager/core/di/injection_container.dart';
import 'package:task_manager/features/auth/cubit/todos_cubit/auth_cubit.dart';
import 'package:task_manager/features/auth/cubit/todos_cubit/auth_state.dart';
import 'package:task_manager/features/auth/models/user_model.dart';

testAuthCubit() {
  group('AuthCubit', () {
    late AuthCubit authCubit;
    UserModel testUser = UserModel(
        id: 5, username: 'atuny0', password: '9uQFF1Lh'); // Test user instance

    setUp(() {
      authCubit = getIt<AuthCubit>();
    });

    blocTest<AuthCubit, AuthState>(
      'emits [AuthState.loading, AuthState.loaded] when login succeeds',
      build: () => authCubit,
      act: (cubit) {
        return cubit.login(
            userName: testUser.username ?? '',
            password: testUser.password ?? '');
      },
      expect: () => [
        isA<Loading>(),
        isA<Loaded>(),
      ],
    );

    tearDown(() {
      authCubit.close();
    });
  });
}
