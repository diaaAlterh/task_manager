import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task_manager/core/utils/constants.dart';

import 'app_interceptor.dart';

@module
abstract class AppModule {
  @preResolve // if you need to  pre resolve the value
  Future<SharedPreferences> get prefs => SharedPreferences.getInstance();

  @lazySingleton
  Dio get dio {

    final aDio = Dio(
      BaseOptions(
        baseUrl: Constants.baseUrl,
        connectTimeout: kDebugMode ? Constants.connectTimeout : Constants.prodConnectTimeout,
        receiveTimeout: kDebugMode ? Constants.receiveTimeout : Constants.prodReceiveTimeout,
        sendTimeout: kDebugMode ? Constants.sendTimeout : Constants.prodSendTimeout,
      ),
    );

    aDio.interceptors.add(AppInterceptor(aDio));

    if (kDebugMode) {
      aDio.interceptors.add(PrettyDioLogger(
          requestHeader: true,
          requestBody: true,
          responseBody: true,
          responseHeader: false,
          error: true,
          compact: true,
          maxWidth: 90));
    }

    return aDio;
  }
}
