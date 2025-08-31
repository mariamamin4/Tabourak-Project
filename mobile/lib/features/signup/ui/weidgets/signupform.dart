import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tabourak/core/helpers/app_regex.dart';
import 'package:tabourak/core/helpers/spacing.dart';
import 'package:tabourak/features/signup/logic/sign_up_cubit.dart';
import 'package:tabourak/features/signup/logic/sign_up_state.dart';

class SignupForm extends StatefulWidget {
  const SignupForm({super.key});

  @override
  State<SignupForm> createState() => _SignupFormState();
}

class _SignupFormState extends State<SignupForm> {
  bool isPasswordObscureText = true;
  bool isPasswordConfirmationObscureText = true;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: context.read<SignupCubit>().formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Full Name',
            style: TextStyle(
              fontFamily: 'Roboto',
              fontSize: 14.sp,
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
          verticalSpace(8.h),
          TextFormField(
            controller: context.read<SignupCubit>().fullNameController,
            style: TextStyle(
              fontFamily: 'Roboto',
              fontSize: 16.sp,
              color: const Color(0xFF6C6C6C),
              fontWeight: FontWeight.w500,
            ),
            decoration: InputDecoration(
              hintText: 'Nadia Mohamed',
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
                return 'Please enter your full name';
              }
              return null;
            },
          ),
          verticalSpace(18.h),
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
            controller: context.read<SignupCubit>().emailController,
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
              if (!AppRegex.isEmailValid(value) && !AppRegex.isPhoneNumberValid(value)) {
                return 'Please enter a valid email or phone';
              }
              return null;
            },
          ),
          verticalSpace(18.h),
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
            controller: context.read<SignupCubit>().passwordController,
            style: TextStyle(
              fontFamily: 'Roboto',
              fontSize: 16.sp,
              color: const Color(0xFF6C6C6C),
              fontWeight: FontWeight.w500,
            ),
            decoration: InputDecoration(
              hintText: 'New Password',
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
                  isPasswordObscureText ? Icons.visibility_off : Icons.visibility,
                  color: const Color(0xFF356697),
                ),
                onPressed: () {
                  setState(() {
                    isPasswordObscureText = !isPasswordObscureText;
                  });
                },
              ),
            ),
            obscureText: isPasswordObscureText,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter a valid password';
              }
              return null;
            },
          ),
          verticalSpace(18.h),
          Text(
            'Confirm Password',
            style: TextStyle(
              fontFamily: 'Roboto',
              fontSize: 14.sp,
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
          verticalSpace(8.h),
          TextFormField(
            controller: context.read<SignupCubit>().confirmPasswordController,
            style: TextStyle(
              fontFamily: 'Roboto',
              fontSize: 16.sp,
              color: const Color(0xFF6C6C6C),
              fontWeight: FontWeight.w500,
            ),
            decoration: InputDecoration(
              hintText: 'Confirm Password',
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
                  isPasswordConfirmationObscureText ? Icons.visibility_off : Icons.visibility,
                  color: const Color(0xFF356697),
                ),
                onPressed: () {
                  setState(() {
                    isPasswordConfirmationObscureText = !isPasswordConfirmationObscureText;
                  });
                },
              ),
            ),
            obscureText: isPasswordConfirmationObscureText,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please confirm your password';
              }
              if (value != context.read<SignupCubit>().passwordController.text) {
                return 'Passwords do not match';
              }
              return null;
            },
          ),
          verticalSpace(18.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  BlocBuilder<SignupCubit, SignupState>(
                    builder: (context, state) {
                      return Checkbox(
                        value: context.read<SignupCubit>().acceptPolicy,
                        onChanged: (value) {
                          if (value != null) {
                            context.read<SignupCubit>().updateAcceptPolicy(value);
                          }
                        },
                        activeColor: const Color(0xFF2876C4),
                        checkColor: const Color(0xFF414040),
                        side: const BorderSide(color: Color(0xFF2876C4), width: 1.5),
                      );
                    },
                  ),
                  Text(
                    'I agree to your privacy policy and terms &\n conditions',
                    style: TextStyle(
                      fontFamily: 'Roboto',
                      fontSize: 10.sp,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}