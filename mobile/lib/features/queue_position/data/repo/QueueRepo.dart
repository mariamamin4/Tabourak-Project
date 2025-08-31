import 'package:tabourak/core/networking/api_error_handler.dart';
import 'package:tabourak/core/networking/api_result.dart';
import 'package:tabourak/core/networking/api_service.dart';
import 'package:tabourak/features/queue_position/data/queue_position_response.dart';

class QueueRepo {
  final ApiService _apiService;

  QueueRepo(this._apiService);

  Future<ApiResult<QueuePositionResponse>> getQueuePosition(String ticketId) async {
    try {
      final response = await _apiService.fetchQueuePosition(ticketId);
      return ApiResult.success(response);
    } catch (error) {
      return ApiResult.failure(ErrorHandler.handle(error));
    }
  }
}