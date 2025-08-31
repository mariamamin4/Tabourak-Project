// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'book_as_user_request_body.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BookAsUserRequestBody _$BookAsUserRequestBodyFromJson(
  Map<String, dynamic> json,
) => BookAsUserRequestBody(
  branchId: (json['branchId'] as num).toInt(),
  serviceId: (json['serviceId'] as num).toInt(),
);

Map<String, dynamic> _$BookAsUserRequestBodyToJson(
  BookAsUserRequestBody instance,
) => <String, dynamic>{
  'branchId': instance.branchId,
  'serviceId': instance.serviceId,
};
