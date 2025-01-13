import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';
import '../../../services/app_firestore_service.dart';
part 'user_model.g.dart';

@JsonSerializable(explicitToJson: true)
class AppUser extends Model {
  AppUser({
    this.email,
    this.name,
    this.role,
    this.imageUrl,
    this.createdAt,
    this.updatedAt,
    this.isUserVerified,
  });

  @JsonKey(includeIfNull: false)
  final String? email;
  @JsonKey(includeIfNull: false, name: "isUserVerified", defaultValue: false)
  final bool? isUserVerified;
  @JsonKey(includeIfNull: false)
  final String? name;
  @JsonKey(includeIfNull: false)
  final String? imageUrl;
  @JsonKey(includeIfNull: false)
  final String? role;
  @JsonKey(name: "created_at", includeIfNull: false)
  @TimestampConverter()
  final DateTime? createdAt;
  @JsonKey(name: "updated_at", includeIfNull: false)
  @TimestampConverter()
  final DateTime? updatedAt;

  @override
  Map<String, dynamic> toJson() => _$AppUserToJson(this);

  factory AppUser.fromJson(Map<String, dynamic> json) =>
      _$AppUserFromJson(json);
}

class TimestampConverter implements JsonConverter<DateTime, Timestamp> {
  const TimestampConverter();

  @override
  DateTime fromJson(Timestamp timestamp) {
    return timestamp.toDate();
  }

  @override
  Timestamp toJson(DateTime date) => Timestamp.fromDate(date);
}
