import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:speak_out_app/features/home/case-mode/case_model.dart';
import 'package:speak_out_app/features/home/case-service/case_service.dart';
import 'package:speak_out_app/utils/firestore_exception.dart';

import '../../../../utils/app_snackbar.dart';

class StudentHomeController extends GetxController {
  @override
  void onInit() {
    fetchCaseData();
    super.onInit();
  }

  var isLoading = false.obs;
  var isDeleteLoading = false.obs;

  var casesList = <CaseModel>[].obs;
  var errorMessage = "".obs;

  Future<void> fetchCaseData() async {
    isLoading.value = true;

    try {
      casesList.value = await CaseFirestoreService().fetchSelected(
          FirebaseAuth.instance.currentUser?.uid, "user_id", "created_at");
      isLoading.value = false;
    } on FirebaseException catch (e) {
      log("---------f catch-------------$e-----------------------");
      isLoading.value = false;

      errorMessage.value = e.showErrorMessage();
    } catch (e) {
      isLoading.value = false;
      log("--------catch--------------$e-----------------------");
      errorMessage.value = "Please try again";
    }
  }

  void onDeleteCase(BuildContext context, String id) async {
    try {
      isDeleteLoading.value = true;

      await CaseFirestoreService().deleteFirestore(id);

      isDeleteLoading.value = false;
      fetchCaseData();
    } on FirebaseException catch (e) {
      isDeleteLoading.value = false;
      e.showError(context);
    } catch (e) {
      isDeleteLoading.value = false;
      log("-----storage-------$e----------");

      $showSnackBar(
        context: context,
        message: "Please try again",
        icon: Icons.error_outline_outlined,
      );
    }
  }
}
