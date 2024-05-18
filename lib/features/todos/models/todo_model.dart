import 'package:equatable/equatable.dart';

class TodoModel extends Equatable {
  TodoModel({
    this.id,
    this.todo,
    this.completed,
    this.userId,
  });

  TodoModel.fromJson(dynamic json) {
    id = json['id'];
    todo = json['todo'];
    completed = json['completed'];
    userId = json['userId'];
  }

  num? id;
  String? todo;
  bool? completed;
  num? userId;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (id != null) map['id'] = id;
    if (todo != null) map['todo'] = todo;
    if (completed != null) map['completed'] = completed;
    if (userId != null) map['userId'] = userId;
    return map;
  }

  @override
  List<Object?> get props => [id];
}
