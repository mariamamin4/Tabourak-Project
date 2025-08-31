import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tabourak/core/helpers/extention.dart';
import 'package:tabourak/core/routing/routes.dart';

class TextAndButton4 extends StatelessWidget {
  const TextAndButton4({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Text(
              'Open the app, choose the branch and \nservice, and get an estimated queue number \nand a QR code for entry.',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 11.sp, color: const Color(0xFF414040)),
            ),
          ),
          SizedBox(height: 20.h),
          SizedBox(height: 20.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: ElevatedButton(
              onPressed: () {
              context.pushNamed(Routes.bookAsGuest); 
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF2366A9),
                padding: EdgeInsets.symmetric(horizontal: 80.w, vertical: 15.h),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.r),
                ),
              ),
              child: Text(
                'Book Now',
                style: TextStyle(fontSize: 16.sp, color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}