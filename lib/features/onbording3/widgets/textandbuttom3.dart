import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tabourak/core/helpers/extention.dart';
import 'package:tabourak/core/routing/routes.dart';

class textandbuttom3 extends StatelessWidget {
  const textandbuttom3({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 1.sh,
      width: 1.sw,
      color: Colors.white,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Image.asset(
            'assets/images/Rectangle.png',
            fit: BoxFit.cover,
            height: 1.sh,
            width: 1.sw,
          ),
          Positioned(
            top: 150.h,
            child: Text(
              'Your Turn is Coming',
              style: TextStyle(
                fontSize: 20.sp,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ),
          Positioned(
            top: 220.h,
            child: Text(
              'Get smart alerts so you’re ready when it’s \n time for your turn.',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 12.sp, color: Colors.black54),
            ),
          ),
          Positioned(
            top: 280.h,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 12.w,
                  height: 8.h,
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 187, 185, 185),
                    borderRadius: BorderRadius.circular(4.r),
                  ),
                ),
                SizedBox(width: 8.w),
                Container(
                  width: 12.w,
                  height: 8.h,
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 187, 185, 185),
                    borderRadius: BorderRadius.circular(4.r),
                  ),
                ),
                SizedBox(width: 8.w),
                Container(
                  width: 20.w,
                  height: 8.h,
                  decoration: BoxDecoration(
                    color: Color(0xFF2366A9), 
                    borderRadius: BorderRadius.circular(4.r),
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            top: 310.h,
            child: ElevatedButton(
              onPressed: () {
                context.pushNamed(Routes.LoginScreen);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF2366A9),
                padding: EdgeInsets.symmetric(horizontal: 80.w, vertical: 15.h),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.r),
                ),
              ),
              child: Text(
                'Continue',
                style: TextStyle(fontSize: 16.sp, color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}