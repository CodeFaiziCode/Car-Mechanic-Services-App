import 'dart:developer';

import 'package:car_fix_up/Routes/routes.dart';
import 'package:car_fix_up/resources/constatnt.dart';
import 'package:car_fix_up/shared/button.dart';
import 'package:car_fix_up/shared/textfield.dart';
import 'package:car_fix_up/shared/utils.dart';
import 'package:car_fix_up/views/User/auth/controller/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    AuthController controller = AuthController();
    return Scaffold(
      backgroundColor: kGreyText,
      resizeToAvoidBottomInset: true,
      body: SingleChildScrollView(
        child: SizedBox(
          height: 1.sh,
          width: 1.sw,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(kScheduledService, width: 300.w),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 100.w,
                      height: 2.h,
                      color: kPrimaryColor,
                    ),
                    Text(" Car Fix Up ",
                        style: GoogleFonts.oxanium(
                            fontSize: 15.sp,
                            fontWeight: FontWeight.bold,
                            color: kPrimaryLightColor)),
                    Container(
                      width: 100.w,
                      height: 2.h,
                      color: kPrimaryColor,
                    ),
                  ],
                ),
                SizedBox(height: 20.h),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text("Login",
                      style: GoogleFonts.oxanium(
                          fontSize: 30.sp,
                          fontWeight: FontWeight.bold,
                          color: kWhiteColor)),
                ),
                SizedBox(height: 10.h),
                Obx(
                  () => CustomTextField(
                    hintText: "  Email",
                    controller: controller.emailController,
                    inputType: TextInputType.emailAddress,
                    placeHolder: controller.placeHolderEmail.value,
                    onChanged: (value) {
                      log(value);
                      controller.validateEmail(value);
                    },
                  ),
                ),
                SizedBox(height: 5.h),
                Obx(
                  () => CustomTextField(
                    hintText: "  Password",
                    controller: controller.passwordController,
                    inputType: TextInputType.visiblePassword,
                    isPasswordField: true,
                    placeHolder: controller.placeHolderPassword.value,
                    onChanged: (value) {
                      log(value);
                      controller.validatePassword(value);
                    },
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Get.toNamed('/forgot-password');
                  },
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: Text("Forgot Password?",
                        style: GoogleFonts.oxanium(
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w500,
                            color: kWhiteColor)),
                  ),
                ),
                SizedBox(height: 10.h),
                Obx(
                  () => CustomButton(
                    text: "Login",
                    onPressed: () async {
                      controller.login();
                    },
                    textColor: kWhiteColor,
                    isLoading: controller.isLoading.value,
                    buttonColor: kPrimaryLightColor,
                  ),
                ),
                // GestureDetector(
                //   onTap: () async {
                //     final String res = await controller.login();
                //     if (res == "Success") {
                //       Get.offAllNamed(RouteName.dashboard);
                //     } else {
                //       Utils.getErrorSnackBar(res);
                //     }
                //   },
                //   child: Container(
                //     height: 50.h,
                //     width: 1.sw,
                //     decoration: BoxDecoration(
                //       color: kPrimaryLightColor,
                //       borderRadius: BorderRadius.circular(50),
                //     ),
                //     child: Center(
                //       child: Text("Login",
                //           style: GoogleFonts.oxanium(
                //               fontSize: 20.sp,
                //               fontWeight: FontWeight.bold,
                //               color: kWhiteColor)),
                //     ),
                //   ),
                //),
                SizedBox(height: 20.h),
                //Dont have an account? Sign Up (Make SignUP WORD COLOR kPrimaryColor)
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Don't have an account? ",
                        style: GoogleFonts.oxanium(
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w500,
                            color: kWhiteColor)),
                    InkWell(
                      onTap: () {
                        Get.toNamed(RouteName.signup);
                      },
                      child: Text("Sign Up",
                          style: GoogleFonts.oxanium(
                              decorationThickness: 2,
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w500,
                              color: kPrimaryColor)),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
