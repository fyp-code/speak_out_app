import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';

class FirebaseStorageService extends GetxService {
  final FirebaseStorage firebaseStorage = FirebaseStorage.instance;

  Future<String> uploadFile(File data) async {
    try {
      final fileName = DateTime.now().toIso8601String();
      final reference = firebaseStorage.ref().child(fileName);
      final task = await reference.putFile(data);
      return await task.ref.getDownloadURL();
    } catch (e) {
      print("---------------------------$e---------------------------------");
      rethrow;
    }
  }

  Future<void> deleteFile(String url) async {
    try {
      await FirebaseStorage.instance.refFromURL(url).delete();
    } catch (e) {
      rethrow;
    }
  }
}
