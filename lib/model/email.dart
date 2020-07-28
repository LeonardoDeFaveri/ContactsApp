import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'email.g.dart';

@JsonSerializable()
class Email extends Equatable {
  final String email;
  final String description;

  Email(this.email, this.description);

  factory Email.fromJson(Map<String, dynamic> json) => _$EmailFromJson(json);

  Map<String, dynamic> toJson() => _$EmailToJson(this);

  @override
  List<Object> get props => [email];
}
