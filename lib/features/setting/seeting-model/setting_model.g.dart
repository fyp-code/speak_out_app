// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'setting_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AppSetting _$AppSettingFromJson(Map<String, dynamic> json) => AppSetting(
      verificationCode: json['verification_code'] as String?,
    )..id = json['id'] as String?;

Map<String, dynamic> _$AppSettingToJson(AppSetting instance) =>
    <String, dynamic>{
      'id': instance.id,
      if (instance.verificationCode case final value?)
        'verification_code': value,
    };
