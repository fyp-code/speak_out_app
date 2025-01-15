import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';
import '../../../services/app_firestore_service.dart';
import '../../user-profile/user_model/user_model.dart';
part 'comment_model.g.dart';

@JsonSerializable(explicitToJson: true)
class CommentModel extends Model {
  CommentModel({
    this.userData,
    this.caseId,
    this.comment,
    this.parentId,
    this.createdAt,
  });

  @JsonKey(includeIfNull: false, name: "user_data")
  final AppUser? userData;
  @JsonKey(includeIfNull: false, name: "case_id")
  final String? caseId;
  @JsonKey(includeIfNull: false)
  final String? comment;
  @JsonKey(includeIfNull: false, name: "parent_id")
  final String? parentId;
  @JsonKey(name: "created_at", includeIfNull: false)
  @TimestampConverter()
  final DateTime? createdAt;

  @override
  Map<String, dynamic> toJson() => _$CommentModelToJson(this);

  factory CommentModel.fromJson(Map<String, dynamic> json) =>
      _$CommentModelFromJson(json);
}
