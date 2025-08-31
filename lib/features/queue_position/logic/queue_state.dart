import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:tabourak/features/queue_position/data/queue_position_response.dart';

part 'queue_state.freezed.dart';

@freezed
class QueueState with _$QueueState {
  const factory QueueState.initial() = _Initial;
  const factory QueueState.loading() = Loading;
  const factory QueueState.success(QueuePositionResponse data) = Success;
  const factory QueueState.error({required String error}) = Error;
}