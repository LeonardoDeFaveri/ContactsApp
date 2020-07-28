// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'call.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Call _$CallFromJson(Map<String, dynamic> json) {
  return Call(
    json['id'] as int,
    json['callerNumber'] == null
        ? null
        : PhoneNumber.fromJson(json['callerNumber'] as Map<String, dynamic>),
    json['callerContact'] == null
        ? null
        : Contact.fromJson(json['callerContact'] as Map<String, dynamic>),
    json['calledNumber'] == null
        ? null
        : PhoneNumber.fromJson(json['calledNumber'] as Map<String, dynamic>),
    json['calledContact'] == null
        ? null
        : Contact.fromJson(json['calledContact'] as Map<String, dynamic>),
    json['timestamp'] as int,
    json['duration'] as int,
  );
}

Map<String, dynamic> _$CallToJson(Call instance) => <String, dynamic>{
      'id': instance.id,
      'callerNumber': instance.callerNumber,
      'callerContact': instance.callerContact,
      'calledNumber': instance.calledNumber,
      'calledContact': instance.calledContact,
      'timestamp': instance.timestamp,
      'duration': instance.duration,
    };
