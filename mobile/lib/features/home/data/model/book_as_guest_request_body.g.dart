// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'book_as_guest_request_body.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BookAsGuestRequestBody _$BookAsGuestRequestBodyFromJson(
  Map<String, dynamic> json,
) => BookAsGuestRequestBody(
  fullName: json['fullName'] as String,
  email: json['email'] as String,
  phoneNumber: json['phoneNumber'] as String,
  branchId: (json['branchId'] as num).toInt(),
  serviceId: (json['serviceId'] as num).toInt(),
);

Map<String, dynamic> _$BookAsGuestRequestBodyToJson(
  BookAsGuestRequestBody instance,
) => <String, dynamic>{
  'fullName': instance.fullName,
  'email': instance.email,
  'phoneNumber': instance.phoneNumber,
  'branchId': instance.branchId,
  'serviceId': instance.serviceId,
};
