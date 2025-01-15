import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:speak_out_app/features/home/comment-model/comment_model.dart';
import 'package:speak_out_app/utils/firestore_exception.dart';

import '../../../../utils/app_snackbar.dart';
import '../../../home/comment-service/comment_service.dart';
import '../../../user-profile/user-controller/user_profile_controller.dart';

class CaseDetailController extends GetxController {
  final formKey = GlobalKey<FormState>();
  var isPostingReply = false.obs;
  var isLoadingComments = false.obs;
  final focusNode = FocusNode();

  final TextEditingController commentController = TextEditingController();

  @override
  void dispose() {
    commentController.dispose();

    super.dispose();
  }

  var commentsList = <CommentModel>[].obs;
  var errorMessage = "".obs;

  Future<void> fetchCommentData(String caseId) async {
    isLoadingComments.value = true;

    try {
      commentsList.value = await CommentsFirestoreService()
          .fetchSelected(caseId, "case_id", "created_at");
      isLoadingComments.value = false;
    } on FirebaseException catch (e) {
      log("---------f catch-------------$e-----------------------");
      isLoadingComments.value = false;

      errorMessage.value = e.showErrorMessage();
    } catch (e) {
      isLoadingComments.value = false;
      log("--------catch--------------$e-----------------------");
      errorMessage.value = "Please try again";
    }
  }

  void onPostComment(BuildContext context, String caseId) async {
    if (!formKey.currentState!.validate()) {
      return;
    }
    formKey.currentState?.save();
    FocusScope.of(context).unfocus();
    try {
      isPostingReply.value = true;

      await CommentsFirestoreService().insertFirestore(
        CommentModel(
          userData: Get.find<ProfileController>().appUser,
          createdAt: DateTime.now(),
          comment: commentController.text,
          caseId: caseId,
        ),
      );

      isPostingReply.value = false;
      commentController.clear();
      fetchCommentData(caseId);
    } on FirebaseException catch (e) {
      log("-----firestore catch-------$e----------");
      isPostingReply.value = false;
      e.showError(context);
    } catch (e) {
      isPostingReply.value = false;
      log("-----catch-------$e----------");

      $showSnackBar(
        context: context,
        message: "Please try again",
        icon: Icons.error_outline_outlined,
      );
    }
  }
}
