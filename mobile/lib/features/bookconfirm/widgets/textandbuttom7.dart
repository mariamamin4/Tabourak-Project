import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tabourak/core/helpers/extention.dart';
import 'package:tabourak/core/routing/routes.dart';

class TextAndButton7 extends StatelessWidget {
  const TextAndButton7({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Text(
              'Booking Confirmed',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 15.sp, color: const Color(0xFF2366A9), fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(height: 20.h),
          SizedBox(height: 20.h), 
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: ElevatedButton(
              onPressed: () {
              context.pushNamed(Routes.queuestate); 
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF2366A9),
                padding: EdgeInsets.symmetric(horizontal: 80.w, vertical: 15.h),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.r),
                ),
              ),
              child: Text(
                'Track Queue',
                style: TextStyle(fontSize: 16.sp, color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}