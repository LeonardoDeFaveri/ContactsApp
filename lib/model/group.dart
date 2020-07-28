import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import 'package:Contacts/model/contact.dart';
import 'package:Contacts/model/user.dart';

part 'group.g.dart';

@JsonSerializable()
class Group extends Equatable {
  final int id;
  final String name;
  final User owner;
  final List<Contact> contacts;

  Group(this.id, this.name, this.owner, this.contacts);

  factory Group.fromJson(Map<String, dynamic> json) => _$GroupFromJson(json);

  Map<String, dynamic> toJson() => _$GroupToJson(this);

  @override
  List<Object> get props => [name, owner];
}
