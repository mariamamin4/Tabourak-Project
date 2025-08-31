import 'package:json_annotation/json_annotation.dart';

part 'queue_position_response.g.dart';

@JsonSerializable()
class QueuePositionResponse {
  String? ticketId;
  String? ticketNumber;
  int? position;
  int? peopleInFront;
  String? estimatedWaitingTime;
  String? estimatedStartTime;

  QueuePositionResponse({
    this.ticketId,
    this.ticketNumber,
    this.position,
    this.peopleInFront,
    this.estimatedWaitingTime,
    this.estimatedStartTime,
  });

  factory QueuePositionResponse.fromJson(Map<String, dynamic> json) =>
      _$QueuePositionResponseFromJson(json);
}