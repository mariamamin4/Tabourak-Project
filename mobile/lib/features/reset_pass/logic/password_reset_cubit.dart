// lib/features/password_reset/logic/password_reset_cubit.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tabourak/core/networking/api_result.dart';
import 'package:tabourak/features/reset_pass/data/model/reset_password_request.dart';
import 'package:tabourak/features/reset_pass/data/repos/password_reset_repo.dart';
import 'package:tabourak/features/reset_pass/logic/reset_password_state.dart';

class ResetPasswordCubit extends Cubit<ResetPasswordState> {
  final PasswordResetRepo _repo;
  final List<TextEditingController> codeControllers = List.generate(4, (_) => TextEditingController());
  final TextEditingController newPasswordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  String? emailOrPhone;
  String currentStep = 'confirm';

  ResetPasswordCubit(this._repo) : super(const ResetPasswordState.initial());

  void setStep(String step) {
    currentStep = step;
    emit(const ResetPasswordState.initial());
  }

  void initialize(String email) {
    emailOrPhone = email;
    emit(const ResetPasswordState.initial());
  }

  Future<void> resendCode(String emailOrPhone) async {
    if (emailOrPhone == null) return;
    emit(ResetPasswordState.loading(currentStep));
    final request = ResetPasswordRequest(emailOrPhone: emailOrPhone);
    final response = await _repo.sendOTP(request);
    response.when(
      success: (data) => emit(ResetPasswordState.success(currentStep, data)),
      failure: (error) => emit(ResetPasswordState.error(currentStep, error.apiErrorModel.message ?? 'Error resending code')),
    );
  }

  Future<void> verifyCode(String emailOrPhone) async {
    if (emailOrPhone == null) return;
    if (formKey.currentState?.validate() ?? false) {
      emit(ResetPasswordState.loading(currentStep));
      final code = codeControllers.map((c) => c.text).join();
      final request = ResetPasswordRequest(emailOrPhone: emailOrPhone, code: code);
      final response = await _repo.verifyCode(request);
      response.when(
        success: (data) => emit(ResetPasswordState.success(currentStep, data)),
        failure: (error) => emit(ResetPasswordState.error(currentStep, error.apiErrorModel.message ?? 'Invalid code')),
      );
    } else {
      emit(ResetPasswordState.error(currentStep, 'Please enter the full code'));
    }
  }

  Future<void> resetPassword() async {
    if (emailOrPhone == null) return;
    if (formKey.currentState?.validate() ?? false) {
      if (newPasswordController.text != confirmPasswordController.text) {
        emit(ResetPasswordState.error(currentStep, 'Passwords do not match'));
        return;
      }
      emit(ResetPasswordState.loading(currentStep));
      final code = codeControllers.map((c) => c.text).join();
      final request = ResetPasswordRequest(
        emailOrPhone: emailOrPhone!,
        code: code,
        newPassword: newPasswordController.text,
        confirmPassword: confirmPasswordController.text,
      );
      final response = await _repo.resetPassword(request);
      response.when(
        success: (data) => emit(ResetPasswordState.success(currentStep, data)),
        failure: (error) => emit(ResetPasswordState.error(currentStep, error.apiErrorModel.message ?? 'Error resetting password')),
      );
    }
  }

  @override
  Future<void> close() {
    for (var controller in codeControllers) {
      controller.dispose();
    }
    newPasswordController.dispose();
    confirmPasswordController.dispose();
    return super.close();
  }
}