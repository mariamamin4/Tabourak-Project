import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tabourak/core/di/dependency_injection.dart';
import 'package:tabourak/core/helpers/spacing.dart';
import 'package:tabourak/core/theming/textstyle.dart';
import 'package:tabourak/core/widgets/app_text_button.dart';
import 'package:tabourak/features/forgetpass/data/repos/forget_password_repo.dart';
import 'package:tabourak/features/forgetpass/logic/forget_password_cubit.dart';
import 'package:tabourak/features/forgetpass/logic/forget_password_state.dart';

class ForgetPasswordScreen extends StatelessWidget {
  const ForgetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ForgetPasswordCubit(getIt<ForgetPasswordRepo>()),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 40.h),
            child: SingleChildScrollView(
              child: Form(
                key: context.read<ForgetPasswordCubit>().formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.arrow_back_ios, size: 20),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                        Text(
                          '             Forget Password',
                          style: TextStyle(
                            fontFamily: 'Roboto',
                            fontSize: 18.sp,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    verticalSpace(48.h),
                    Center(
                      child: Text(
                        'Enter your email or phone number\nto change your password',
                        style: TextStyle(
                          fontFamily: 'Roboto',
                          fontSize: 15.sp,
                          color: Colors.black,
                        ),
                        textAlign: TextAlign.center,
                      ),
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
                      controller: context.read<ForgetPasswordCubit>().emailController,
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
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter an email or phone';
                        }
                        return null;
                      },
                    ),
                    verticalSpace(180.h),
                    BlocBuilder<ForgetPasswordCubit, ForgetPasswordState>(
                      builder: (context, state) {
                        print('Current state: $state');
                        if (state is Loading) {
                          return const Center(child: CircularProgressIndicator());
                        }
                        return AppTextButton(
                          buttonText: "Send",
                          textStyle: TextStyles.font16WhiteSemiBold,
                          onPressed: () {
                            print('Send button pressed');
                            validateThenDoSend(context);
                          },
                          backgroundColor: const Color(0xFF2876C4),
                          borderRadius: 15.r,
                        );
                      },
                    ),
                    BlocListener<ForgetPasswordCubit, ForgetPasswordState>(
                      listener: (context, state) {
                        print('Listener state: $state');
                        state.when(
                          initial: () {},
                          loading: () {},
                          success: (data) {
                            print('Success: ${data?.message}');
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text(data?.message ?? 'Code sent successfully')),
                            );
                            Navigator.pushNamed(
                              context,
                              '/confirmCode',
                              arguments: context.read<ForgetPasswordCubit>().emailController.text,
                            );
                          },
                          error: (error) {
                            print('Error: $error');
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text(error)),
                            );
                          },
                        );
                      },
                      child: const SizedBox.shrink(),
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

  void validateThenDoSend(BuildContext context) {
    final cubit = context.read<ForgetPasswordCubit>();
    print('Validating form...');
    if (cubit.formKey.currentState?.validate() ?? false) {
      print('Form validated, sending request...');
      cubit.sendResetRequest(cubit.emailController.text);
    } else {
      print('Form validation failed');
    }
  }
}