import 'package:json_annotation/json_annotation.dart';

import 'package:Contacts/models/contact.dart';
import 'package:Contacts/models/phone_number.dart';

part 'call.g.dart';

@JsonSerializable()
class Call {
  final int id;
  final PhoneNumber callerNumber;
  final Contact callerContact;
  final PhoneNumber calledNumber;
  final Contact calledContact;
  final int timestamp;
  final int duration;

  Call(this.id, this.callerNumber, this.callerContact, this.calledNumber,
      this.calledContact, this.timestamp, this.duration);

  factory Call.fromJson(Map<String, dynamic> json) => _$CallFromJson(json);

  Map<String, dynamic> toJson() => _$CallToJson(this);
}
