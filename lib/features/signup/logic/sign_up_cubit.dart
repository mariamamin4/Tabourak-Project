import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tabourak/core/helpers/shared_pref_helper.dart';
import 'package:tabourak/core/networking/api_result.dart';
import 'package:tabourak/features/signup/data/models/sign_up_request_body.dart';
import 'package:tabourak/features/signup/data/repos/sign_up_repo.dart';
import 'package:tabourak/features/signup/logic/sign_up_state.dart';

class SignupCubit extends Cubit<SignupState> {
  final SignupRepo _signupRepo;
  SignupCubit(this._signupRepo) : super(SignupInitial());

  
  TextEditingController fullNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  final formKey = GlobalKey<FormState>();


  bool acceptPolicy = false;


  void updateAcceptPolicy(bool value) {
    acceptPolicy = value;
    emit(SignupUpdated(acceptPolicy: acceptPolicy)); 
  }

  // دالة تنفيذ عملية التسجيل
  Future<void> emitSignupStates() async {
    if (formKey.currentState?.validate() ?? false) {
      emit(SignupLoading());
      final response = await _signupRepo.signup(
        SignupRequestBody(
          fullName: fullNameController.text,
          email: emailController.text,
          password: passwordController.text,
          confirmPassword: confirmPasswordController.text,
          acceptPolicy: acceptPolicy,
        ),
      );

      response.when(
        success: (signupResponse) async {
   
          await SharedPrefHelper.setSecuredString('user_email', emailController.text);
          emit(SignupSuccess(signupResponse));
        },
        failure: (error) {
          emit(SignupError(error.apiErrorModel.message ?? 'An error occurred'));
        },
      );
    }
  }


  @override
  Future<void> close() {
    fullNameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    return super.close();
  }
}