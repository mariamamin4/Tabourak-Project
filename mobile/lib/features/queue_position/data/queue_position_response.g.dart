// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'queue_position_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

QueuePositionResponse _$QueuePositionResponseFromJson(
  Map<String, dynamic> json,
) => QueuePositionResponse(
  ticketId: json['ticketId'] as String?,
  ticketNumber: json['ticketNumber'] as String?,
  position: (json['position'] as num?)?.toInt(),
  peopleInFront: (json['peopleInFront'] as num?)?.toInt(),
  estimatedWaitingTime: json['estimatedWaitingTime'] as String?,
  estimatedStartTime: json['estimatedStartTime'] as String?,
);

Map<String, dynamic> _$QueuePositionResponseToJson(
  QueuePositionResponse instance,
) => <String, dynamic>{
  'ticketId': instance.ticketId,
  'ticketNumber': instance.ticketNumber,
  'position': instance.position,
  'peopleInFront': instance.peopleInFront,
  'estimatedWaitingTime': instance.estimatedWaitingTime,
  'estimatedStartTime': instance.estimatedStartTime,
};
