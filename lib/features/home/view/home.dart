import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:speak_out_app/features/auth/verification/view/verification_page.dart';
import 'package:speak_out_app/features/home/admin-home/view/admin_home.dart';
import 'package:speak_out_app/features/home/student-home/view/student_home.dart';
import 'package:speak_out_app/services/shared_pref_service.dart';

import '../../auth/user_type/user_type_enum/user_type_enum.dart';
import '../../user-profile/user-controller/user_profile_controller.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ProfileController profileController = Get.put(ProfileController());
  @override
  void initState() {
    profileController.fetchProfileData();
    super.initState();
  }

  final isAdmin =
      SharedPrefService().getUserType == UserRole.administrator.role;
  @override
  Widget build(BuildContext context) {
    if (isAdmin) {
      return AdminHomePage();
    } else {
      return Scaffold(
        body: SafeArea(
          child: GetBuilder<ProfileController>(
            builder: (controller) {
              if (controller.isLoading) {
                return const Center(child: CircularProgressIndicator());
              }
              if (controller.errorMessage != null) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(controller.errorMessage!,
                          textAlign: TextAlign.center,
                          style:
                              const TextStyle(color: Colors.red, fontSize: 16)),
                      const SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: () {
                          controller.fetchProfileData();
                        },
                        child: const Text('Retry'),
                      ),
                    ],
                  ),
                );
              }
              if (controller.appUser == null) {
                return const Center(child: Text('No profile data found.'));
              }
              final profileData = controller.appUser!;

              if (profileData.isUserVerified ?? false) {
                return StudentHomePage();
              } else {
                return VerificationPage();
              }
            },
          ),
        ),
      );
    }
  }
}
