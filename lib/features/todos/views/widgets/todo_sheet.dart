import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sizer/sizer.dart';
import 'package:task_manager/core/app_cubit/theme_cubit.dart';
import 'package:task_manager/core/di/injection_container.dart';
import 'package:task_manager/core/views/widgets/main_button.dart';
import 'package:task_manager/features/todos/models/todo_model.dart';

class TodoSheet extends StatefulWidget {
  final TodoModel? todo;
  final Function(TodoModel) onSave;
  final Function()? onDelete;

  const TodoSheet({super.key, this.todo, required this.onSave, this.onDelete});

  @override
  State<TodoSheet> createState() => _TodoSheetState();
}

class _TodoSheetState extends State<TodoSheet> {
  bool isCompleted = false;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController controllerTodo = TextEditingController();
  ThemeCubit themeCubit = getIt<ThemeCubit>();

  @override
  void initState() {
    isCompleted = widget.todo?.completed ?? false;
    controllerTodo.text = widget.todo?.todo ?? '';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final textColor =
        themeCubit.themeMode == ThemeMode.light ? Colors.black : Colors.white;
    return Container(
      height: (widget.todo == null ? 250 : 300) +
          MediaQuery.of(context).viewInsets.bottom,
      padding: const EdgeInsets.all(16),
      child: Form(
        key: formKey,
        child: ListView(
          children: [
            TextFormField(
              style: TextStyle(color: textColor),
              controller: controllerTodo,
              maxLines: 3,
              minLines: 1,
              validator: (value) {
                if (value?.isEmpty ?? false) {
                  return 'This Field is Required';
                }
                return null;
              },
              decoration: InputDecoration(
                  label: Text('todo'.tr(), style: TextStyle(color: textColor))),
            ),
            ListTile(
              contentPadding: const EdgeInsets.symmetric(vertical: 16),
              title: Text('is_completed'.tr()),
              trailing: CupertinoSwitch(
                value: isCompleted,
                onChanged: (bool value) {
                  setState(() {
                    isCompleted = !isCompleted;
                  });
                },
              ),
            ),
            MainButton(
                title: widget.todo == null
                    ? 'add_new_todo'.tr()
                    : 'update_todo'.tr(),
                onPressed: () {
                  if (formKey.currentState?.validate() ?? false) {
                    Navigator.of(context).pop();
                    widget.onSave(
                      TodoModel(
                          id: widget.todo?.id,
                          todo: controllerTodo.text,
                          completed: isCompleted,
                          userId: 5),
                    );
                  } else {
                    HapticFeedback.vibrate();
                  }
                }),
            if (widget.todo != null) ...[
              SizedBox(
                height: 1.h,
              ),
              Center(
                child: SizedBox(
                  width: 150,
                  child: TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                      widget.onDelete!();
                    },
                    style: TextButton.styleFrom(
                        foregroundColor: Theme.of(context).colorScheme.error),
                    child: Text('delete_todo'.tr()),
                  ),
                ),
              )
            ]
          ],
        ),
      ),
    );
  }
}
