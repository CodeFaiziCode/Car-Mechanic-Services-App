import 'package:car_fix_up/resources/constatnt.dart';
import 'package:car_fix_up/shared/button.dart';
import 'package:car_fix_up/shared/textfield.dart';
import 'package:car_fix_up/views/User/auth/controller/signup_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class SignupView extends StatelessWidget {
  const SignupView({super.key});

  @override
  Widget build(BuildContext context) {
    SignUpController signUpController = SignUpController();
    return Scaffold(
      backgroundColor: kGreyText,
      resizeToAvoidBottomInset: true,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                children: [
                  30.h.verticalSpace,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(" Car Fix Up ",
                          style: GoogleFonts.oxanium(
                              fontSize: 24.sp,
                              fontWeight: FontWeight.bold,
                              color: kPrimaryColor)),
                      SvgPicture.asset("assets/images/car.svg", width: 100.w),
                    ],
                  ),
                  const SizedBox(height: 20),
                  // Welcoming Text
                  Text(
                    "Welcome to Car Fix Up!",
                    style: GoogleFonts.oxanium(
                        fontSize: 28.sp,
                        fontWeight: FontWeight.bold,
                        color: kPrimaryColor),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 10),
                  Text(
                    "Please fill in the details below to create an account.",
                    style: GoogleFonts.oxanium(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.normal,
                        color: kPrimaryColor),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 20),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text("Signup",
                        style: GoogleFonts.oxanium(
                            fontSize: 30.sp,
                            fontWeight: FontWeight.bold,
                            color: kPrimaryColor)),
                  ),
                  const SizedBox(height: 10),
                  //Name
                  Obx(
                    () => CustomTextField(
                      inputType: TextInputType.text,
                      hintText: "Name",
                      controller: signUpController.nameController,
                      onChanged: (value) {},
                      placeHolder: signUpController.placeHolderName.value,
                    ),
                  ),
                  Obx(
                    () => CustomTextField(
                      inputType: TextInputType.emailAddress,
                      hintText: "Email",
                      controller: signUpController.emailController,
                      onChanged: (value) {
                        signUpController.validateEmail(value);
                      },
                      placeHolder: signUpController.placeHolderEmail.value,
                    ),
                  ),
                  Obx(
                    () => CustomTextField(
                      inputType: TextInputType.text,
                      hintText: "Password",
                      isPasswordField: true,
                      controller: signUpController.passwordController,
                      onChanged: (value) {
                        signUpController.validatePassword(value);
                      },
                      placeHolder: signUpController.placeHolderPassword.value,
                    ),
                  ),
                  Obx(
                    () => CustomTextField(
                      inputType: TextInputType.text,
                      hintText: "Confirm Password",
                      isPasswordField: true,
                      controller: signUpController.confirmPasswordController,
                      onChanged: (value) {
                        signUpController.validateConfirmPassword(value);
                      },
                      placeHolder:
                          signUpController.placeHolderConfirmPassword.value,
                    ),
                  ),
                  Obx(
                    () => CustomTextField(
                      inputType: TextInputType.phone,
                      hintText: "Contact No",
                      controller: signUpController.contactNoController,
                      onChanged: (value) {
                        signUpController.validateContactNo(value);
                      },
                      placeHolder: signUpController.placeHolderContactNo.value,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: Obx(
                  () => CustomButton(
                    text: "Signup",
                    onPressed: () async {
                      signUpController.signUp();
                    },
                    isLoading: signUpController.isLoading.value,
                    textColor: kWhiteColor,
                    buttonColor: kPrimaryColor,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
