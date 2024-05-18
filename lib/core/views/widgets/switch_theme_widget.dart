import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_manager/core/app_cubit/theme_state.dart';
import 'package:task_manager/core/di/injection_container.dart';

import '../../app_cubit/theme_cubit.dart';

class SwitchThemeWidget extends StatelessWidget {
  const SwitchThemeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    ThemeCubit themeCubit = getIt<ThemeCubit>();

    return BlocBuilder<ThemeCubit, ThemeState>(
        bloc: themeCubit,
        builder: (context, state) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Tooltip(
                message: themeCubit.themeMode == ThemeMode.dark
                    ? 'set_light_theme'.tr()
                    : 'set_dark_theme'.tr(),
                child: CupertinoButton(
                    child: Icon(
                        themeCubit.themeMode == ThemeMode.dark
                            ? Icons.light_mode_outlined
                            : Icons.dark_mode_outlined,
                        color: Theme.of(context).colorScheme.primaryContainer),
                    onPressed: () {
                      themeCubit.setTheme(themeCubit.themeMode == ThemeMode.dark
                          ? ThemeMode.light
                          : ThemeMode.dark);
                    }),
              ),
            ],
          );
        });
  }
}
