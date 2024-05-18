import 'package:flutter/material.dart';
import 'package:task_manager/core/theme/text_theme.dart';

import 'color_light_scheme.dart';

ThemeData _buildLightTheme(ThemeData base) {
  return base.copyWith(
    textTheme: buildTextTheme(),
    dividerTheme: DividerThemeData(
      color: lightColorScheme.primary,
      thickness: 1.0,
    ),
    scaffoldBackgroundColor: lightColorScheme.surfaceVariant,
    bottomSheetTheme: const BottomSheetThemeData(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
    ),
    cardTheme: CardTheme(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))),
    typography: Typography.material2018(), colorScheme: lightColorScheme.copyWith(background: lightColorScheme.background),
  );
}

ThemeData lightTheme() => _buildLightTheme(ThemeData.light());
