import 'dart:developer';
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:speak_out_app/features/home/case-mode/case_model.dart';
import 'package:speak_out_app/utils/firestore_exception.dart';

import '../../../../services/firebase_storage_service.dart';
import '../../../../utils/app_snackbar.dart';
import '../../../../utils/case_status_enum.dart';
import '../../../home/case-service/case_service.dart';

class AddCaseController extends GetxController {
  final formKey = GlobalKey<FormState>();
  var isLoading = false.obs;

  final TextEditingController typeController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final FirebaseStorageService storageService =
      Get.put(FirebaseStorageService());

  @override
  void dispose() {
    typeController.dispose();
    descriptionController.dispose();

    super.dispose();
  }

  void onSubmit(BuildContext context) async {
    if (!formKey.currentState!.validate()) {
      return;
    }
    formKey.currentState?.save();
    FocusScope.of(context).unfocus();

    try {
      isLoading.value = true;
      List<String> imagesUrl = [];
      if (imagesList.isNotEmpty) {
        for (var element in imagesList) {
          final url = await storageService.uploadFile(element);
          imagesUrl.add(url);
        }
      }
      await CaseFirestoreService().insertFirestore(
        CaseModel(
          userId: FirebaseAuth.instance.currentUser?.uid,
          createdAt: DateTime.now(),
          description: descriptionController.text,
          images: imagesUrl,
          type: typeController.text,
          status: CaseStatus.pending.status,
        ),
      );

      isLoading.value = false;
      Get.back();
    } on FirebaseException catch (e) {
      isLoading.value = false;
      e.showError(context);
    } catch (e) {
      isLoading.value = false;
      log("-----storage-------$e----------");

      $showSnackBar(
        context: context,
        message: "Please try again",
        icon: Icons.error_outline_outlined,
      );
    }
  }

  List<File> imagesList = <File>[].obs;
  final ImagePicker _picker = ImagePicker();
  var isPickingImage = false.obs;

  Future<void> pickImages() async {
    if (isPickingImage.value) return;
    isPickingImage.value = true;
    try {
      final List<XFile> pickedFile = await _picker.pickMultiImage();

      if (pickedFile.isNotEmpty) {
        for (var element in pickedFile) {
          imagesList.add(File(element.path));
        }
      }
    } catch (e) {
      log("__________${e}__________");
    } finally {
      isPickingImage.value = false;
    }
  }
}
