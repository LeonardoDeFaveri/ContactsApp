import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import 'package:Contacts/model/contact.dart';
import 'package:Contacts/model/phone_number.dart';

part 'call.g.dart';

@JsonSerializable()
class Call extends Equatable {
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

  @override
  List<Object> get props =>
      [calledNumber, callerContact, calledNumber, timestamp];
}
