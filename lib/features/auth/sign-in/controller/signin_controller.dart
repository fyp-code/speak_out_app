import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:speak_out_app/features/user-profile/user_service/user_service.dart';

import '../../../../services/firebase_auth_service.dart';
import '../../../../services/shared_pref_service.dart';
import '../../../../utils/app_snackbar.dart';
import '../../../home/view/home.dart';

class SigninController extends GetxController {
  final formKey = GlobalKey<FormState>();
  var isLoading = false.obs;

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();

    super.dispose();
  }

  void onSubmit(BuildContext context) async {
    if (!formKey.currentState!.validate()) {
      return;
    }
    formKey.currentState?.save();

    log("______email_${emailController.text}__pass: ${passwordController.text}______");
    final firestoreService = FirebaseAuthService();
    try {
      isLoading.value = true;
      final user = await firestoreService.handleSignIn(
        emailController.text.trim().toLowerCase(),
        passwordController.text,
      );

      log("______name : ${user.displayName}________");
      final loc = SharedPrefService();
      await loc.setAccessToken(await user.getIdToken() ?? '');
      await loc.saveUsername(user.displayName ?? "");

      final currentUser =
          await UserFirestoreService().fetchOneFirestore(user.uid);
      log("-----${SharedPrefService().getUserType}-----------${SharedPrefService().getUserType != currentUser.role}----------${currentUser.role}---");
      isLoading.value = false;
      if (SharedPrefService().getUserType != currentUser.role) {
        firestoreService.logout(false);
        $showSnackBar(
          context: context,
          message: "You could not sign in with this role",
          icon: Icons.error_outline_outlined,
        );
      } else {
        Get.offAll(() => HomePage());
      }
    } on FirebaseAuthException catch (e) {
      log("------------$e----------");
      var title = '';
      var error = '';
      final code = e.code;
      if (code == 'network-request-failed') {
        title = 'Internet';
        error = 'Please check your internet connection';
      } else if (code == 'invalid-email') {
        title = 'Invalid Credentials';
        error = 'Email is invalid';
      } else if (code == 'user-not-found') {
        title = 'User not found';
        error = 'User is not found please sign up';
      } else if (code == 'wrong-password' || code == 'invalid-credential') {
        title = 'Invalid Credentials';
        error = 'Email or password is incorrect';
      } else {
        title = 'Error';
        error = e.message ?? 'Unable to sign in please try again later';
      }
      isLoading.value = false;
      log("-----------$title--------");
      $showSnackBar(
        context: context,
        message: error,
        icon: Icons.error_outline_outlined,
      );
    } catch (e) {
      log("----catch-------$e");
      isLoading.value = false;

      $showSnackBar(
        context: context,
        message: "Please try again",
        icon: Icons.error_outline_outlined,
      );
    }
  }
}
