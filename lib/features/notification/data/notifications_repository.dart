import 'package:tabourak/core/networking/api_error_handler.dart';
import 'package:tabourak/core/networking/api_result.dart';
import 'package:tabourak/core/networking/api_service.dart';
import 'package:tabourak/features/notification/data/notifications_response.dart';

class NotificationsRepo {
  final ApiService _apiService;

  NotificationsRepo(this._apiService);

  Future<ApiResult<NotificationsResponse>> fetchNotifications() async {
    try {
      final response = await _apiService.fetchNotifications();
      return ApiResult.success(response);
    } catch (error) {
      return ApiResult.failure(ErrorHandler.handle(error));
    }
  }
}