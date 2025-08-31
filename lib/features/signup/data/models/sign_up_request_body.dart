import 'package:json_annotation/json_annotation.dart';
part 'sign_up_request_body.g.dart';

@JsonSerializable()
class SignupRequestBody {
  @JsonKey(name: 'fullName')
  final String fullName;
  final String email;
  final String password;
  @JsonKey(name: 'confirmPassword')
  final String confirmPassword;
  @JsonKey(name: 'acceptPolicy')
  final bool acceptPolicy;

  SignupRequestBody({
    required this.fullName,
    required this.email,
    required this.password,
    required this.confirmPassword,
    required this.acceptPolicy,
  });

  Map<String, dynamic> toJson() => _$SignupRequestBodyToJson(this);
}