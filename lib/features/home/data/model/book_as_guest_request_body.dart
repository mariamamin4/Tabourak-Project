import 'package:json_annotation/json_annotation.dart';
part 'book_as_guest_request_body.g.dart';

@JsonSerializable()
class BookAsGuestRequestBody {
  final String fullName;
  final String email;
  final String phoneNumber;
  final int branchId;
  final int serviceId;

  BookAsGuestRequestBody({
    required this.fullName,
    required this.email,
    required this.phoneNumber,
    required this.branchId,
    required this.serviceId,
  });

  Map<String, dynamic> toJson() => _$BookAsGuestRequestBodyToJson(this);
}