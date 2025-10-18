import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:watch_verse/theme/app_text_styles.dart';
import 'app_colors.dart';

// backgound keyword is deprecated in color scheme, used surface instead

class AppTheme {
  static final light = _lightTheme;
  static final dark = _darkTheme;
}

final _lightTheme = ThemeData(
  splashColor: Colors.transparent,
  highlightColor: Colors.transparent,
  hoverColor: Colors.transparent,
  brightness: Brightness.light,
  splashFactory: NoSplash.splashFactory,
  scaffoldBackgroundColor: AppColors.lightColors.surface,
  tabBarTheme: _tabBarTheme(
    AppColors.lightColors,
    AppTextStyles.lightTextStyles,
  ),
  bottomNavigationBarTheme: _bottomNavigationBarTheme(
    AppColors.lightColors,
    AppTextStyles.lightTextStyles,
  ),

  textTheme: TextTheme(
    bodyLarge: AppTextStyles.lightTextStyles.bodyLargeRegular,
    bodyMedium: AppTextStyles.lightTextStyles.bodyMediumRegular,
    bodySmall: AppTextStyles.lightTextStyles.bodySmallRegular,
    labelLarge: AppTextStyles.lightTextStyles.bodySmallBold,
    labelMedium: AppTextStyles.lightTextStyles.bodySmallBold,
    labelSmall: AppTextStyles.lightTextStyles.bodySmallBold,
  ),

  appBarTheme: AppBarTheme(
    backgroundColor: AppColors.lightColors.surface,
    foregroundColor: AppColors.lightColors.text,
    elevation: 0,
    titleTextStyle: AppTextStyles.lightTextStyles.screenTitle,
  ),
  colorScheme: ColorScheme.light(
    primary: AppColors.lightColors.primary,
    secondary: AppColors.lightColors.secondary,
    surface: AppColors.lightColors.surface,
    onSurface: AppColors.lightColors.primary,
  ),
);

final _darkTheme = ThemeData(
  splashColor: Colors.transparent,
  highlightColor: Colors.transparent,
  hoverColor: Colors.transparent,
  brightness: Brightness.dark,
  splashFactory: NoSplash.splashFactory,
  scaffoldBackgroundColor: AppColors.darkColors.surface,
  tabBarTheme: _tabBarTheme(AppColors.darkColors, AppTextStyles.darkTextStyles),
  bottomNavigationBarTheme: _bottomNavigationBarTheme(
    AppColors.darkColors,
    AppTextStyles.darkTextStyles,
  ),
  textTheme: TextTheme(
    bodyLarge: AppTextStyles.darkTextStyles.bodyLargeRegular,
    bodyMedium: AppTextStyles.darkTextStyles.bodyMediumRegular,
    bodySmall: AppTextStyles.darkTextStyles.bodySmallRegular,
    labelLarge: AppTextStyles.darkTextStyles.bodySmallBold,
    labelMedium: AppTextStyles.darkTextStyles.bodySmallBold,
    labelSmall: AppTextStyles.darkTextStyles.bodySmallBold,
  ),

  appBarTheme: AppBarTheme(
    backgroundColor: AppColors.darkColors.surface,
    foregroundColor: AppColors.darkColors.text,
    elevation: 0,
    titleTextStyle: AppTextStyles.darkTextStyles.screenTitle,
  ),
  colorScheme: ColorScheme.dark(
    primary: AppColors.darkColors.primary,
    secondary: AppColors.darkColors.secondary,
    surface: AppColors.darkColors.surface,
    onSurface: AppColors.lightColors.onSurface,
  ),
);

//############################################################################################
TabBarThemeData _tabBarTheme(MyColors colors, MyTextStyles textStyles) {
  return TabBarThemeData(
    dividerColor: Colors.transparent,
    splashFactory: NoSplash.splashFactory,
    indicatorSize: TabBarIndicatorSize.tab,
    labelColor: colors.secondary,
    labelStyle: textStyles.bodyMediumBold,
    unselectedLabelColor: colors.unselected,
    unselectedLabelStyle: textStyles.bodyMediumBold,
    indicator: BoxDecoration(
      borderRadius: BorderRadius.circular(30.r),
      color: colors.button,
    ),
  );
}

BottomNavigationBarThemeData _bottomNavigationBarTheme(
  MyColors colors,
  MyTextStyles textStyles,
) {
  return BottomNavigationBarThemeData(
    backgroundColor: colors.primary,
    selectedItemColor: colors.button,
    unselectedItemColor: colors.unselected,
    selectedLabelStyle: textStyles.bodySmallRegular,
    unselectedLabelStyle: textStyles.bodySmallRegular,
    showUnselectedLabels: true,
    type: BottomNavigationBarType.fixed,
    elevation: 20,
  );
}
