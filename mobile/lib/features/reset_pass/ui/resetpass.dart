// lib/features/password_reset/ui/reset_password_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tabourak/core/di/dependency_injection.dart' as di;
import 'package:tabourak/core/helpers/spacing.dart';
import 'package:tabourak/core/theming/textstyle.dart';
import 'package:tabourak/core/widgets/app_text_button.dart';
import 'package:tabourak/features/reset_pass/logic/password_reset_cubit.dart';
import 'package:tabourak/features/reset_pass/logic/reset_password_state.dart';

class ResetPasswordScreen extends StatelessWidget {
  final String emailOrPhone;
  const ResetPasswordScreen({super.key, required this.emailOrPhone});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => di.getIt<ResetPasswordCubit>()..setStep('reset')..initialize(emailOrPhone),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios, size: 20),
            onPressed: () => Navigator.pop(context),
          ),
          title: const Text('Reset Password'),
        ),
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.w),
            child: SingleChildScrollView(
              child: Form(
                key: context.read<ResetPasswordCubit>().formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    verticalSpace(40.h),
                    Text(
                      'Set New Password',
                      style: TextStyle(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    verticalSpace(20.h),
                    TextFormField(
                      controller: context.read<ResetPasswordCubit>().newPasswordController,
                      obscureText: true,
                      style: TextStyle(
                        fontSize: 16.sp,
                        color: const Color(0xFF6C6C6C),
                      ),
                      decoration: InputDecoration(
                        hintText: 'New Password',
                        hintStyle: TextStyle(
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
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a new password';
                        }
                        if (value.length < 6) {
                          return 'Password must be at least 6 characters';
                        }
                        return null;
                      },
                    ),
                    verticalSpace(20.h),
                    TextFormField(
                      controller: context.read<ResetPasswordCubit>().confirmPasswordController,
                      obscureText: true,
                      style: TextStyle(
                        fontSize: 16.sp,
                        color: const Color(0xFF6C6C6C),
                      ),
                      decoration: InputDecoration(
                        hintText: 'Confirm Password',
                        hintStyle: TextStyle(
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
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please confirm your password';
                        }
                        if (value != context.read<ResetPasswordCubit>().newPasswordController.text) {
                          return 'Passwords do not match';
                        }
                        return null;
                      },
                    ),
                    verticalSpace(40.h),
                    BlocConsumer<ResetPasswordCubit, ResetPasswordState>(
                      listener: (context, state) {
                        state.when(
                          initial: () {},
                          loading: (step) {},
                          success: (step, data) {
                            if (step == 'reset' && data?.message != null) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text(data!.message!)),
                              );
                              Navigator.pushNamed(context, '/login');
                            }
                          },
                          error: (step, error) {
                            if (step == 'reset') {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text(error)),
                              );
                            }
                          },
                        );
                      },
                      builder: (context, state) {
                        return state.when(
                          initial: () => AppTextButton(
                            buttonText: "Reset Password",
                            textStyle: TextStyles.font16WhiteSemiBold,
                            onPressed: () => validateThenReset(context),
                            backgroundColor: const Color(0xFF2876C4),
                            borderRadius: 15.r,
                          ),
                          loading: (step) => step == 'reset'
                              ? const Center(child: CircularProgressIndicator())
                              : const SizedBox.shrink(),
                          success: (step, data) => step == 'reset'
                              ? const SizedBox.shrink()
                              : const SizedBox.shrink(),
                          error: (step, error) => step == 'reset'
                              ? Column(
                                  children: [
                                    AppTextButton(
                                      buttonText: "Reset Password",
                                      textStyle: TextStyles.font16WhiteSemiBold,
                                      onPressed: () => validateThenReset(context),
                                      backgroundColor: const Color(0xFF2876C4),
                                      borderRadius: 15.r,
                                    ),
                                    verticalSpace(10.h),
                                    Text(
                                      error,
                                      style: TextStyle(color: Colors.red, fontSize: 14.sp),
                                    ),
                                  ],
                                )
                              : const SizedBox.shrink(),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void validateThenReset(BuildContext context) {
    final cubit = context.read<ResetPasswordCubit>();
    if (cubit.formKey.currentState?.validate() ?? false) {
      cubit.resetPassword();
    }
  }
}