import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import 'package:Contacts/model/email.dart';
import 'package:Contacts/model/phone_number.dart';
import 'package:Contacts/model/user.dart';

part 'contact.g.dart';

@JsonSerializable()
class Contact extends Equatable {
  final int id;
  final String firstName;
  final String familyName;
  final String secondName;
  final User owner;
  final User associatedUser;
  final List<PhoneNumber> phoneNumbers;
  final List<Email> emails;

  Contact(this.id, this.firstName, this.familyName, this.secondName, this.owner,
      this.associatedUser, this.phoneNumbers, this.emails);

  factory Contact.fromJson(Map<String, dynamic> json) =>
      _$ContactFromJson(json);

  Map<String, dynamic> toJson() => _$ContactToJson(this);

  @override
  List<Object> get props => [firstName, familyName, owner];
}
