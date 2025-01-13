import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:speak_out_app/features/auth/user_type/view/user_type.dart';
import 'package:speak_out_app/features/cases/add-case/view/add_case_page.dart';
import 'package:speak_out_app/widgets/case_item.dart';

import '../../../../services/firebase_auth_service.dart';
import '../controller/student_home_controller.dart';

class StudentHomePage extends StatelessWidget {
  StudentHomePage({super.key});
  final StudentHomeController controller = Get.put(StudentHomeController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Cases"),
        centerTitle: true,
        actions: [
          TextButton(
            onPressed: () async {
              await FirebaseAuthService().logout();
              Get.offAll(() => const UserType());
            },
            child: const Icon(
              Icons.logout_rounded,
            ),
          ),
        ],
      ),
      body: Obx(() {
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
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Get.to(() => AddCasePage());
          print("--------------------------------");
          controller.fetchCaseData();
        },
        child: const Icon(
          Icons.add,
        ),
      ),
    );
  }
}
