import 'dart:developer';
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:speak_out_app/utils/firestore_exception.dart';

import '../../../services/firebase_storage_service.dart';
import '../../../utils/app_snackbar.dart';
import '../user_model/user_model.dart';
import '../user_service/user_service.dart';

class ProfileController extends GetxController {
  bool isLoading = false;
  var isImageLoading = false.obs;
  AppUser? appUser;
  String? errorMessage;
  Future<void> fetchProfileData() async {
    isLoading = true;
    update();
    try {
      appUser = await UserFirestoreService()
          .fetchOneFirestore(FirebaseAuth.instance.currentUser!.uid);
      log("-----appUser-------${appUser?.toJson()}----------");
      isLoading = false;
      update();
    } on FirebaseException catch (e) {
      log("-----f catch-------$e----------");
      isLoading = false;

      errorMessage = e.showErrorMessage();
      update();
    } catch (e) {
      log("-----catch-------$e----------");
      isLoading = false;

      errorMessage = "Please try again";
      update();
    }
  }

  final FirebaseStorageService storageService =
      Get.put(FirebaseStorageService());
  final picker = ImagePicker();
  Future<void> uploadImage(BuildContext context) async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      File imageFile = File(pickedFile.path);

      try {
        isImageLoading.value = true;
        final url = await storageService.uploadFile(imageFile);
        await UserFirestoreService().updateFirestore(
          AppUser(imageUrl: url)..id = FirebaseAuth.instance.currentUser!.uid,
        );
        await fetchProfileData();
      } on FirebaseException catch (e) {
        e.showError(context);
      } catch (e) {
        log("-----storage-------$e----------");

        $showSnackBar(
          context: context,
          message: "Please try again",
          icon: Icons.error_outline_outlined,
        );
      } finally {
        isImageLoading.value = false;
      }
    }
  }
}
