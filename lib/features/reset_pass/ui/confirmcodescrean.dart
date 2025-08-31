// lib/features/password_reset/ui/confirm_code_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tabourak/core/di/dependency_injection.dart' as di;
import 'package:tabourak/core/helpers/spacing.dart';
import 'package:tabourak/core/theming/textstyle.dart';
import 'package:tabourak/core/widgets/app_text_button.dart';
import 'package:tabourak/features/reset_pass/logic/password_reset_cubit.dart';
import 'package:tabourak/features/reset_pass/logic/reset_password_state.dart';

class ConfirmCodeScreen extends StatelessWidget {
  final String emailOrPhone;
  const ConfirmCodeScreen({super.key, required this.emailOrPhone});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => di.getIt<ResetPasswordCubit>()..setStep('confirm')..initialize(emailOrPhone),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios, size: 20),
            onPressed: () => Navigator.pop(context),
          ),
          title: const Text('Confirmation Code'),
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
                      'Check Your Email',
                      style: TextStyle(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    verticalSpace(20.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(
                        4,
                        (index) => SizedBox(
                          width: 50.w,
                          child: TextFormField(
                            controller: context.read<ResetPasswordCubit>().codeControllers[index],
                            textAlign: TextAlign.center,
                            keyboardType: TextInputType.number,
                            maxLength: 1,
                            decoration: InputDecoration(
                              counterText: '',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.r),
                              ),
                            ),
                            onChanged: (value) {
                              if (value.length == 1 && index < 3) {
                                FocusScope.of(context).nextFocus();
                              }
                            },
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Enter all digits';
                              }
                              return null;
                            },
                          ),
                        ),
                      ),
                    ),
                    verticalSpace(40.h),
                    BlocConsumer<ResetPasswordCubit, ResetPasswordState>(
                      listener: (context, state) {
                        state.when(
                          initial: () {},
                          loading: (step) {},
                          success: (step, data) {
                            if (step == 'confirm' && data?.message != null) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text(data!.message!)),
                              );
                              Navigator.pushNamed(
                                context,
                                '/resetPassword',
                                arguments: emailOrPhone,
                              );
                            }
                          },
                          error: (step, error) {
                            if (step == 'confirm') {
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
                            buttonText: "Verify Code",
                            textStyle: TextStyles.font16WhiteSemiBold,
                            onPressed: () => validateThenVerify(context, emailOrPhone),
                            backgroundColor: const Color(0xFF2876C4),
                            borderRadius: 15.r,
                          ),
                          loading: (step) => step == 'confirm'
                              ? const Center(child: CircularProgressIndicator())
                              : const SizedBox.shrink(),
                          success: (step, data) => step == 'confirm'
                              ? const SizedBox.shrink()
                              : const SizedBox.shrink(),
                          error: (step, error) => step == 'confirm'
                              ? Column(
                                  children: [
                                    AppTextButton(
                                      buttonText: "Verify Code",
                                      textStyle: TextStyles.font16WhiteSemiBold,
                                      onPressed: () => validateThenVerify(context, emailOrPhone),
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
                    verticalSpace(20.h),
                    TextButton(
                      onPressed: () => context.read<ResetPasswordCubit>().resendCode(emailOrPhone),
                      child: const Text("Don't receive the code? Resend"),
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

  void validateThenVerify(BuildContext context, String emailOrPhone) {
    final cubit = context.read<ResetPasswordCubit>();
    if (cubit.formKey.currentState?.validate() ?? false) {
      cubit.verifyCode(emailOrPhone);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter the full code')),
      );
    }
  }
}