// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'contact.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Contact _$ContactFromJson(Map<String, dynamic> json) {
  return Contact(
    json['id'] as int,
    json['firstName'] as String,
    json['familyName'] as String,
    json['secondName'] as String,
    json['owner'] == null
        ? null
        : User.fromJson(json['owner'] as Map<String, dynamic>),
    json['associatedUser'] == null
        ? null
        : User.fromJson(json['associatedUser'] as Map<String, dynamic>),
    (json['phoneNumbers'] as List)
        ?.map((e) =>
            e == null ? null : PhoneNumber.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    (json['emails'] as List)
        ?.map(
            (e) => e == null ? null : Email.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$ContactToJson(Contact instance) => <String, dynamic>{
      'id': instance.id,
      'firstName': instance.firstName,
      'familyName': instance.familyName,
      'secondName': instance.secondName,
      'owner': instance.owner,
      'associatedUser': instance.associatedUser,
      'phoneNumbers': instance.phoneNumbers,
      'emails': instance.emails,
    };
