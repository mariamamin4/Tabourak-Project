import 'package:tabourak/core/networking/api_error_handler.dart';
import 'package:tabourak/core/networking/api_result.dart';
import 'package:tabourak/core/networking/api_service.dart';
import 'package:tabourak/features/home/data_home/user_info_response.dart';

class UserInfoRepo {
  final ApiService _apiService;

  UserInfoRepo(this._apiService);

  Future<ApiResult<UserInfoResponse>> fetchUserInfo(String token) async {
    try {
      final response = await _apiService.fetchUserInfo();
      return ApiResult.success(response);
    } catch (error) {
      return ApiResult.failure(ErrorHandler.handle(error));
    }
  }
}