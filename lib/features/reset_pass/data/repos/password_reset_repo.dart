// lib/features/password_reset/data/repos/password_reset_repo.dart
import 'package:tabourak/core/networking/api_error_handler.dart';
import 'package:tabourak/core/networking/api_result.dart';
import 'package:tabourak/core/networking/api_service.dart';
import 'package:tabourak/features/reset_pass/data/model/reset_password_request.dart';
import 'package:tabourak/features/reset_pass/data/model/reset_password_response.dart';

class PasswordResetRepo {
  final ApiService _apiService;

  PasswordResetRepo(this._apiService);

  Future<ApiResult<ResetPasswordResponse>> sendOTP(ResetPasswordRequest request) async {
    try {
      final response = await _apiService.sendOTP(request);
      return ApiResult.success(response);
    } catch (error) {
      return ApiResult.failure(ErrorHandler.handle(error));
    }
  }

  Future<ApiResult<ResetPasswordResponse>> verifyCode(ResetPasswordRequest request) async {
    try {
      final response = await _apiService.verifyAndResetPassword(request); 
      return ApiResult.success(response);
    } catch (error) {
      return ApiResult.failure(ErrorHandler.handle(error));
    }
  }

  Future<ApiResult<ResetPasswordResponse>> resetPassword(ResetPasswordRequest request) async {
    try {
      final response = await _apiService.verifyAndResetPassword(request); 
      return ApiResult.success(response);
    } catch (error) {
      return ApiResult.failure(ErrorHandler.handle(error));
    }
  }
}