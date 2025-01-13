import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:speak_out_app/features/auth/user_type/view/user_type.dart';

import '../../../../services/firebase_auth_service.dart';

class AdminHomePage extends StatelessWidget {
  const AdminHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: TextButton(
          onPressed: () async {
            await FirebaseAuthService().logout();
            Get.offAll(() => const UserType());
          },
          child: const Text("Admin Logout"),
        ),
      ),
    );
  }
}
