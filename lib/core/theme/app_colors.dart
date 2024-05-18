import 'package:flutter/material.dart';
import 'package:task_manager/core/theme/dark_colors.dart';
import 'package:task_manager/core/theme/light_colors.dart';

class COLORS {
  const COLORS._();

  static late Color primary;
  static late Color onPrimary;
  static late Color primaryContainer;
  static late Color onPrimaryContainer;
  static late Color error;
  static late Color onError;
  static late Color errorContainer;
  static late Color onErrorContainer;
  static late Color background;
  static late Color onBackground;
  static late Color surface;
  static late Color onSurface;
  static late Color surfaceVariant;
  static late Color onSurfaceVariant;
  static late Color outline;
  static late Color overlay;

  static void changeTheme(bool isDark) => isDark ? initDarkColor() : initLightColor();

  static void initLightColor() {
    primary = LightColors.lightPrimary;
    onPrimary = LightColors.lightOnPrimary;

    primaryContainer = LightColors.lightPrimaryContainer;
    onPrimaryContainer = LightColors.lightOnPrimaryContainer;

    error = LightColors.lightError;
    onError = LightColors.lightOnError;

    errorContainer = LightColors.lightErrorContainer;
    onErrorContainer = LightColors.lightOnErrorContainer;

    background = LightColors.lightBackground;
    onBackground = LightColors.lightOnBackground;

    surface = LightColors.lightSurface;
    onSurface = LightColors.lightOnSurface;

    surfaceVariant = LightColors.lightSurfaceVariant;
    onSurfaceVariant = LightColors.lightOnSurfaceVariant;

    outline = LightColors.lightOutline;
    overlay = LightColors.lightOverlay;
  }

  static void initDarkColor() {
    primary = DarkColors.darkPrimary;
    onPrimary = DarkColors.darkOnPrimary;

    primaryContainer = DarkColors.darkPrimaryContainer;
    onPrimaryContainer = DarkColors.darkOnPrimaryContainer;

    error = DarkColors.darkError;
    onError = DarkColors.darkOnError;

    errorContainer = DarkColors.darkErrorContainer;
    onErrorContainer = DarkColors.darkOnErrorContainer;

    background = DarkColors.darkBackground;
    onBackground = DarkColors.darkOnBackground;

    surface = DarkColors.darkSurface;
    onSurface = DarkColors.darkOnSurface;

    surfaceVariant = DarkColors.darkSurfaceVariant;
    onSurfaceVariant = DarkColors.darkOnSurfaceVariant;

    outline = DarkColors.darkOutline;
    overlay = DarkColors.darkOverlay;
  }
}
