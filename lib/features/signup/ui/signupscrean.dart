import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tabourak/core/di/dependency_injection.dart';
import 'package:tabourak/core/helpers/spacing.dart';
import 'package:tabourak/core/theming/textstyle.dart';
import 'package:tabourak/core/widgets/app_text_button.dart';
import 'package:tabourak/features/signup/logic/sign_up_cubit.dart';
import 'package:tabourak/features/signup/logic/sign_up_state.dart';
import 'package:tabourak/features/signup/ui/weidgets/signup_bloc_listener.dart';
import 'package:tabourak/features/signup/ui/weidgets/signupform.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<SignupCubit>(),
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
                        '                       Signup',
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
                  const SignupForm(),
                  verticalSpace(180.h),
                  BlocConsumer<SignupCubit, SignupState>(
                    listener: (context, state) {
                    
                    },
                    builder: (context, state) {
                      return AppTextButton(
                        buttonText: "Signup",
                        textStyle: TextStyles.font16WhiteSemiBold,
                        onPressed: () {
                          if (context.read<SignupCubit>().formKey.currentState?.validate() ?? false) {
                            context.read<SignupCubit>().emitSignupStates();
                          }
                        },
                        backgroundColor: const Color(0xFF2876C4),
                        borderRadius: 15.r,
                      );
                    },
                  ),
                  verticalSpace(24.h),
                  const SignupBlocListener(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}