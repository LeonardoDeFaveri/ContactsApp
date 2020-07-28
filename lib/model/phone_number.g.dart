// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'phone_number.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PhoneNumber _$PhoneNumberFromJson(Map<String, dynamic> json) {
  return PhoneNumber(
    json['id'] as int,
    json['countryCode'] as String,
    json['areaCode'] as String,
    json['prefix'] as String,
    json['phoneLine'] as String,
    json['description'] as String,
  );
}

Map<String, dynamic> _$PhoneNumberToJson(PhoneNumber instance) =>
    <String, dynamic>{
      'id': instance.id,
      'countryCode': instance.countryCode,
      'areaCode': instance.areaCode,
      'prefix': instance.prefix,
      'phoneLine': instance.phoneLine,
      'description': instance.description,
    };
