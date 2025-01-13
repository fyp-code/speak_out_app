import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:speak_out_app/features/auth/sign-in/view/signin_page.dart';
import 'package:speak_out_app/features/auth/sign-up/controller/signup_controller.dart';

import '../../../../utils/colors.dart';
import '../../../../widgets/app_textfield.dart';
import '../../../../widgets/input_validators.dart';
import '../../../../widgets/primary_button.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final controller = Get.put(SignupController());

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.sizeOf(context);
    return Scaffold(
      backgroundColor: const Color(0xFFF7F8FA),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Obx(
            () => Column(
              children: [
                const SizedBox(height: 40),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 15),
                  decoration: ShapeDecoration(
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    shadows: const [
                      BoxShadow(
                        color: Color(0x19000000),
                        blurRadius: 20,
                        offset: Offset(0, -5),
                        spreadRadius: 0,
                      )
                    ],
                  ),
                  child: Column(
                    children: [
                      Container(
                        width: size.width,
                        padding: const EdgeInsets.fromLTRB(30, 30, 0, 30),
                        decoration: const BoxDecoration(
                          color: AppColors.themeColor,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(8),
                              topRight: Radius.circular(8)),
                        ),
                        child: const Text.rich(
                          TextSpan(
                            children: [
                              TextSpan(
                                text: 'Sign Up',
                                style: TextStyle(
                                  color: Color(0xFF242A37),
                                  fontSize: 34,
                                  fontWeight: FontWeight.w700,
                                  height: 1.18,
                                ),
                              ),
                              TextSpan(
                                text: ' with email\nand password',
                                style: TextStyle(
                                  color: Color(0xFF242A37),
                                  fontSize: 34,
                                  fontWeight: FontWeight.w300,
                                  height: 1.18,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 15),
                        child: Form(
                          key: controller.formKey,
                          child: Column(
                            children: [
                              AppTextField(
                                textEditingController:
                                    controller.fullNameController,
                                label: "Full Name",
                                readOnly: controller.isLoading.value,
                                validator: InputValidators.required(
                                    message: "Name is required"),
                                keyboardType: TextInputType.name,
                                textInputAction: TextInputAction.next,
                                textCapitalization: TextCapitalization.words,
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                              ),
                              const SizedBox(height: 15),
                              AppTextField(
                                label: "Enter email",
                                readOnly: controller.isLoading.value,
                                validator: InputValidators.multiple(
                                  [
                                    InputValidators.required(),
                                    InputValidators.email(),
                                  ],
                                ),
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                textEditingController:
                                    controller.emailController,
                                textInputAction: TextInputAction.next,
                                keyboardType: TextInputType.emailAddress,
                              ),
                              const SizedBox(height: 15),
                              AppPasswordField(
                                textEditingController:
                                    controller.passwordController,
                                readOnly: controller.isLoading.value,
                                label: "Enter password",
                                textInputAction: TextInputAction.next,
                                maxLines: 1,
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                validator: InputValidators.multiple(
                                  [
                                    InputValidators.required(
                                        message: 'Password is required!'),
                                    InputValidators.length(
                                        min: 8,
                                        minMessage:
                                            'Password must be 8 characters long!'),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 15),
                              AppPasswordField(
                                textEditingController:
                                    controller.confirmPasswordController,
                                label: "Enter confirm password",
                                maxLines: 1,
                                readOnly: controller.isLoading.value,
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                textInputAction: TextInputAction.done,
                                validator: (val) {
                                  if (val!.isEmpty) {
                                    return 'Password is required!';
                                  } else if (val !=
                                      controller.passwordController.text) {
                                    return 'Password does not match!';
                                  }
                                  return null;
                                },
                              ),
                              const SizedBox(height: 15),
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
                    ],
                  ),
                ),
                const SizedBox(height: 132),
                Text.rich(
                  TextSpan(
                    children: [
                      const TextSpan(
                        text: 'Already have an account? ',
                        style: TextStyle(
                          color: Color(0xFF242A37),
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                          height: 1.15,
                        ),
                      ),
                      TextSpan(
                        text: 'Sign In',
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            Get.off(() => const SignInScreen());
                          },
                        style: const TextStyle(
                          color: Color(0xFF242A37),
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          height: 1.15,
                        ),
                      ),
                    ],
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 9)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
