import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:speak_out_app/features/auth/user_type/view/user_type.dart';

import '../../../../services/firebase_auth_service.dart';
import '../../../../widgets/case_item.dart';
import '../../../setting/change-password/view/change_password_page.dart';
import '../../../user-profile/view/profile_page.dart';
import '../controller/admin_home_controller.dart';

class AdminHomePage extends StatelessWidget {
  AdminHomePage({super.key});
  final AdminHomeController controller = Get.put(AdminHomeController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Cases"),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Get.to(() => const ProfilePage());
          },
          icon: const Icon(
            Icons.account_circle_outlined,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Get.to(() => ChangePasswordPage());
            },
            icon: const Icon(
              Icons.key_sharp,
            ),
          ),
          IconButton(
            onPressed: () async {
              await FirebaseAuthService().logout();
              Get.offAll(() => const UserType());
            },
            icon: const Icon(
              Icons.logout_rounded,
            ),
          ),
        ],
      ),
      body: Obx(
        () {
          if (controller.isLoading.value) {
            return const Center(child: CircularProgressIndicator());
          }
          if (controller.errorMessage.isNotEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(controller.errorMessage.value,
                      textAlign: TextAlign.center,
                      style: const TextStyle(color: Colors.red, fontSize: 16)),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      controller.fetchCaseData();
                    },
                    child: const Text('Retry'),
                  ),
                ],
              ),
            );
          }
          if (controller.casesList.isEmpty) {
            return const Center(
              child: Text(
                'No case found.',
                textAlign: TextAlign.center,
              ),
            );
          }
          return ListView.builder(
            itemCount: controller.casesList.length,
            padding: const EdgeInsets.all(20),
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.only(top: 10),
                child: CaseItem(
                  caseModel: controller.casesList[index],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
