import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:fluttertoast/fluttertoast.dart';

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
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    log('onError: $err');
    Fluttertoast.showToast(msg: err.message ?? 'msg_not_internet'.tr());
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    handler.next(response);
  }
}
