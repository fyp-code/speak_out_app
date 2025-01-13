import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:speak_out_app/utils/firestore_exception.dart';

import '../user_model/user_model.dart';
import '../user_service/user_service.dart';

class ProfileController extends GetxController {
  bool isLoading = false;
  AppUser? appUser;
  String? errorMessage;
  Future<void> fetchProfileData() async {
    isLoading = true;
    update();
    try {
      appUser = await UserFirestoreService()
          .fetchOneFirestore(FirebaseAuth.instance.currentUser!.uid);
      isLoading = false;
      update();
    } on FirebaseException catch (e) {
      isLoading = false;

      errorMessage = e.showErrorMessage();
      update();
    } catch (e) {
      isLoading = false;

      errorMessage = "Please try again";
      update();
    }
  }
}
