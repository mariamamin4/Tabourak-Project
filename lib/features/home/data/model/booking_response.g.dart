// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'booking_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BookingResponse _$BookingResponseFromJson(Map<String, dynamic> json) =>
    BookingResponse(
      id: json['id'] as String?,
      queueNumber: json['queueNumber'] as String?,
      status: (json['status'] as num?)?.toInt(),
      fullName: json['fullName'] as String?,
      serviceName: json['serviceName'] as String?,
      branchName: json['branchName'] as String?,
      estimatedStartTime: json['estimatedStartTime'] as String?,
      createdAt: json['createdAt'] as String?,
    );

Map<String, dynamic> _$BookingResponseToJson(BookingResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'queueNumber': instance.queueNumber,
      'status': instance.status,
      'fullName': instance.fullName,
      'serviceName': instance.serviceName,
      'branchName': instance.branchName,
      'estimatedStartTime': instance.estimatedStartTime,
      'createdAt': instance.createdAt,
    };
