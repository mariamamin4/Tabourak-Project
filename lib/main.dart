import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tabourak/core/routing/approuter.dart';
import 'package:tabourak/core/routing/routes.dart';
import 'package:tabourak/core/di/dependency_injection.dart'; 
import 'package:tabourak/features/forgetpass/logic/forget_password_cubit.dart';
import 'package:tabourak/features/home/logic/booking_cubit.dart';
import 'package:tabourak/features/login/logic/login_cubit.dart';
import 'package:tabourak/features/reset_pass/logic/password_reset_cubit.dart';
import 'package:tabourak/features/signup/logic/sign_up_cubit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setupGetIt(); 
  runApp(const tabourak());
}

class tabourak extends StatelessWidget {
  const tabourak({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MultiBlocProvider(
          providers: [
            BlocProvider<LoginCubit>(
              create: (context) => getIt<LoginCubit>(),
            ),
            BlocProvider<SignupCubit>(
              create: (context) => getIt<SignupCubit>(),
            ),
            BlocProvider<ForgetPasswordCubit>(
              create: (context) => getIt<ForgetPasswordCubit>(),
            ),
            BlocProvider<ResetPasswordCubit>(
              create: (context) => getIt<ResetPasswordCubit>(),
            ),

              BlocProvider<BookingCubit>(
              create: (context) => getIt<BookingCubit>(),
            ),
            
            BlocProvider(create: (context) => getIt<BookingCubit>()),
            
            
          ],
          child: MaterialApp(
            debugShowCheckedModeBanner: false,
            initialRoute: Routes.splash,
            onGenerateRoute: AppRouter().generateRoute,
          ),
        );
      },
    );
  }
}