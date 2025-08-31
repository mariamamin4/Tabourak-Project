import 'package:json_annotation/json_annotation.dart';
part 'login_request_body.g.dart';

@JsonSerializable()
class LoginRequestBody {
  final String email;
  final String password;
  @JsonKey(name: 'rememberMe')
  final bool rememberMe;

  LoginRequestBody({
    required this.email,
    required this.password,
    this.rememberMe = false, 
  });

  Map<String, dynamic> toJson() => _$LoginRequestBodyToJson(this);
}