// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reset_password_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ResetPasswordRequest _$ResetPasswordRequestFromJson(
  Map<String, dynamic> json,
) => ResetPasswordRequest(
  emailOrPhone: json['email_or_phone'] as String,
  code: json['code'] as String?,
  newPassword: json['new_password'] as String?,
  confirmPassword: json['confirm_password'] as String?,
);

Map<String, dynamic> _$ResetPasswordRequestToJson(
  ResetPasswordRequest instance,
) => <String, dynamic>{
  'email_or_phone': instance.emailOrPhone,
  'code': ?instance.code,
  'new_password': ?instance.newPassword,
  'confirm_password': ?instance.confirmPassword,
};
