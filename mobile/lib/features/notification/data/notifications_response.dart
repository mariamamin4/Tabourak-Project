import 'package:json_annotation/json_annotation.dart';
part 'notifications_response.g.dart';

@JsonSerializable()
class NotificationsResponse {
  String? message;
  @JsonKey(name: 'data')
  List<NotificationItem>? notifications;
  bool? status;
  int? code;

  NotificationsResponse({this.message, this.notifications, this.status, this.code});

  factory NotificationsResponse.fromJson(Map<String, dynamic> json) =>
      _$NotificationsResponseFromJson(json);
}

@JsonSerializable()
class NotificationItem {
  String? title;
  String? time;
  String? icon;

  NotificationItem({this.title, this.time, this.icon});

  factory NotificationItem.fromJson(Map<String, dynamic> json) =>
      _$NotificationItemFromJson(json);
}