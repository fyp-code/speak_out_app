import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../utils/colors.dart';
import '../user-controller/user_profile_controller.dart';
import '../widgets/profile_item.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        title: const Text(
          "Profile",
          style: TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 16,
            color: AppColors.black,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 22.0, vertical: 24),
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
            return Column(
              children: [
                Obx(
                  () => controller.isImageLoading.value
                      ? const CircularProgressIndicator()
                      : GestureDetector(
                          onTap: () => controller.uploadImage(context),
                          child: Container(
                            width: 150,
                            height: 150,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              image: controller.appUser!.imageUrl!.isNotEmpty
                                  ? DecorationImage(
                                      image: NetworkImage(
                                          controller.appUser!.imageUrl!),
                                      fit: BoxFit.cover,
                                    )
                                  : null,
                              color: Colors.grey[300],
                            ),
                            child: controller.appUser!.imageUrl!.isEmpty
                                ? const Icon(
                                    Icons.camera_alt,
                                    size: 50,
                                    color: Colors.white,
                                  )
                                : null,
                          ),
                        ),
                ),
                const SizedBox(height: 20),
                ProfileItem(
                  title: "NAME",
                  subtitle: profileData.name ?? "",
                ),
                ProfileItem(
                  title: "EMAIL",
                  subtitle: profileData.email ?? "",
                ),
                ProfileItem(
                  title: "ROLE",
                  subtitle: profileData.role ?? "",
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
