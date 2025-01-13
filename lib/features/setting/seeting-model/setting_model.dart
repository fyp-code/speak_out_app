import 'package:json_annotation/json_annotation.dart';

import '../../../services/app_firestore_service.dart';

part 'setting_model.g.dart';

@JsonSerializable(explicitToJson: true)
class AppSetting extends Model {
  AppSetting({
    this.verificationCode,
  });

  @JsonKey(name: "verification_code", includeIfNull: false)
  final String? verificationCode;

  @override
  Map<String, dynamic> toJson() => _$AppSettingToJson(this);

  factory AppSetting.fromJson(Map<String, dynamic> json) =>
      _$AppSettingFromJson(json);
}
