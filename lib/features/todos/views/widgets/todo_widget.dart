import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:task_manager/features/todos/models/todo_model.dart';

class TodoWidget extends StatelessWidget {
  const TodoWidget({
    super.key,
    required this.todo,
    this.onPressed,
  });

  final VoidCallback? onPressed;
  final TodoModel todo;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      style: TextButton.styleFrom(
          padding: EdgeInsets.zero,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(4))),
      child: ListTile(
        leading: Text(
          '${todo.id ?? ''}',
          style: Theme.of(context).textTheme.titleSmall?.copyWith(
              color: Theme.of(context).colorScheme.secondary, fontSize: 11.sp),
        ),
        title: Text(
          todo.todo ?? '',
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                fontSize: 11.sp,
                decoration: (todo.completed ?? false)
                    ? TextDecoration.lineThrough
                    : TextDecoration.none,
                fontWeight: FontWeight.w500,
                color: Theme.of(context).colorScheme.primaryContainer,
              ),
        ),
      ),
    );
  }
}
