class ApiConstants {
  static const String apiBaseUrl = "https://breakfast-varied-sg-chronic.trycloudflare.com/api/";

  static const String login = "Auth/login";
  static const String signup = "Auth/register";
  static const String resetPassword = "Auth/reset-password";
  static const String forgetPassword = "Auth/forgot-password";
  static const String bookAsGuest = "Booking/book-as-guest";
  static const String bookAsUser = "Booking/book-as-user";
  static const String notification = "notifications";
  static const String queuePosition = "booking/position/{ticketId}";
    static const String welcom = "Auth/welcome";
  
}

class ApiErrors {
  static const String badRequestError = "badRequestError";
  static const String noContent = "noContent";
  static const String forbiddenError = "forbiddenError";
  static const String unauthorizedError = "unauthorizedError";
  static const String notFoundError = "notFoundError";
  static const String conflictError = "conflictError";
  static const String internalServerError = "internalServerError";
  static const String unknownError = "unknownError";
  static const String timeoutError = "timeoutError";
  static const String defaultError = "defaultError";
  static const String cacheError = "cacheError";
  static const String noInternetError = "noInternetError";
  static const String loadingMessage = "loading_message";
  static const String retryAgainMessage = "retry_again_message";
  static const String ok = "Ok";
}