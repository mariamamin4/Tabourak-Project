// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notifications_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NotificationsResponse _$NotificationsResponseFromJson(
  Map<String, dynamic> json,
) => NotificationsResponse(
  message: json['message'] as String?,
  notifications: (json['data'] as List<dynamic>?)
      ?.map((e) => NotificationItem.fromJson(e as Map<String, dynamic>))
      .toList(),
  status: json['status'] as bool?,
  code: (json['code'] as num?)?.toInt(),
);

Map<String, dynamic> _$NotificationsResponseToJson(
  NotificationsResponse instance,
) => <String, dynamic>{
  'message': instance.message,
  'data': instance.notifications,
  'status': instance.status,
  'code': instance.code,
};

NotificationItem _$NotificationItemFromJson(Map<String, dynamic> json) =>
    NotificationItem(
      title: json['title'] as String?,
      time: json['time'] as String?,
      icon: json['icon'] as String?,
    );

Map<String, dynamic> _$NotificationItemToJson(NotificationItem instance) =>
    <String, dynamic>{
      'title': instance.title,
      'time': instance.time,
      'icon': instance.icon,
    };
