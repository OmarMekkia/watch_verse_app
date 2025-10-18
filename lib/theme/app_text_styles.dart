import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:watch_verse/theme/app_colors.dart';

class AppTextStyles {
  AppTextStyles._();
  static final lightTextStyles = _LightTextStyles();
  static final darkTextStyles = _DarkTextStyles();

  static MyTextStyles styles(BuildContext context) =>
      Theme.of(context).brightness == Brightness.dark
      ? darkTextStyles
      : lightTextStyles;
}

abstract class MyTextStyles {
  MyTextStyles();
  TextStyle get screenTitle;
  TextStyle get bodyLargeRegular;
  TextStyle get bodyMediumRegular;
  TextStyle get bodySmallRegular;
  TextStyle get bodyLargeBold;
  TextStyle get bodyMediumBold;
  TextStyle get bodySmallBold;
  TextStyle get button;
}

class _LightTextStyles implements MyTextStyles {
  @override
  TextStyle get screenTitle => TextStyle(
    color: AppColors.lightColors.text,
    fontSize: 20.sp,
    fontWeight: FontWeight.w600,
  );

   @override
  TextStyle get bodyLargeRegular => TextStyle(
    color: AppColors.lightColors.text,
    fontSize: 16.sp,
    fontWeight: FontWeight.w400,
  );

  @override
  TextStyle get bodyMediumRegular => TextStyle(
    color: AppColors.lightColors.text,
    fontSize: 14.sp,
    fontWeight: FontWeight.w400,
  );

  @override
  TextStyle get bodySmallRegular => TextStyle(
    color: AppColors.lightColors.text,
    fontSize: 12.sp,
    fontWeight: FontWeight.w400,
  );
   @override
  TextStyle get bodyLargeBold => TextStyle(
    color: AppColors.lightColors.text,
    fontSize: 16.sp,
    fontWeight: FontWeight.bold,
  );

  @override
  TextStyle get bodyMediumBold => TextStyle(
    color: AppColors.lightColors.text,
    fontSize: 14.sp,
    fontWeight: FontWeight.bold,
  );

  @override
  TextStyle get bodySmallBold => TextStyle(
    color: AppColors.lightColors.text,
    fontSize: 12.sp,
    fontWeight: FontWeight.bold,
  );
  @override
  TextStyle get button => TextStyle(
    color: AppColors.lightColors.button,
    fontSize: 14.sp,
    fontWeight: FontWeight.bold,
  );
}

class _DarkTextStyles implements MyTextStyles {
  @override
  TextStyle get screenTitle => TextStyle(
    color: AppColors.darkColors.text,
    fontSize: 20.sp,
    fontWeight: FontWeight.w600,
  );

  @override
  TextStyle get bodyLargeRegular => TextStyle(
    color: AppColors.darkColors.text,
    fontSize: 16.sp,
    fontWeight: FontWeight.w400,
  );

  @override
  TextStyle get bodyMediumRegular => TextStyle(
    color: AppColors.darkColors.text,
    fontSize: 14.sp,
    fontWeight: FontWeight.w400,
  );

  @override
  TextStyle get bodySmallRegular => TextStyle(
    color: AppColors.darkColors.text,
    fontSize: 12.sp,
    fontWeight: FontWeight.w400,
  );

   @override
  TextStyle get bodyLargeBold => TextStyle(
    color: AppColors.darkColors.text,
    fontSize: 16.sp,
    fontWeight: FontWeight.bold,
  );

  @override
  TextStyle get bodyMediumBold => TextStyle(
    color: AppColors.darkColors.text,
    fontSize: 14.sp,
    fontWeight: FontWeight.bold,
  );

  @override
  TextStyle get bodySmallBold => TextStyle(
    color: AppColors.darkColors.text,
    fontSize: 12.sp,
    fontWeight: FontWeight.bold,
  );

  @override
  TextStyle get button => TextStyle(
    color: AppColors.darkColors.button,
    fontSize: 14.sp,
    fontWeight: FontWeight.bold,
  );
}

extension TextStyleExt on BuildContext {
  MyTextStyles get textStyles => AppTextStyles.styles(this);
}
