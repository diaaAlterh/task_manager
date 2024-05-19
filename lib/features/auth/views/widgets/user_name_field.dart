import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class UserNameField extends StatelessWidget {
  final TextEditingController controller;

  const UserNameField({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {

    return TextFormField(
      style: TextStyle(color: Theme.of(context)
          .colorScheme
          .primaryContainer),
      controller: controller,
      maxLines: 1,
      textInputAction: TextInputAction.next,
      validator: (value) {
        if ((value?.length ?? 0) < 3) {
          return 'Username must be at least 3 characters';
        }
        return null;
      },
      decoration: InputDecoration(
          label: Text(
            'username'.tr(),
            style: TextStyle(color: Theme.of(context).colorScheme.primaryContainer,),
          )),
    );
  }
}
