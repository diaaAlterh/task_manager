import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:task_manager/core/di/injection_container.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'auth_cubit_test.dart';
import 'todo_cubit_test.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences.setMockInitialValues({});

  await configure();
  testAuthCubit();
  testTodosCubit();
}
