import 'package:task_manager/features/todos/models/todo_model.dart';

class TodosListModel {
  TodosListModel({
    this.todos,
    this.total,
    this.skip,
    this.limit,
  });

  TodosListModel.fromJson(dynamic json) {
    if (json['todos'] != null) {
      todos = [];
      json['todos'].forEach((v) {
        todos?.add(TodoModel.fromJson(v));
      });
    }
    total = json['total'];
    skip = json['skip'];
    limit = json['limit'];
  }

  List<TodoModel>? todos;
  num? total;
  num? skip;
  num? limit;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (todos != null) {
      map['todos'] = todos?.map((v) => v.toJson()).toList();
    }
    map['total'] = total;
    map['skip'] = skip;
    map['limit'] = limit;
    return map;
  }
}