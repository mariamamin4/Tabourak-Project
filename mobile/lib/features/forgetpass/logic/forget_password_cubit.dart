import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tabourak/core/networking/api_result.dart';
import 'package:tabourak/features/forgetpass/data/model/forget_password_request.dart';
import 'package:tabourak/features/forgetpass/data/repos/forget_password_repo.dart';
import 'package:tabourak/features/forgetpass/logic/forget_password_state.dart';

class ForgetPasswordCubit extends Cubit<ForgetPasswordState> {
  final ForgetPasswordRepo _forgetPasswordRepo;
  final TextEditingController emailController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  ForgetPasswordCubit(this._forgetPasswordRepo) : super(const ForgetPasswordState.initial());

  Future<void> sendResetRequest(String email) async {
    emit(const ForgetPasswordState.loading());
    try {
      print('Sending reset request for: $email');
      final request = ForgetPasswordRequest(email: email);
      final response = await _forgetPasswordRepo.sendResetRequest(request).timeout(Duration(seconds: 10));
      print('Reset request response: $response');
      response.when(
        success: (data) {
          print('Reset request successful: ${data.message}');
          emit(ForgetPasswordState.success(data));
        },
        failure: (error) {
          print('Reset request failed: ${error.apiErrorModel.message}');
          emit(ForgetPasswordState.error(error.apiErrorModel.message ?? 'An error occurred'));
        },
      );
    } catch (e) {
      print('Reset request error: $e');
      emit(ForgetPasswordState.error(e.toString()));
    }
  }

  @override
  Future<void> close() {
    emailController.dispose();
    return super.close();
  }
}