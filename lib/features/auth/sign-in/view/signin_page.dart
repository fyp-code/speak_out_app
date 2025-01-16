import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:speak_out_app/features/auth/sign-in/controller/signin_controller.dart';
import 'package:speak_out_app/features/auth/sign-up/view/signup_page.dart';
import 'package:speak_out_app/features/auth/user_type/user_type_enum/user_type_enum.dart';
import 'package:speak_out_app/services/shared_pref_service.dart';

import '../../../../utils/colors.dart';
import '../../../../widgets/app_textfield.dart';
import '../../../../widgets/input_validators.dart';
import '../../../../widgets/primary_button.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final controller = Get.put(SigninController());

  @override
  Widget build(BuildContext context) {
    final isAdmin =
        SharedPrefService().getUserType == UserRole.administrator.role;
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
                                text: 'Sign In',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 34,
                                  fontWeight: FontWeight.w700,
                                  height: 1.18,
                                ),
                              ),
                              TextSpan(
                                text: ' with email\nand password',
                                style: TextStyle(
                                  color: Colors.white,
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
                                label: "Enter email",
                                validator: InputValidators.multiple(
                                  [
                                    InputValidators.required(),
                                    InputValidators.email(),
                                  ],
                                ),
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                readOnly: controller.isLoading.value,
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
                                maxLines: 1,
                                label: "Enter password",
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                textInputAction: TextInputAction.done,
                                validator: InputValidators.multiple(
                                  [
                                    InputValidators.required(
                                        message: 'Password is required!'),
                                    InputValidators.length(
                                      min: 8,
                                      minMessage:
                                          'Password must be 8 characters long!',
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 15),
                              AppButton(
                                onPressed: () => controller.onSubmit(context),
                                isLoading: controller.isLoading.value,
                                text: "Sign In",
                                textColor: AppColors.white,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                if (!isAdmin) ...[
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
                          text: 'Sign Up',
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              Get.off(() => const SignUpScreen());
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
                ],
                const SizedBox(height: 9)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
