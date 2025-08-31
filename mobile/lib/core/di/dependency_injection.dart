import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:tabourak/core/networking/api_service.dart' as core_api;
import 'package:tabourak/core/networking/dio_factory.dart';
import 'package:tabourak/features/forgetpass/data/repos/forget_password_repo.dart';
import 'package:tabourak/features/forgetpass/logic/forget_password_cubit.dart';
import 'package:tabourak/features/home/data/repos/booking_repo.dart';
import 'package:tabourak/features/home/data/repos/userinforepo.dart';
import 'package:tabourak/features/home/logic/booking_cubit.dart';
import 'package:tabourak/features/home/logic/userinfoqubit.dart';
import 'package:tabourak/features/login/data/repos/login_repo.dart';
import 'package:tabourak/features/login/logic/login_cubit.dart';
import 'package:tabourak/features/notification/data/notifications_repository.dart';
import 'package:tabourak/features/notification/logic/notifications_cubit.dart';
import 'package:tabourak/features/profile/logic/profile_cubit.dart';
import 'package:tabourak/features/queue_position/data/repo/QueueRepo.dart';
import 'package:tabourak/features/queue_position/logic/QueueCubit.dart';
import 'package:tabourak/features/reset_pass/data/repos/password_reset_repo.dart';
import 'package:tabourak/features/reset_pass/logic/password_reset_cubit.dart';
import 'package:tabourak/features/signup/data/repos/sign_up_repo.dart';
import 'package:tabourak/features/signup/logic/sign_up_cubit.dart';

final getIt = GetIt.instance;

Future<void> setupGetIt() async {
  // Dio & ApiService
  Dio dio = DioFactory.getDio();
  getIt.registerLazySingleton<core_api.ApiService>(() => core_api.ApiService(dio));

  // Login
  getIt.registerLazySingleton<LoginRepo>(() => LoginRepo(getIt<core_api.ApiService>()));
  getIt.registerFactory<LoginCubit>(() => LoginCubit(getIt<LoginRepo>()));

  // Signup
  getIt.registerLazySingleton<SignupRepo>(() => SignupRepo(getIt<core_api.ApiService>()));
  getIt.registerFactory<SignupCubit>(() => SignupCubit(getIt<SignupRepo>()));

  // Forget Password
  getIt.registerLazySingleton<ForgetPasswordRepo>(() => ForgetPasswordRepo(getIt<core_api.ApiService>()));
  getIt.registerFactory<ForgetPasswordCubit>(() => ForgetPasswordCubit(getIt<ForgetPasswordRepo>()));

  // Reset Password
  getIt.registerLazySingleton<PasswordResetRepo>(() => PasswordResetRepo(getIt<core_api.ApiService>()));
  getIt.registerFactory<ResetPasswordCubit>(() => ResetPasswordCubit(getIt<PasswordResetRepo>()));
  // home
   getIt.registerLazySingleton<BookingRepo>(() => BookingRepo(getIt<core_api.ApiService>()));
   getIt.registerFactory<BookingCubit>(() => BookingCubit(getIt<BookingRepo>()));
   
    
getIt.registerFactory(() => ProfileCubit());

   // Notifications
   getIt.registerLazySingleton<NotificationsRepo>(() => NotificationsRepo(getIt<core_api.ApiService>()));
   getIt.registerFactory<NotificationsCubit>(() => NotificationsCubit(getIt<NotificationsRepo>()));
   
   //queue position
     getIt.registerLazySingleton<QueueRepo>(() => QueueRepo(getIt<core_api.ApiService>()));
     getIt.registerFactory<QueueCubit>(() => QueueCubit(getIt<QueueRepo>()));

     getIt.registerLazySingleton<UserInfoRepo>(() => UserInfoRepo(getIt<core_api.ApiService>()));
     getIt.registerFactory<UserInfoCubit>(() => UserInfoCubit(getIt<UserInfoRepo>()));
}