import 'package:json_annotation/json_annotation.dart';

import 'package:Contacts/models/contact.dart';
import 'package:Contacts/models/user.dart';

part 'group.g.dart';

@JsonSerializable()
class Group {
  final int id;
  final String name;
  final User owner;
  final List<Contact> contacts;

  Group(this.id, this.name, this.owner, this.contacts);

  factory Group.fromJson(Map<String, dynamic> json) => _$GroupFromJson(json);

  Map<String, dynamic> toJson() => _$GroupToJson(this);
}
