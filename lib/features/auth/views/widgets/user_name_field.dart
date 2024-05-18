import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_manager/core/app_cubit/theme_cubit.dart';
import 'package:task_manager/core/app_cubit/theme_state.dart';

import '../../../../core/di/injection_container.dart';

class UserNameField extends StatelessWidget {
  final TextEditingController controller;

  const UserNameField({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    ThemeCubit themeCubit = getIt<ThemeCubit>();

    return BlocBuilder<ThemeCubit, ThemeState>(
      bloc: themeCubit,
      builder: (context, state) {
        final textColor = themeCubit.themeMode == ThemeMode.light
            ? Colors.black
            : Colors.white;
        return TextFormField(
          style: TextStyle(color: textColor),
          controller: controller,
          maxLines: 1,
          textInputAction: TextInputAction.next,
          validator: (value) {
            if ((value?.length ?? 0) < 3) {
              return 'Username must be at least 3 characters';
            }
            return null;
          },
          decoration: InputDecoration(label: Text('username'.tr())),
        );
      },
    );
  }
}
