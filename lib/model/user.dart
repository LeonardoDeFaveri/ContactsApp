import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable()
class User extends Equatable {
  final String email;
  final String password;

  User(this.email, this.password);

  /// La [password] viene salvata sotto forma di digest, calcolato usando la
  /// funzione sha256
  factory User.fromClear(email, password) {
    var bytes = utf8.encode(password);
    String digest = sha256.convert(bytes).toString();
    return User(email, digest);
  }

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);

  @override
  List<Object> get props => [email];
}
