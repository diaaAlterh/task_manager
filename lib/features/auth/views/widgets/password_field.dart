import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_manager/core/app_cubit/theme_cubit.dart';
import 'package:task_manager/core/app_cubit/theme_state.dart';

import '../../../../core/di/injection_container.dart';

class PasswordField extends StatefulWidget {
  final TextEditingController controller;

  const PasswordField({super.key, required this.controller});

  @override
  State<PasswordField> createState() => _PasswordFieldState();
}

class _PasswordFieldState extends State<PasswordField> {
  ThemeCubit themeCubit = getIt<ThemeCubit>();
  bool obscureText = true;

  @override
  Widget build(BuildContext context) {

    return BlocBuilder<ThemeCubit, ThemeState>(
      bloc: themeCubit,
      builder: (context, state) {
        final textColor =
        themeCubit.themeMode == ThemeMode.light ? Colors.black : Colors.white;
        return TextFormField(
          style: TextStyle(color: textColor),
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
              label: Text('password'.tr()),
              suffixIcon: IconButton(
                onPressed: () {
                  setState(() {
                    obscureText = !obscureText;
                  });
                },
                icon: Icon(
                    obscureText ? CupertinoIcons.eye : CupertinoIcons
                        .eye_slash),
              )),
        );
      },
    );
  }
}
