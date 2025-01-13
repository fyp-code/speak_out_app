import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../utils/colors.dart';
import '../../../../widgets/app_textfield.dart';
import '../../../../widgets/field_label.dart';
import '../../../../widgets/input_validators.dart';
import '../../../../widgets/primary_button.dart';
import '../controller/change_password_controller.dart';

class ChangePasswordPage extends StatelessWidget {
  ChangePasswordPage({super.key});
  final controller = Get.put(ChangePasswordController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Change Password"),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
          child: Obx(
            () => Form(
              key: controller.formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const FieldLabel("Enter Old password"),
                  AppPasswordField(
                    textEditingController: controller.oldpasswordController,
                    readOnly: controller.isLoading.value,
                    hint: "Enter Old password",
                    textInputAction: TextInputAction.next,
                    maxLines: 1,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: InputValidators.required(
                        message: 'Old Password is required!'),
                  ),
                  const SizedBox(height: 20),
                  const FieldLabel("Enter password"),
                  AppPasswordField(
                    textEditingController: controller.newpasswordController,
                    readOnly: controller.isLoading.value,
                    hint: "Enter password",
                    textInputAction: TextInputAction.next,
                    maxLines: 1,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: InputValidators.multiple(
                      [
                        InputValidators.required(
                            message: 'Password is required!'),
                        InputValidators.length(
                            min: 8,
                            minMessage: 'Password must be 8 characters long!'),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  const FieldLabel("Enter confirm password"),
                  AppPasswordField(
                    textEditingController: controller.confirmPasswordController,
                    hint: "Enter confirm password",
                    maxLines: 1,
                    readOnly: controller.isLoading.value,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    textInputAction: TextInputAction.done,
                    validator: (val) {
                      if (val!.isEmpty) {
                        return 'Password is required!';
                      } else if (val != controller.newpasswordController.text) {
                        return 'Password does not match!';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 30),
                  AppButton(
                    onPressed: () => controller.onSubmit(context),
                    isLoading: controller.isLoading.value,
                    text: "Sign Up",
                    textColor: AppColors.white,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
