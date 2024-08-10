import 'dart:developer';

import 'package:car_fix_up/Routes/routes.dart';
import 'package:car_fix_up/services/firebase/auth/auth_services.dart';
import 'package:car_fix_up/services/local-storage/localStorage.dart';
import 'package:car_fix_up/shared/common_method.dart';
import 'package:car_fix_up/shared/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignUpController extends GetxController {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final contactNoController = TextEditingController();
  final placeHolderName = "".obs;
  final placeHolderEmail = "".obs;
  final placeHolderPassword = "".obs;
  final placeHolderConfirmPassword = "".obs;
  final placeHolderContactNo = "".obs;
  final rememberMe = true.obs;
  RxBool isLoading = false.obs;

  AuthServices authServices = AuthServices();

  Future<void> signUp() async {
    isLoading.value = true;
    final name = nameController.text;
    final email = emailController.text;
    final password = passwordController.text;
    final contactNo = contactNoController.text;
    //validate all filed first
    if (name.isEmpty ||
        email.isEmpty ||
        password.isEmpty ||
        !validateEmail(email) ||
        !validatePassword(password) ||
        !validateContactNo(contactNo) ||
        !validateConfirmPassword(confirmPasswordController.text) ||
        contactNo.isEmpty) {
      Utils.getErrorSnackBar("All fields are required");
      isLoading.value = false;
      return;
    }
    final result = await authServices.SignUp(name, email, password, contactNo);
    log(result.toString());
    if (result) {
      Utils.getSuccessSnackBar("Account created successfully");
      Get.offAllNamed(RouteName.login);
    }
    isLoading.value = false;
  }

  bool validateEmail(String value) {
    final isValid = GetUtils.isEmail(value);
    if (!isValid) {
      placeHolderEmail.value = "Please enter a valid email";
      return false;
    } else {
      placeHolderEmail.value = "";
      return true;
    }
  }

  bool validatePassword(String value) {
    final hasMinLength = value.length >= 8;
    final hasUpperCase = value.contains(RegExp(r'[A-Z]'));
    final hasNumber = value.contains(RegExp(r'[0-9]'));

    if (!hasMinLength || !hasUpperCase || !hasNumber) {
      placeHolderPassword.value =
          'Password must be at least 8 characters, include an uppercase letter and a number';
      return false;
    } else {
      placeHolderPassword.value = "";
      return true;
    }
  }

  bool validateConfirmPassword(String value) {
    if (value != passwordController.text) {
      placeHolderConfirmPassword.value = "Password does not match";
      return false;
    } else {
      placeHolderConfirmPassword.value = "";
      return true;
    }
  }

  bool validateContactNo(String value) {
    //check for 11 digit number
    if (value.length != 11) {
      placeHolderContactNo.value = "Please enter a valid contact number";
      return false;
    } else {
      placeHolderContactNo.value = "";
      return true;
    }
  }
}
