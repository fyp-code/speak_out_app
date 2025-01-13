import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../services/app_firestore_service.dart';
import '../case-mode/case_model.dart';

class CaseFirestoreService extends AppFirestoreService<CaseModel> {
  @override
  String get collectionName => 'cases';

  @override
  CaseModel parseModel(DocumentSnapshot document) {
    return CaseModel.fromJson(document.data() as Map<String, dynamic>)
      ..id = document.id;
  }
}
