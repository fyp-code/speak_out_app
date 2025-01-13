import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:speak_out_app/features/setting/seeting-model/setting_model.dart';

import '../../../services/app_firestore_service.dart';

class SettingFirestoreService extends AppFirestoreService<AppSetting> {
  @override
  String get collectionName => 'setting';

  @override
  AppSetting parseModel(DocumentSnapshot document) {
    return AppSetting.fromJson(document.data() as Map<String, dynamic>)
      ..id = document.id;
  }
}
