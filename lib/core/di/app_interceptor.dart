import 'package:dio/dio.dart';

class AppInterceptor extends QueuedInterceptor {
  final Dio dio;

  AppInterceptor(this.dio);

  late Map<String, String> headers;

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    headers = {'Content-Type': 'application/json'};

    options.headers.addAll(headers);

    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    handler.next(response);
  }
}
