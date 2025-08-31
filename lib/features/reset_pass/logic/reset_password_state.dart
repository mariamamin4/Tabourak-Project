// lib/features/password_reset/logic/password_reset_state.dart
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:tabourak/features/reset_pass/data/model/reset_password_response.dart';

part 'reset_password_state.freezed.dart';

@freezed
class ResetPasswordState with _$ResetPasswordState {
  const factory ResetPasswordState.initial() = _Initial;
  const factory ResetPasswordState.loading(String step) = Loading;
  const factory ResetPasswordState.success(String step, ResetPasswordResponse? data) = Success;
  const factory ResetPasswordState.error(String step, String error) = Error;
}