import 'package:json_annotation/json_annotation.dart';
part 'booking_response.g.dart';

@JsonSerializable()
class BookingResponse {
  String? id;
  @JsonKey(name: 'queueNumber')
  String? queueNumber;
  int? status;
  String? fullName;
  String? serviceName;
  String? branchName;
  String? estimatedStartTime;
  String? createdAt;

  BookingResponse({
    this.id,
    this.queueNumber,
    this.status,
    this.fullName,
    this.serviceName,
    this.branchName,
    this.estimatedStartTime,
    this.createdAt,
  });

  factory BookingResponse.fromJson(Map<String, dynamic> json) =>
      _$BookingResponseFromJson(json);
}