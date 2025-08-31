import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tabourak/features/login/logic/login_cubit.dart';
import '../../../../core/helpers/spacing.dart';

class EmailAndPassword extends StatefulWidget {
  const EmailAndPassword({super.key});

  @override
  State<EmailAndPassword> createState() => _EmailAndPasswordState();
}

class _EmailAndPasswordState extends State<EmailAndPassword> {
  bool isObscureText = true;

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        final cubit = context.read<LoginCubit>();
        return Form(
          key: cubit.formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Email or Phone',
                style: TextStyle(
                  fontFamily: 'Roboto',
                  fontSize: 14.sp,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
              verticalSpace(8.h),
              TextFormField(
                controller: cubit.emailController,
                style: TextStyle(
                  fontFamily: 'Roboto',
                  fontSize: 16.sp,
                  color: const Color(0xFF6C6C6C),
                  fontWeight: FontWeight.w500,
                ),
                decoration: InputDecoration(
                  hintText: 'example@gmail.com',
                  hintStyle: TextStyle(
                    fontFamily: 'Roboto',
                    fontSize: 16.sp,
                    color: Colors.grey[400],
                  ),
                  filled: true,
                  fillColor: const Color(0xFFECF2F8),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15.r),
                    borderSide: const BorderSide(color: Color(0xFF356697)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15.r),
                    borderSide: const BorderSide(color: Color(0xFF356697), width: 2),
                  ),
                ),
                obscureText: false,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter an email or phone';
                  }
                  return null;
                },
              ),
              verticalSpace(20.h),
              Text(
                'Password',
                style: TextStyle(
                  fontFamily: 'Roboto',
                  fontSize: 14.sp,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
              verticalSpace(8.h),
              TextFormField(
                controller: cubit.passwordController,
                style: TextStyle(
                  fontFamily: 'Roboto',
                  fontSize: 16.sp,
                  color: const Color(0xFF6C6C6C),
                  fontWeight: FontWeight.w500,
                ),
                decoration: InputDecoration(
                  hintText: '1234567',
                  hintStyle: TextStyle(
                    fontFamily: 'Roboto',
                    fontSize: 16.sp,
                    color: Colors.grey[400],
                  ),
                  filled: true,
                  fillColor: const Color(0xFFECF2F8),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15.r),
                    borderSide: const BorderSide(color: Color(0xFF356697)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15.r),
                    borderSide: const BorderSide(color: Color(0xFF356697), width: 2),
                  ),
                  suffixIcon: IconButton(
                    icon: Icon(
                      isObscureText ? Icons.visibility_off : Icons.visibility,
                      color: const Color(0xFF356697),
                    ),
                    onPressed: () {
                      setState(() {
                        isObscureText = !isObscureText;
                      });
                    },
                  ),
                ),
                obscureText: isObscureText,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a password';
                  }
                  return null;
                },
              ),
            ],
          ),
        );
      },
    );
  }
}