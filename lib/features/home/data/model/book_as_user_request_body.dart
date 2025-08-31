import 'package:json_annotation/json_annotation.dart';
part 'book_as_user_request_body.g.dart';

@JsonSerializable()
class BookAsUserRequestBody {
  final int branchId;
  final int serviceId;

  BookAsUserRequestBody({
    required this.branchId,
    required this.serviceId,
  });

  Map<String, dynamic> toJson() => _$BookAsUserRequestBodyToJson(this);
}