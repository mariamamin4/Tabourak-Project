import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tabourak/core/helpers/constants.dart';
import 'package:tabourak/core/helpers/shared_pref_helper.dart';
import 'package:tabourak/core/networking/api_result.dart';
import 'package:tabourak/core/networking/dio_factory.dart';
import 'package:tabourak/features/home/data/repos/userinforepo.dart';
import 'package:tabourak/features/home/logic/userinfoqubit.dart';
import 'package:tabourak/features/login/data/models/login_request_body.dart';
import 'package:tabourak/features/login/data/repos/login_repo.dart';
import 'package:tabourak/features/login/logic/login_state.dart';
import 'package:tabourak/core/di/dependency_injection.dart'; 

class LoginCubit extends Cubit<LoginState> {
  final LoginRepo _loginRepo;
  LoginCubit(this._loginRepo) : super(const LoginState.initial());

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  bool rememberMe = false;

  void updateRememberMe(bool value) {
    rememberMe = value;
    emit(state);
  }

  void emitLoginStates() async {
    if (!formKey.currentState!.validate()) {
      emit(const LoginState.error(error: 'Please fill all fields correctly'));
      return;
    }
    emit(const LoginState.loading());
    try {
      print('Starting login request...');
      final response = await _loginRepo.login(
        LoginRequestBody(
          email: emailController.text,
          password: passwordController.text,
          rememberMe: rememberMe,
        ),
      ).timeout(const Duration(seconds: 10));
      print('Full login response: $response');

      response.when(
        success: (loginResponse) async {
          print('Login successful, saving user data...');
          final token = loginResponse.token ?? '';
          final userName = loginResponse.userName ?? '';
          print('Extracted token: $token, userName: $userName');
          await saveUserData(
            emailController.text,
            passwordController.text,
            token,
            userName,
          ).timeout(const Duration(seconds: 5));
          print('User data saved successfully');

          if (token.isNotEmpty) {
            final userInfoCubit = UserInfoCubit(getIt<UserInfoRepo>());
            userInfoCubit.fetchUserInfo(token); 
          }
          emit(LoginState.success(loginResponse));
        },
        failure: (error) {
          print('Login failed: ${error.apiErrorModel.message}');
          emit(LoginState.error(error: error.apiErrorModel.message ?? 'Login failed'));
        },
      );
    } catch (e) {
      print('Login error: $e');
      emit(LoginState.error(error: e.toString()));
    }
  }

  Future<void> saveUserData(String email, String password, String token, String userName) async {
    try {
      print('Saving user data: token=$token, email=$email, userName=$userName');
      await SharedPrefHelper.setSecuredString(SharedPrefKeys.userToken, token);
      await SharedPrefHelper.setSecuredString(SharedPrefKeys.userName, userName);
      if (rememberMe) {
        await SharedPrefHelper.setSecuredString(SharedPrefKeys.userEmail, email);
        await SharedPrefHelper.setSecuredString(SharedPrefKeys.userPassword, password);
      }
      DioFactory.setTokenIntoHeaderAfterLogin(token); 
    } catch (e) {
      print('Error saving user data: $e');
    }
  }

  @override
  Future<void> close() {
    emailController.dispose();
    passwordController.dispose();
    return super.close();
  }
}