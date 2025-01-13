import 'package:cloud_firestore/cloud_firestore.dart';

abstract class AppFirestoreService<T extends Model> {
  String get collectionName;

  T parseModel(DocumentSnapshot document);

  Future<List<T>> fetch() => FirebaseFirestore.instance
      .collection(collectionName)
      .get()
      .then((snap) => snap.docs.map((ds) => parseModel(ds)).toList());

  Future<List<T>> fetchSelected(
          dynamic isEqualTo, String where, String field) async =>
      await FirebaseFirestore.instance
          .collection(collectionName)
          .where(where, isEqualTo: isEqualTo)
          .orderBy(field, descending: true)
          .get()
          .then((snap) => snap.docs.map((ds) => parseModel(ds)).toList());

  Future<List<T>> fetchSelectedWithoutOrder(
          dynamic isEqualTo, String where) async =>
      await FirebaseFirestore.instance
          .collection(collectionName)
          .where(where, isEqualTo: isEqualTo)
          .get()
          .then((snap) => snap.docs.map((ds) => parseModel(ds)).toList());

  Stream<List<T>> fetchSelectedStream(dynamic isEqualTo, String where) =>
      FirebaseFirestore.instance
          .collection(collectionName)
          .where(where, isEqualTo: isEqualTo)
          .snapshots()
          .map((snap) => snap.docs.map((ds) => parseModel(ds)).toList());

  Stream<List<T>> fetchAllFirestore() => FirebaseFirestore.instance
      .collection(collectionName)
      .snapshots()
      .map((snapshot) =>
          snapshot.docs.map((document) => parseModel(document)).toList());

  Future<List<T>> fetchAllFirestoreFuture() => FirebaseFirestore.instance
      .collection(collectionName)
      .get()
      .then((value) =>
          value.docs.map((document) => parseModel(document)).toList());

  Future<List<T>> fetchAllSortedFirestoreFuture(String field) =>
      FirebaseFirestore.instance
          .collection(collectionName)
          .orderBy(field, descending: true)
          .get()
          .then((value) =>
              value.docs.map((document) => parseModel(document)).toList());

  Stream<List<T>> fetchAllSortedFirestore() => FirebaseFirestore.instance
      .collection(collectionName)
      .orderBy('createdAt', descending: true)
      .snapshots()
      .map((snapshot) =>
          snapshot.docs.map((document) => parseModel(document)).toList());

  Stream<List<T>> fetchAllSortedWithLimitFirestore({int? limit}) {
    if (limit != null) {
      return FirebaseFirestore.instance
          .collection(collectionName)
          .orderBy('createdAt', descending: true)
          .limit(limit)
          .snapshots()
          .map((snapshot) =>
              snapshot.docs.map((document) => parseModel(document)).toList());
    }
    return FirebaseFirestore.instance
        .collection(collectionName)
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map((snapshot) =>
            snapshot.docs.map((document) => parseModel(document)).toList());
  }

  Stream<T> fetchOneStreamFirestore(String id) {
    if (id.isEmpty) {
      throw 'No Data';
    }
    try {
      var response = FirebaseFirestore.instance
          .collection(collectionName)
          .doc(id)
          .snapshots();
      return response.map((snapshot) => parseModel(snapshot));
    } catch (_) {
      rethrow;
    }
  }

  Future<T> fetchOneFirestore(String id) async {
    try {
      var res = await FirebaseFirestore.instance
          .collection(collectionName)
          .doc(id)
          .get();
      if (res.exists) {
        return parseModel(res);
      } else {
        throw 'No document found';
      }
    } catch (_) {
      rethrow;
    }
  }

  Future<T> insertFirestore(T model) async {
    try {
      final document = await FirebaseFirestore.instance
          .collection(collectionName)
          .add(model.toJson());
      model.id = document.id;
      return model;
    } catch (e) {
      rethrow;
    }
  }

  Future insertFirestoreWithId(T model) async {
    try {
      await FirebaseFirestore.instance
          .collection(collectionName)
          .doc(model.id)
          .set(model.toJson());
    } catch (e) {
      rethrow;
    }
  }

  Future updateFirestore(T model) async {
    try {
      await FirebaseFirestore.instance
          .collection(collectionName)
          .doc(model.id)
          .update(model.toJson());
    } catch (e) {
      rethrow;
    }
  }

  Future deleteFirestore(String documentId) async {
    try {
      FirebaseFirestore.instance
          .collection(collectionName)
          .doc(documentId)
          .delete();
    } catch (e) {
      rethrow;
    }
  }

  Future<List<T>> fetchSubCollectionDocuments(
      String parentDocumentId, String subCollectionName) async {
    try {
      final QuerySnapshot<Map<String, dynamic>> snapshot =
          await FirebaseFirestore.instance
              .collection(collectionName)
              .doc(parentDocumentId)
              .collection(subCollectionName)
              .get();

      return snapshot.docs.map((doc) => parseModel(doc)).toList();
    } catch (e) {
      rethrow;
    }
  }

  // New method to fetch selected documents from a sub-collection
  Future<List<T>> fetchSelectedFromSubCollection(String parentDocumentId,
      String subCollectionName, dynamic isEqualTo, String where) async {
    try {
      final QuerySnapshot<Map<String, dynamic>> snapshot =
          await FirebaseFirestore.instance
              .collection(collectionName)
              .doc(parentDocumentId)
              .collection(subCollectionName)
              .where(where, isEqualTo: isEqualTo)
              .get();

      return snapshot.docs.map((doc) => parseModel(doc)).toList();
    } catch (e) {
      rethrow;
    }
  }
}

abstract class Model {
  String? id;

  Model({this.id});

  Map<String, dynamic> toJson();

  Model.fromJson(Map<String, dynamic> json);
}
