import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:tabourak/features/home/data_home/user_info_response.dart';

part 'user_info_state.freezed.dart';

@freezed
class UserInfoState with _$UserInfoState {
  const factory UserInfoState.initial() = _Initial;
  const factory UserInfoState.loading() = Loading;
  const factory UserInfoState.success(UserInfoResponse data) = Success;
  const factory UserInfoState.error({required String error}) = Error;
}