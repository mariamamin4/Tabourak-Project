import 'package:freezed_annotation/freezed_annotation.dart';

part 'notifications_state.freezed.dart';

@freezed
class NotificationsState<T> with _$NotificationsState<T> {
  const factory NotificationsState.initial() = _Initial;
  
  const factory NotificationsState.loading() = Loading;
  const factory NotificationsState.success(T data) = Success<T>;
  const factory NotificationsState.error({required String error}) = Error;
}