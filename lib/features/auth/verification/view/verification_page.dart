import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:speak_out_app/features/auth/verification/controller/verification_controller.dart';

import '../../../../utils/colors.dart';
import '../../../../widgets/app_textfield.dart';
import '../../../../widgets/input_validators.dart';
import '../../../../widgets/primary_button.dart';

class VerificationPage extends StatelessWidget {
  VerificationPage({super.key});
  final controller = Get.put(VerificationController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Obx(
        () => SafeArea(
          child: SizedBox(
            width: MediaQuery.sizeOf(context).width,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 32),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 200,
                    height: 200,
                    decoration: BoxDecoration(
                      color: Colors.deepPurple.shade50,
                      shape: BoxShape.circle,
                    ),
                    child: Image.asset(
                      'assets/images/illustration-3.png',
                    ),
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  const Text(
                    'Verification',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Text(
                    "Enter your administration code number",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.black38,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(
                    height: 28,
                  ),
                  Container(
                    padding: const EdgeInsets.all(28),
                    decoration: ShapeDecoration(
                      color: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      shadows: const [
                        BoxShadow(
                          color: Color(0x19000000),
                          blurRadius: 10,
                          offset: Offset(0, 3),
                          spreadRadius: 0,
                        )
                      ],
                    ),
                    child: Column(
                      children: [
                        Form(
                          key: controller.formKey,
                          child: Column(
                            children: [
                              AppTextField(
                                hint: "Enter verification code",
                                validator: InputValidators.required(
                                    message: "Verification code required"),
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                readOnly: controller.isLoading.value,
                                textEditingController:
                                    controller.verificationController,
                                textInputAction: TextInputAction.done,
                                keyboardType: TextInputType.text,
                              ),
                              const SizedBox(height: 22),
                              AppButton(
                                onPressed: () => controller.onSubmit(context),
                                isLoading: controller.isLoading.value,
                                text: "Verify",
                                textColor: AppColors.white,
                                backgroundColor: const Color(0xFF242A37),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
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
