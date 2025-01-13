import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../services/app_firestore_service.dart';
import '../user_model/user_model.dart';

class UserFirestoreService extends AppFirestoreService<AppUser> {
  @override
  String get collectionName => 'users';

  @override
  AppUser parseModel(DocumentSnapshot document) {
    return AppUser.fromJson(document.data() as Map<String, dynamic>)
      ..id = document.id;
  }
}
