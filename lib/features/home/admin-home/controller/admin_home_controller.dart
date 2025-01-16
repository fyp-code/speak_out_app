import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:speak_out_app/features/home/case-mode/case_model.dart';
import 'package:speak_out_app/features/home/case-service/case_service.dart';
import 'package:speak_out_app/utils/firestore_exception.dart';

class AdminHomeController extends GetxController {
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
      casesList.value = await CaseFirestoreService()
          .fetchAllSortedFirestoreFuture("created_at");
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
}
