import 'package:tabourak/core/networking/api_error_handler.dart';
import 'package:tabourak/core/networking/api_result.dart';
import 'package:tabourak/core/networking/api_service.dart';
import 'package:tabourak/features/home/data/model/book_as_guest_request_body.dart';
import 'package:tabourak/features/home/data/model/book_as_user_request_body.dart';
import 'package:tabourak/features/home/data/model/booking_response.dart';

class BookingRepo {
  final ApiService _apiService;

  BookingRepo(this._apiService);

  Future<ApiResult<BookingResponse>> bookAsGuest(
      BookAsGuestRequestBody requestBody) async {
    try {
      final response = await _apiService.bookAsGuest(requestBody);
      return ApiResult.success(response);
    } catch (error) {
      return ApiResult.failure(ErrorHandler.handle(error));
    }
  }

  Future<ApiResult<BookingResponse>> bookAsUser(
      BookAsUserRequestBody requestBody) async {
    try {
      final response = await _apiService.bookAsUser(requestBody);
      return ApiResult.success(response);
    } catch (error) {
      return ApiResult.failure(ErrorHandler.handle(error));
    }
  }
}