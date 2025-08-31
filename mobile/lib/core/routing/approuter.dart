
import 'package:flutter/material.dart';
import 'package:tabourak/core/routing/routes.dart';
import 'package:tabourak/features/bookconfirm/bookconfirm.dart';
import 'package:tabourak/features/home/logic/booking_cubit.dart';
import 'package:tabourak/features/home/ui/book_as_guest_screen.dart';
import 'package:tabourak/features/home/ui/book_as_user_screen.dart';
import 'package:tabourak/features/home/ui/booking_details.dart';
import 'package:tabourak/features/home/ui/booknow.dart';
import 'package:tabourak/features/home/ui/filterpage.dart';
import 'package:tabourak/features/home/ui/homescrean.dart';
import 'package:tabourak/features/map/map_screen.dart';
import 'package:tabourak/features/notification/ui/notificationscrean.dart';
import 'package:tabourak/features/profile/ui/profile_screan.dart';
import 'package:tabourak/features/queue_position/ui/QueueStatusPage.dart';
import 'package:tabourak/features/reset_pass/ui/confirmcodescrean.dart';
import 'package:tabourak/features/Success/successScreen.dart';
import 'package:tabourak/features/forgetpass/ui/forgetpassscreen.dart';
import 'package:tabourak/features/login/ui/loginscrean.dart';
import 'package:tabourak/features/onbording/onborging_screen.dart';
import 'package:tabourak/features/onbording2/onboarding2.dart';
import 'package:tabourak/features/onbording3/onboarding3.dart';
import 'package:tabourak/features/signup/ui/signupscrean.dart';
import 'package:tabourak/features/splash/splash.dart';


class AppRouter {
  Route? generateRoute(RouteSettings settings) {
    //this arguments to be passed in any screen like this ( arguments as ClassName )

    switch (settings.name) {
      case Routes.splash:
        return MaterialPageRoute(
          builder: (_) => const SplashScreen(),
        
    
        );
      case Routes.onBoardingScreen:
        return MaterialPageRoute(
          builder: (_) => const OnboardingScreen(),
        
    
        );
       case Routes.onboarding2:
        return MaterialPageRoute(
          builder: (_) => const onboarding2(),
        
    
        );
      case Routes.onboarding3:
        return MaterialPageRoute(
          builder: (_) => const onboarding3(),
        
    
        );
         case Routes.LoginScreen:
        return MaterialPageRoute(
          builder: (_) => const LoginScreen(),
        
    
        );
            case Routes.signUpScreen:
        return MaterialPageRoute(
          builder: (_) => const SignupScreen(),
        );
             case Routes.successScreen:
        return MaterialPageRoute(
          builder: (_) => const SuccessScreen(),
        );
               case Routes.forgetPassword:
        return MaterialPageRoute(
          builder: (_) => const ForgetPasswordScreen(),
        );
      case Routes.confirmCode:
        return MaterialPageRoute(
          builder: (_) => const ConfirmCodeScreen(emailOrPhone: '',),
        ); 
      case Routes.homeScreen:
        return MaterialPageRoute(
          builder: (_) =>  HomeScreen(),
        ); 
        
        case Routes.bookAsGuest:
        return MaterialPageRoute(
          builder: (_) =>  BookAsGuestScreen(),
        );
        case Routes.bookAsUser:
        return MaterialPageRoute(
          builder: (_) =>  BookAsUserScreen(),
        );
    
        case Routes.profile:
        return MaterialPageRoute(
          builder: (_) =>  ProfileScreen(),
        );
        case Routes.booknow:
        return MaterialPageRoute(
          builder: (_) =>  BookNow(),
        );
        case Routes.mapScreen:
        return MaterialPageRoute(
          builder: (_) =>  MapScreen(),
        );
        case Routes.notifications:
        return MaterialPageRoute(
          builder: (_) =>  NotificationsScreen(),
        );
       case Routes.bookconfirm:
        return MaterialPageRoute(
          builder: (_) =>  Bookconfirm(),
        );
        case Routes.bookingDetailsScreen:
        return MaterialPageRoute(
          builder: (_) =>  BookingDetailsScreen( cubit: settings.arguments as BookingCubit),
        );
        case Routes.filterScreen:
        return MaterialPageRoute(
          builder: (_) =>  FilterScreen(),
        );
      case Routes.queuestate:
        return MaterialPageRoute(
          builder: (_) =>  QueueStatusPage(),
        );
   
        
      default:
        return null;
    }
  }
}