// lib/features/resetpass/data/models/reset_password_response.dart
import 'package:json_annotation/json_annotation.dart';

part 'reset_password_response.g.dart';

@JsonSerializable()
class ResetPasswordResponse {
  @JsonKey(name: 'message')
  final String? message;
  @JsonKey(name: 'status')
  final bool? status;
  @JsonKey(name: 'otp', includeIfNull: false)
  final String? otp;

  ResetPasswordResponse({this.message, this.status, this.otp});

  factory ResetPasswordResponse.fromJson(Map<String, dynamic> json) =>
      _$ResetPasswordResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ResetPasswordResponseToJson(this);
}