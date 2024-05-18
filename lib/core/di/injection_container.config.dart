// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:dio/dio.dart' as _i5;
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;
import 'package:shared_preferences/shared_preferences.dart' as _i3;
import 'package:task_manager/core/app_cubit/theme_cubit.dart' as _i4;
import 'package:task_manager/core/di/app_module.dart' as _i15;
import 'package:task_manager/features/auth/cubit/todos_cubit/auth_cubit.dart'
    as _i11;
import 'package:task_manager/features/auth/repositories/auth_repository.dart'
    as _i9;
import 'package:task_manager/features/auth/repositories/auth_repository_impl.dart'
    as _i10;
import 'package:task_manager/features/auth/services/auth_services.dart' as _i8;
import 'package:task_manager/features/home/cubit/main_cubit/botttom_nav_cubit.dart'
    as _i6;
import 'package:task_manager/features/todos/cubit/todos_cubit/todos_cubit.dart'
    as _i14;
import 'package:task_manager/features/todos/repositories/todos_repository.dart'
    as _i12;
import 'package:task_manager/features/todos/repositories/todos_repository_impl.dart'
    as _i13;
import 'package:task_manager/features/todos/services/todos_services.dart'
    as _i7;

extension GetItInjectableX on _i1.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  Future<_i1.GetIt> init({
    String? environment,
    _i2.EnvironmentFilter? environmentFilter,
  }) async {
    final gh = _i2.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    final appModule = _$AppModule();
    await gh.factoryAsync<_i3.SharedPreferences>(
      () => appModule.prefs,
      preResolve: true,
    );
    gh.lazySingleton<_i4.ThemeCubit>(() => _i4.ThemeCubit());
    gh.lazySingleton<_i5.Dio>(() => appModule.dio);
    gh.lazySingleton<_i6.BottomNavCubit>(() => _i6.BottomNavCubit());
    gh.lazySingleton<_i7.TodosServices>(() => _i7.TodosServices(gh<_i5.Dio>()));
    gh.lazySingleton<_i8.AuthServices>(() => _i8.AuthServices(gh<_i5.Dio>()));
    gh.singleton<_i9.AuthRepository>(
        () => _i10.TodosRepositoryImpl(gh<_i8.AuthServices>()));
    gh.lazySingleton<_i11.AuthCubit>(
        () => _i11.AuthCubit(gh<_i9.AuthRepository>()));
    gh.singleton<_i12.TodosRepository>(
        () => _i13.TodosRepositoryImpl(gh<_i7.TodosServices>()));
    gh.lazySingleton<_i14.TodosCubit>(
        () => _i14.TodosCubit(gh<_i12.TodosRepository>()));
    return this;
  }
}

class _$AppModule extends _i15.AppModule {}
