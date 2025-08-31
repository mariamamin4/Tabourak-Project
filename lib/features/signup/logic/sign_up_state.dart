import 'package:freezed_annotation/freezed_annotation.dart';

part 'sign_up_state.freezed.dart';

@freezed
class SignupState with _$SignupState {
  const factory SignupState.initial() = SignupInitial;
  const factory SignupState.loading() = SignupLoading;
  const factory SignupState.success(dynamic data) = SignupSuccess;
  const factory SignupState.error(String error) = SignupError;
  const factory SignupState.updated({required bool acceptPolicy}) = SignupUpdated;
}