// lib/features/forgetpass/data/repos/forget_password_repo.dart
import 'package:tabourak/core/networking/api_error_handler.dart';
import 'package:tabourak/core/networking/api_result.dart';
import 'package:tabourak/core/networking/api_service.dart';
import 'package:tabourak/features/forgetpass/data/model/forget_password_request.dart';
import 'package:tabourak/features/forgetpass/data/model/forget_password_response.dart';

class ForgetPasswordRepo {
  final ApiService _apiService;

  ForgetPasswordRepo(this._apiService);

  Future<ApiResult<ForgetPasswordResponse>> sendResetRequest(ForgetPasswordRequest request) async {
    try {
      final response = await _apiService.forgetPassword(request);
      return ApiResult.success(response);
    } catch (error) {
      return ApiResult.failure(ErrorHandler.handle(error));
    }
  }
}