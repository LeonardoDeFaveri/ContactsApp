import 'package:json_annotation/json_annotation.dart';

part 'phone_number.g.dart';

@JsonSerializable()
class PhoneNumber {
  final int id;
  final String countryCode;
  final String areaCode;
  final String prefix;
  final String phoneLine;
  final String description;

  PhoneNumber(this.id, this.countryCode, this.areaCode, this.prefix,
      this.phoneLine, this.description);

  factory PhoneNumber.fromJson(Map<String, dynamic> json) =>
      _$PhoneNumberFromJson(json);

  Map<String, dynamic> toJson() => _$PhoneNumberToJson(this);
}
