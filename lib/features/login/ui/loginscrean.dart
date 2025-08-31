import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tabourak/core/di/dependency_injection.dart';
import 'package:tabourak/core/helpers/spacing.dart';
import 'package:tabourak/core/theming/textstyle.dart';
import 'package:tabourak/core/widgets/app_text_button.dart';
import 'package:tabourak/features/login/logic/login_state.dart';
import 'package:tabourak/features/login/ui/weidgets/email_and_password.dart';
import 'package:tabourak/core/routing/routes.dart';
import 'package:tabourak/features/login/logic/login_cubit.dart';
import 'package:tabourak/features/login/ui/weidgets/login_bloc_listener.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<LoginCubit>(),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 40.h),
            child: SingleChildScrollView(
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
                        '                       Login',
                        style: TextStyle(
                          fontFamily: 'Roboto',
                          fontSize: 20.sp,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  verticalSpace(48.h),
                  const EmailAndPassword(),
                  verticalSpace(8.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          BlocBuilder<LoginCubit, LoginState>(
                            builder: (context, state) {
                              return Checkbox(
                                value: context.read<LoginCubit>().rememberMe,
                                onChanged: (value) {
                                  if (value != null) {
                                    context.read<LoginCubit>().updateRememberMe(value);
                                  }
                                },
                                activeColor: const Color(0xFF2876C4),
                                checkColor: const Color(0xFF414040),
                                side: const BorderSide(color: Color(0xFF2876C4), width: 1.5),
                              );
                            },
                          ),
                          Text(
                            'Remember Me',
                            style: TextStyle(
                              fontFamily: 'Roboto',
                              fontSize: 14.sp,
                              fontWeight: FontWeight.bold,
                              color: Colors.black54,
                            ),
                          ),
                        ],
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, Routes.forgetPassword);
                        },
                        child: Text(
                          'Forgot Password?',
                          style: TextStyle(
                            fontFamily: 'Roboto',
                            fontSize: 14.sp,
                            color: Colors.black,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ),
                    ],
                  ),
                  verticalSpace(180.h),
                  BlocConsumer<LoginCubit, LoginState>(
                    listener: (context, state) {
                      if (state is Success) {
                        Navigator.pushReplacementNamed(context, Routes.homeScreen);
                      } else if (state is Error) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text(state.error)),
                        );
                      }
                    },
                    builder: (context, state) {
                      return AppTextButton(
                        buttonText: "Login",
                        textStyle: TextStyles.font16WhiteSemiBold,
                        onPressed: () {
                          validateThenDoLogin(context);
                          
                        },
                        backgroundColor: const Color(0xFF2876C4),
                        borderRadius: 15.r,
                      );
                    },
                  ),
                  verticalSpace(24.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Expanded(child: Divider(color: Color(0xFF2876C4), thickness: 3)),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10.w),
                        child: Text(
                          'OR',
                          style: TextStyle(
                            fontFamily: 'Roboto',
                            fontSize: 16.sp,
                            color: const Color(0xFF2876C4),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const Expanded(child: Divider(color: Color(0xFF2876C4), thickness: 3)),
                    ],
                  ),
                  verticalSpace(20.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        icon: Image.asset('assets/images/Facebook.png', width: 30.w, height: 30.h),
                        onPressed: () {},
                      ),
                      SizedBox(width: 16.w),
                      IconButton(
                        icon: Image.asset('assets/images/Google.png', width: 30.w, height: 30.h),
                        onPressed: () {},
                      ),
                      SizedBox(width: 16.w),
                      IconButton(
                        icon: Image.asset('assets/images/apple.png', width: 30.w, height: 30.h),
                        onPressed: () {},
                      ),
                    ],
                  ),
                  verticalSpace(40.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Don't have an account?",
                        style: TextStyle(
                          fontFamily: 'Roboto',
                          fontSize: 14.sp,
                          color: const Color(0xFF6D6666),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, Routes.signUpScreen);
                        },
                        child: Text(
                          ' Sign Up',
                          style: TextStyle(
                            fontFamily: 'Roboto',
                            fontSize: 14.sp,
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const LoginBlocListener(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void validateThenDoLogin(BuildContext context) {
    final cubit = context.read<LoginCubit>();
    if (cubit.formKey.currentState?.validate() ?? false) {
      cubit.emitLoginStates();
    }
  }
}