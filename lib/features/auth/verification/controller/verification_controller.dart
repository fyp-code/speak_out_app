import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:speak_out_app/utils/firestore_exception.dart';

import '../../../../utils/app_snackbar.dart';
import '../../../setting/setting-service/setting_service.dart';
import '../../../user-profile/user-controller/user_profile_controller.dart';
import '../../../user-profile/user_model/user_model.dart';
import '../../../user-profile/user_service/user_service.dart';

class VerificationController extends GetxController {
  final formKey = GlobalKey<FormState>();
  var isLoading = false.obs;

  final TextEditingController verificationController = TextEditingController();

  @override
  void dispose() {
    verificationController.dispose();

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
      final codeList =
          await SettingFirestoreService().fetchAllFirestoreFuture();
      final code = codeList.first;
      log("---------------${code.verificationCode}-----------------");
      if (code.verificationCode == verificationController.text) {
        await UserFirestoreService().updateFirestore(
          AppUser(
            isUserVerified: true,
          )..id = FirebaseAuth.instance.currentUser?.uid,
        );

        Get.find<ProfileController>().fetchProfileData();
      } else {
        $showSnackBar(
          context: context,
          message: "Verification code is not valid",
          icon: Icons.error_outline_outlined,
        );
      }
      isLoading.value = false;
    } on FirebaseException catch (e) {
      isLoading.value = false;
      e.showError(context);
    } catch (e) {
      isLoading.value = false;

      $showSnackBar(
        context: context,
        message: "Please try again",
        icon: Icons.error_outline_outlined,
      );
    }
  }
}
