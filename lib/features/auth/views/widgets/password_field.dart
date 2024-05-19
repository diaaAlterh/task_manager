import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PasswordField extends StatefulWidget {
  final TextEditingController controller;

  const PasswordField({super.key, required this.controller});

  @override
  State<PasswordField> createState() => _PasswordFieldState();
}

class _PasswordFieldState extends State<PasswordField> {
  bool obscureText = true;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: TextStyle(color: Theme.of(context).colorScheme.primaryContainer),
      controller: widget.controller,
      maxLines: 1,
      obscureText: obscureText,
      textInputAction: TextInputAction.next,
      validator: (value) {
        if ((value?.length ?? 0) < 6) {
          return 'Password must be at least 6 characters';
        }
        return null;
      },
      decoration: InputDecoration(
          label: Text(
            'password'.tr(),
            style: TextStyle(
                color: Theme.of(context).colorScheme.primaryContainer),
          ),
          suffixIcon: IconButton(
            onPressed: () {
              setState(() {
                obscureText = !obscureText;
              });
            },
            icon: Icon(
              obscureText ? CupertinoIcons.eye : CupertinoIcons.eye_slash,
              color: Theme.of(context).colorScheme.primaryContainer,
            ),
          )),
    );
  }
}
