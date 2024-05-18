import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';

import 'failure.dart';

class ErrorHandler implements Exception {
  static Failure handle(dynamic error) {
    return Failure(statusCode: 403, statusMessage: 'msg_not_internet'.tr());
  }

  static Failure handleDioError(DioException error) {
    return Failure(
        statusCode: error.response?.statusCode ?? 400,
        statusMessage:
        json.decode(error.response.toString())?['message'] ?? 'msg_not_internet'.tr());
  }
}
