import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:task_manager/core/utils/general.dart';

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
    showToast(
        message: err.message ?? 'msg_not_internet'.tr(), isErrorMessage: true);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    handler.next(response);
  }
}
