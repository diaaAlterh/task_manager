import 'package:dio/dio.dart' hide Headers;
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/http.dart';
import 'package:retrofit/retrofit.dart';
import 'package:task_manager/features/auth/models/user_model.dart';

part 'auth_services.g.dart';

@RestApi()
@LazySingleton()
abstract class AuthServices {
  @factoryMethod
  factory AuthServices(Dio dio) = _AuthServices;

  @POST("/auth/refresh")
  Future<UserModel> refresh();

  @POST("/auth/login")
  Future<UserModel> login({
    @Body() required UserModel user,
  });
}
