import 'package:flutter/material.dart';
import 'package:task_manager/core/theme/color_dark_scheme.dart';
import 'package:task_manager/core/theme/text_theme.dart';

ThemeData _buildDarkTheme(ThemeData base) {
  return base.copyWith(
    colorScheme: darkColorScheme,
    textTheme: buildTextTheme(),
    scaffoldBackgroundColor: darkColorScheme.surfaceVariant,
    dividerTheme: DividerThemeData(
      color: darkColorScheme.secondary,
      thickness: 1.0,
    ),
    typography: Typography.material2018(),
    cardTheme: CardTheme(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))),
    bottomSheetTheme: const BottomSheetThemeData(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
    ),
  );
}

ThemeData darkTheme() => _buildDarkTheme(ThemeData.dark());
