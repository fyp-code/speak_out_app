import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:speak_out_app/features/auth/sign-up/view/signup_page.dart';
import 'package:speak_out_app/features/auth/user_type/user_type_enum/user_type_enum.dart';

import '../../../../services/shared_pref_service.dart';
import '../../sign-in/view/signin_page.dart';

class UserType extends StatelessWidget {
  const UserType({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Center(
            child: Image.asset(
              "assets/images/usertype_back.jpg",
              fit: BoxFit.fill,
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
            ),
          ),
          Container(
            color: Colors.black.withOpacity(0.5),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                const Text(
                  "Never a better time than now to start.",
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 32,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 20),
                _getTile(
                  "Student",
                  "assets/images/user-icon.svg",
                  () {
                    SharedPrefService().saveUserType(UserRole.student.role);

                    Get.to(() => const SignUpScreen());
                  },
                  false,
                ),
                const SizedBox(height: 20),
                _getTile(
                  "Administrator",
                  "assets/images/user-icon.svg",
                  () {
                    SharedPrefService()
                        .saveUserType(UserRole.administrator.role);
                    Get.to(() => const SignInScreen());
                  },
                  true,
                ),
                const SizedBox(height: 30),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _getTile(
      String title, String iconPath, VoidCallback onTap, bool isDark) {
    return Container(
      height: 50,
      decoration: BoxDecoration(
        color: isDark ? Colors.black : Colors.white,
        border: Border.all(
          color: Colors.white,
        ),
        borderRadius: BorderRadius.circular(100),
      ),
      child: ListTile(
        onTap: onTap,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(100),
        ),
        visualDensity: const VisualDensity(vertical: -1.5, horizontal: -4),
        title: Text(
          "Continue as $title",
          style: TextStyle(
            color: isDark ? Colors.white : Colors.black,
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
        trailing: CircleAvatar(
          backgroundColor: isDark ? Colors.white : Colors.black,
          radius: 9.5,
          child: Center(
            child: Icon(
              CupertinoIcons.arrow_right,
              size: 12,
              color: isDark ? Colors.black : Colors.white,
            ),
          ),
        ),
        leading: SvgPicture.asset(
          iconPath,
          color: isDark ? Colors.white : Colors.black,
        ),
      ),
    );
  }
}
