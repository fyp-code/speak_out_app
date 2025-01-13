import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:speak_out_app/services/firebase_auth_service.dart';

import '../../../../utils/app_snackbar.dart';

class ChangePasswordController extends GetxController {
  final formKey = GlobalKey<FormState>();
  var isLoading = false.obs;

  final TextEditingController oldpasswordController = TextEditingController();
  final TextEditingController newpasswordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  @override
  void dispose() {
    oldpasswordController.dispose();
    newpasswordController.dispose();
    confirmPasswordController.dispose();

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
      final currentUser = FirebaseAuthService().auth.currentUser;
      if (currentUser == null) {
        isLoading.value = false;
        $showSnackBar(
          context: context,
          message: "User not logged in",
          icon: Icons.error_outline_outlined,
        );
        return;
      }
      await currentUser.reauthenticateWithCredential(
        EmailAuthProvider.credential(
          email: currentUser.email!,
          password: oldpasswordController.text,
        ),
      );
      currentUser.updatePassword(newpasswordController.text);
      isLoading.value = false;
      Get.back();
      $showSnackBar(
        context: context,
        message: "Password Updated Successfully",
        icon: Icons.error_outline_outlined,
      );
    } on FirebaseException catch (e) {
      log("-----f catch-------$e----------");
      isLoading.value = false;
      var errorMessage = '';
      switch (e.code) {
        case 'invalid-credential':
          errorMessage = 'The old password is incorrect.';
          break;
        case 'wrong-password':
          errorMessage = 'The old password is incorrect.';
          break;
        case 'weak-password':
          errorMessage = 'The new password is too weak.';
          break;
        case 'user-not-found':
          errorMessage = 'No user found with this email.';
          break;
        case 'user-mismatch':
          errorMessage =
              'the credential given does not correspond to the user.';
          break;
        case 'invalid-email':
          errorMessage = 'No user found with this email.';
          break;
        default:
          errorMessage = 'Please try again';
      }
      $showSnackBar(
        context: context,
        message: errorMessage,
        icon: Icons.error_outline_outlined,
      );
    } catch (e) {
      isLoading.value = false;
      log("-----catch-------$e----------");

      $showSnackBar(
        context: context,
        message: "Please try again",
        icon: Icons.error_outline_outlined,
      );
    }
  }
}
