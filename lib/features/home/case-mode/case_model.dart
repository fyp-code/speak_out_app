import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';
import '../../../services/app_firestore_service.dart';
import '../../user-profile/user_model/user_model.dart';
part 'case_model.g.dart';

@JsonSerializable(explicitToJson: true)
class CaseModel extends Model {
  CaseModel({
    this.userId,
    this.type,
    this.description,
    this.status,
    this.images,
    this.createdAt,
  });

  @JsonKey(includeIfNull: false, name: "user_id")
  final String? userId;
  @JsonKey(includeIfNull: false)
  final String? type;
  @JsonKey(includeIfNull: false)
  final String? description;
  @JsonKey(includeIfNull: false)
  final String? status;
  @JsonKey(includeIfNull: false)
  final List<String>? images;
  @JsonKey(name: "created_at", includeIfNull: false)
  @TimestampConverter()
  final DateTime? createdAt;

  @override
  Map<String, dynamic> toJson() => _$CaseModelToJson(this);

  factory CaseModel.fromJson(Map<String, dynamic> json) =>
      _$CaseModelFromJson(json);
}
