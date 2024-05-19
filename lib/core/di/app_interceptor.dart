import 'package:dio/dio.dart';
import 'package:task_manager/core/di/injection_container.dart';

import '../../features/auth/cubit/todos_cubit/auth_cubit.dart';

class AppInterceptor extends QueuedInterceptor {
  final Dio dio;

  AppInterceptor(this.dio);

  late Map<String, String> headers;

  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${(await getIt<AuthCubit>().getUser())?.token}'
    };

    options.headers.addAll(headers);

    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    handler.next(response);
  }
}
