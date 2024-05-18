import 'package:dio/dio.dart' hide Headers;
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/http.dart';
import 'package:retrofit/retrofit.dart';
import 'package:task_manager/features/todos/models/todo_model.dart';
import 'package:task_manager/features/todos/models/todos_list_model.dart';

part 'todos_services.g.dart';

@RestApi()
@LazySingleton()
abstract class TodosServices {
  @factoryMethod
  factory TodosServices(Dio dio) = _TodosServices;

  @GET("/todos")
  Future<TodosListModel> getTodosList({
    @Query('limit') required String limit,
    @Query('skip') required String skip,
  });

  @POST("/todos/add")
  Future<TodoModel> addTodo({
    @Body() required TodoModel todo,
  });

  @PUT("/todos/{id}")
  Future<TodoModel> updateTodo({
    @Path() required String id,
    @Body() required TodoModel todo,
  });

  @DELETE("/todos/{id}")
  Future<TodoModel> deleteTodo({
    @Path() required String id,
  });
}
