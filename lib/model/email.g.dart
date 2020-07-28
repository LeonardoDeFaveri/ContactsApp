// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'email.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Email _$EmailFromJson(Map<String, dynamic> json) {
  return Email(
    json['email'] as String,
    json['description'] as String,
  );
}

Map<String, dynamic> _$EmailToJson(Email instance) => <String, dynamic>{
      'email': instance.email,
      'description': instance.description,
    };
