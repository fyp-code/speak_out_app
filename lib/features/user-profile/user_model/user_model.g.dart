// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AppUser _$AppUserFromJson(Map<String, dynamic> json) => AppUser(
      email: json['email'] as String?,
      name: json['name'] as String?,
      role: json['role'] as String?,
      imageUrl: json['imageUrl'] as String?,
      createdAt: _$JsonConverterFromJson<Timestamp, DateTime>(
          json['created_at'], const TimestampConverter().fromJson),
      updatedAt: _$JsonConverterFromJson<Timestamp, DateTime>(
          json['updated_at'], const TimestampConverter().fromJson),
      isUserVerified: json['isUserVerified'] as bool? ?? false,
    )..id = json['id'] as String?;

Map<String, dynamic> _$AppUserToJson(AppUser instance) => <String, dynamic>{
      'id': instance.id,
      if (instance.email case final value?) 'email': value,
      if (instance.isUserVerified case final value?) 'isUserVerified': value,
      if (instance.name case final value?) 'name': value,
      if (instance.imageUrl case final value?) 'imageUrl': value,
      if (instance.role case final value?) 'role': value,
      if (_$JsonConverterToJson<Timestamp, DateTime>(
              instance.createdAt, const TimestampConverter().toJson)
          case final value?)
        'created_at': value,
      if (_$JsonConverterToJson<Timestamp, DateTime>(
              instance.updatedAt, const TimestampConverter().toJson)
          case final value?)
        'updated_at': value,
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
