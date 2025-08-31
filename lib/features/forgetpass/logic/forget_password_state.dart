// lib/features/forgetpass/logic/forget_password_state.dart
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:tabourak/features/forgetpass/data/model/forget_password_response.dart';

part 'forget_password_state.freezed.dart';

@freezed
class ForgetPasswordState with _$ForgetPasswordState {
  const factory ForgetPasswordState.initial() = _Initial;
  const factory ForgetPasswordState.loading() = Loading;
  const factory ForgetPasswordState.success(ForgetPasswordResponse? data) = Success;
  const factory ForgetPasswordState.error(String error) = Error;
}