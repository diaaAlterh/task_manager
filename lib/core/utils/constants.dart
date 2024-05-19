import 'package:flutter/material.dart';

class Constants {
  static const String appName = 'Task Manager';

  static const String baseUrl = 'https://dummyjson.com/';

  static const kDesignSize = Size(375, 812);

  static const hiEmoji = '👋🏻';

  static const todosKey='todos';
  static const addedTodosKey='added_todos';
  static const updatedTodosKey='updated_todos';
  static const deletedTodosKey='deleted_todos';
  static const userKey='user';

  static const Duration connectTimeout = Duration(seconds: 10);
  static const Duration receiveTimeout = Duration(seconds: 10);
  static const Duration sendTimeout = Duration(seconds: 10);
  static const Duration prodConnectTimeout = Duration(seconds: 15);
  static const Duration prodReceiveTimeout = Duration(seconds: 15);
  static const Duration prodSendTimeout = Duration(seconds: 15);
}
