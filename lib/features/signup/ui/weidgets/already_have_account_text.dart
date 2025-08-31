import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tabourak/core/helpers/spacing.dart';
import 'package:tabourak/core/routing/routes.dart';

class AlreadyHaveAccountText extends StatelessWidget {
  const AlreadyHaveAccountText({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        verticalSpace(24.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Expanded(child: Divider(color: Color(0xFF2876C4), thickness: 3)),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.w),
              child: Text(
                'OR',
                style: TextStyle(
                  fontFamily: 'Roboto',
                  fontSize: 16.sp,
                  color: const Color(0xFF2876C4),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const Expanded(child: Divider(color: Color(0xFF2876C4), thickness: 3)),
          ],
        ),
        verticalSpace(20.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
              icon: Image.asset('assets/images/Facebook.png', width: 30.w, height: 30.h),
              onPressed: () {},
            ),
            SizedBox(width: 16.w),
            IconButton(
              icon: Image.asset('assets/images/Google.png', width: 30.w, height: 30.h),
              onPressed: () {},
            ),
            SizedBox(width: 16.w),
            IconButton(
              icon: Image.asset('assets/images/apple.png', width: 30.w, height: 30.h),
              onPressed: () {},
            ),
          ],
        ),
        verticalSpace(40.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "already have an account?",
              style: TextStyle(
                fontFamily: 'Roboto',
                fontSize: 14.sp,
                color: const Color(0xFF6D6666),
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, Routes.LoginScreen);
              },
              child: Text(
                ' Login',
                style: TextStyle(
                  fontFamily: 'Roboto',
                  fontSize: 14.sp,
                  color: Colors.black,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}