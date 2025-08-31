import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart' hide Headers;
import 'package:tabourak/core/networking/api_constants.dart';
import 'package:tabourak/features/forgetpass/data/model/forget_password_request.dart';
import 'package:tabourak/features/forgetpass/data/model/forget_password_response.dart';
import 'package:tabourak/features/home/data/model/book_as_guest_request_body.dart';
import 'package:tabourak/features/home/data/model/book_as_user_request_body.dart';
import 'package:tabourak/features/home/data/model/booking_response.dart';
import 'package:tabourak/features/home/data_home/user_info_response.dart';
import 'package:tabourak/features/login/data/models/login_request_body.dart';
import 'package:tabourak/features/login/data/models/login_response.dart';
import 'package:tabourak/features/notification/data/notifications_response.dart';
import 'package:tabourak/features/queue_position/data/queue_position_response.dart';
import 'package:tabourak/features/reset_pass/data/model/reset_password_request.dart';
import 'package:tabourak/features/reset_pass/data/model/reset_password_response.dart';
import 'package:tabourak/features/signup/data/models/sign_up_request_body.dart';
import 'package:tabourak/features/signup/data/models/sign_up_response.dart';

part 'api_service.g.dart';

@RestApi(baseUrl: ApiConstants.apiBaseUrl)
abstract class ApiService {
  factory ApiService(Dio dio, {String baseUrl}) = _ApiService;

  @POST(ApiConstants.login)
  Future<LoginResponse> login(
    @Body() LoginRequestBody loginRequestBody,
  );

  @POST(ApiConstants.signup)
  Future<SignupResponse> signup(
    @Body() SignupRequestBody signupRequestBody,
  );

  @POST(ApiConstants.forgetPassword)
  Future<ForgetPasswordResponse> forgetPassword(
    @Body() ForgetPasswordRequest forgetPasswordRequest,
  );

  @POST(ApiConstants.resetPassword)
  Future<ResetPasswordResponse> sendOTP(
    @Body() ResetPasswordRequest resetPasswordRequest,
  );

  @POST(ApiConstants.resetPassword)
  Future<ResetPasswordResponse> verifyAndResetPassword(
    @Body() ResetPasswordRequest resetPasswordRequest,
  );
  @POST(ApiConstants.bookAsGuest)
  Future<BookingResponse> bookAsGuest(
    @Body() BookAsGuestRequestBody bookAsGuestRequestBody,
  );
  @POST(ApiConstants.bookAsUser)
  Future<BookingResponse> bookAsUser(
    @Body() BookAsUserRequestBody bookAsUserRequestBody,
  );
@GET(ApiConstants.notification)
Future<NotificationsResponse> fetchNotifications(); 
 
@GET(ApiConstants.queuePosition)
Future<QueuePositionResponse> fetchQueuePosition(@Path("ticketId") String ticketId);


@GET(ApiConstants.welcom)
Future<UserInfoResponse> fetchUserInfo();

}