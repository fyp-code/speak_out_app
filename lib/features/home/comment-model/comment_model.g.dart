// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'comment_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CommentModel _$CommentModelFromJson(Map<String, dynamic> json) => CommentModel(
      userId: json['user_id'] as String?,
      caseId: json['case_id'] as String?,
      comment: json['comment'] as String?,
      parentId: json['parent_id'] as String?,
      createdAt: _$JsonConverterFromJson<Timestamp, DateTime>(
          json['created_at'], const TimestampConverter().fromJson),
    )..id = json['id'] as String?;

Map<String, dynamic> _$CommentModelToJson(CommentModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      if (instance.userId case final value?) 'user_id': value,
      if (instance.caseId case final value?) 'case_id': value,
      if (instance.comment case final value?) 'comment': value,
      if (instance.parentId case final value?) 'parent_id': value,
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
