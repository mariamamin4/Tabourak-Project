// lib/features/resetpass/data/models/reset_password_request.dart
import 'package:json_annotation/json_annotation.dart';

part 'reset_password_request.g.dart';

@JsonSerializable()
class ResetPasswordRequest {
  @JsonKey(name: 'email_or_phone')
  final String emailOrPhone;
  @JsonKey(name: 'code', includeIfNull: false)
  final String? code; 
  @JsonKey(name: 'new_password', includeIfNull: false)
  final String? newPassword;
  @JsonKey(name: 'confirm_password', includeIfNull: false)
  final String? confirmPassword; 

  ResetPasswordRequest({
    required this.emailOrPhone,
    this.code,
    this.newPassword,
    this.confirmPassword,
  });

  factory ResetPasswordRequest.fromJson(Map<String, dynamic> json) =>
      _$ResetPasswordRequestFromJson(json);

  Map<String, dynamic> toJson() => _$ResetPasswordRequestToJson(this);
}