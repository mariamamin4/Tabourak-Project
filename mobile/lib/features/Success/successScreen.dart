import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tabourak/core/routing/routes.dart';

class SuccessScreen extends StatefulWidget {
  const SuccessScreen({super.key});

  @override
  State<SuccessScreen> createState() => _SuccessScreenState();
}

class _SuccessScreenState extends State<SuccessScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 5), () {
      Navigator.pushReplacementNamed(context, Routes.homeScreen);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/success.png',
              width: 150.w,
              height: 150.h,
            ),
              SizedBox(height: 20.h),

            Text(
              'Your account has been created successfully!',
              style: TextStyle(
                fontFamily: 'Roboto',
                fontSize: 24.sp,
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20.h),
            Text(
              'Welcome to Tabourak, you can now log in and book your turn easily.',
              style: TextStyle(
                fontFamily: 'Roboto',
                fontSize: 16.sp,
                color: const Color(0xFF414040),
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}