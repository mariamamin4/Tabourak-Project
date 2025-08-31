import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tabourak/core/theming/colors.dart' as colors;

class AppTextButton extends StatelessWidget {
  final String buttonText;
  final TextStyle textStyle;
  final VoidCallback onPressed;
  final Color? backgroundColor;
  final double? borderRadius;

  const AppTextButton({
    super.key,
    required this.buttonText,
    required this.textStyle,
    required this.onPressed,
    this.backgroundColor,
    this.borderRadius,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor ?? colors.ColorsManager.mainBlue,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius ?? 15.0),
        ),
        padding: EdgeInsets.symmetric(vertical: 15.h, horizontal: 30.w),
        minimumSize: Size(double.infinity, 50.h),
        elevation: 5,
      ),
      child: Text(
        buttonText,
        style: textStyle.copyWith(color: Colors.white, fontSize: 16.sp),
      ),
    );
  }
}