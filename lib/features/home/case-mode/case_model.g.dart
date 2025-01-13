// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'case_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CaseModel _$CaseModelFromJson(Map<String, dynamic> json) => CaseModel(
      userId: json['user_id'] as String?,
      type: json['type'] as String?,
      description: json['description'] as String?,
      status: json['status'] as String?,
      images:
          (json['images'] as List<dynamic>?)?.map((e) => e as String).toList(),
      createdAt: _$JsonConverterFromJson<Timestamp, DateTime>(
          json['created_at'], const TimestampConverter().fromJson),
    )..id = json['id'] as String?;

Map<String, dynamic> _$CaseModelToJson(CaseModel instance) => <String, dynamic>{
      'id': instance.id,
      if (instance.userId case final value?) 'user_id': value,
      if (instance.type case final value?) 'type': value,
      if (instance.description case final value?) 'description': value,
      if (instance.status case final value?) 'status': value,
      if (instance.images case final value?) 'images': value,
      if (_$JsonConverterToJson<Timestamp, DateTime>(
              instance.createdAt, const TimestampConverter().toJson)
          case final value?)
        'created_at': value,
    };

Value? _$JsonConverterFromJson<Json, Value>(
  Object? json,
  Value? Function(Json json) fromJson,
) =>
    json == null ? null : fromJson(json as Json);

Json? _$JsonConverterToJson<Json, Value>(
  Value? value,
  Json? Function(Value value) toJson,
) =>
    value == null ? null : toJson(value);
