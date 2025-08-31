import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tabourak/core/helpers/extention.dart';
import 'package:tabourak/core/routing/routes.dart';

class picture3 extends StatelessWidget {
  const picture3({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white, 
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [

          Align(
            alignment: Alignment.centerRight,
            child: Padding(
              padding: EdgeInsets.all(16.w), 
              child: TextButton(
                onPressed: () {
                  context.pushNamed(Routes.LoginScreen);
                },
                style: TextButton.styleFrom(
                  backgroundColor: Colors.white,
                  side: BorderSide(color: Color(0xFF2366A9), width: 1.w),
                  padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 8.h), 
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(6.r),
                  ),
                ),
                child: Text(
                  'Skip',
                  style: TextStyle(fontSize: 14.sp, color: Color(0xFF2366A9)), 
                ),
              ),
            ),
          ),
          SizedBox(height: 20.h),
          Image.asset(
            'assets/images/onbording3img.png',
            width: 300.w,
            height: 300.h,
          ),
        ],
      ),
    );
  }
}