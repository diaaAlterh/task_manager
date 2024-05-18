import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class AddTodoWidget extends StatelessWidget {
  final VoidCallback onAdd;
  const AddTodoWidget({super.key, required this.onAdd});

  Color color(BuildContext context) => Theme.of(context).colorScheme.primary;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 4.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text('all_todos'.tr(),
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.w500,
                  color: Theme.of(context).colorScheme.primaryContainer)),
          TextButton.icon(
              onPressed: onAdd,
              style: TextButton.styleFrom(
                  padding: EdgeInsets.symmetric(horizontal: 2.w)),
              label: Icon(Icons.arrow_forward_ios_sharp,
                  size: 13.sp, color: color(context)),
              icon: Text(
                'add_new_todo'.tr(),
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    fontWeight: FontWeight.w500, color: color(context)),
              )),
        ],
      ),
    );
  }
}
