import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../services/app_firestore_service.dart';
import '../comment-model/comment_model.dart';

class CommentsFirestoreService extends AppFirestoreService<CommentModel> {
  @override
  String get collectionName => 'comments';

  @override
  CommentModel parseModel(DocumentSnapshot document) {
    return CommentModel.fromJson(document.data() as Map<String, dynamic>)
      ..id = document.id;
  }
}
