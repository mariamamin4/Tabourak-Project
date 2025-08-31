import 'package:freezed_annotation/freezed_annotation.dart';

part 'booking_state.freezed.dart';

@freezed
class BookingState<T> with _$BookingState<T> {
  const factory BookingState.initial() = _Initial;
  const factory BookingState.loading() = Loading;
  const factory BookingState.success(T data) = Success<T>;
  const factory BookingState.error({required String error}) = Error;
}