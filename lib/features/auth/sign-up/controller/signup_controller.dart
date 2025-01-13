import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:speak_out_app/features/home/view/home.dart';

import '../../../../services/firebase_auth_service.dart';
import '../../../../services/shared_pref_service.dart';
import '../../../../utils/app_snackbar.dart';
import '../../../user-profile/user_model/user_model.dart';
import '../../../user-profile/user_service/user_service.dart';
import '../../user_type/user_type_enum/user_type_enum.dart';

class SignupController extends GetxController {
  final formKey = GlobalKey<FormState>();
  var isLoading = false.obs;

  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  @override
  void dispose() {
    fullNameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  void onSubmit(BuildContext context) async {
    if (!formKey.currentState!.validate()) {
      return;
    }
    formKey.currentState?.save();

    try {
      isLoading.value = true;

      log("______email_${emailController.text}__pass: ${passwordController.text}______name: ${fullNameController.text}");
      final user = await FirebaseAuthService().handleSignUp(
        emailController.text,
        passwordController.text,
        fullNameController.text,
      );
      await UserFirestoreService().insertFirestoreWithId(
        AppUser(
          email: emailController.text,
          name: fullNameController.text,
          isUserVerified: false,
          role: UserRole.student.role,
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
          imageUrl: "",
        )..id = user.uid,
      );

      log("-------3-${user.displayName}---");
      final loc = SharedPrefService();
      await loc.setAccessToken(await user.getIdToken() ?? '');
      await loc.saveUsername(user.displayName ?? fullNameController.text);

      log("-------4----");
      isLoading.value = false;
      Get.offAll(() => HomePage());
    } on FirebaseAuthException catch (e) {
      log("-------firebase----$e");
      var title = '';
      var error = '';
      final code = e.code;
      if (code == 'network-request-failed') {
        title = 'Internet';
        error = 'Please check your internet connection';
      } else if (code == 'invalid-email') {
        title = 'Invalid Credentials';
        error = 'Email is invalid';
      } else if (code == 'email-already-in-use') {
        title = 'Email already in use';
        error = 'The email address is already in use by another account.';
      } else if (code == 'weak-password') {
        title = 'Weak password';
        error = 'Password should be at least 6 characters';
      } else {
        title = 'Error';
        error = 'Unable to sign up please try again later';
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
