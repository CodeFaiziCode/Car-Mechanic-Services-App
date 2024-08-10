import 'dart:developer';

import 'package:car_fix_up/Routes/routes.dart';
import 'package:car_fix_up/services/firebase/auth/auth_services.dart';
import 'package:car_fix_up/services/local-storage/localStorage.dart';
import 'package:car_fix_up/shared/utils.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final placeHolderEmail = "".obs;
  final placeHolderPassword = "".obs;
  final rememberMe = true.obs;
  final isLoading = false.obs;
  AuthServices authServices = AuthServices();
  LocalStorageService localStorageService = LocalStorageService();

  Future<void> login() async {
    isLoading.value = true;
    final email = emailController.text;
    final password = passwordController.text;
    if (email.isEmpty || password.isEmpty) {
      Utils.getErrorSnackBar("All fields are required");
      isLoading.value = false;
      return;
    }
    final result = await authServices.Login(email, password);
    final auth = FirebaseAuth.instance;
    final user = auth.currentUser;
    String uid = user!.uid;
    //log(result.toString());
    if (result) {
      Utils.getSuccessSnackBar("Login successfully");
      FirebaseMessaging.instance.onTokenRefresh.listen((String token) async {
        log("===Token Refreshed===");
        log(token);
        await FirebaseFirestore.instance
            .collection('users')
            .doc(uid)
            .update({'deviceToken': token});
        localStorageService.saveDeviceToken(token);
      });

      Get.offAllNamed(RouteName.dashboard);
      isLoading.value = false;
    }
    isLoading.value = false;
  }

  void validateEmail(String value) {
    final isValid = GetUtils.isEmail(value);
    if (!isValid) {
      placeHolderEmail.value = "Please enter a valid email";
    } else {
      placeHolderEmail.value = "";
    }
  }

  void validatePassword(String value) {
    final hasMinLength = value.length >= 8;

    if (!hasMinLength) {
      placeHolderPassword.value = 'Password must be at least 8 characters';
    } else {
      placeHolderPassword.value = "";
    }
  }
}
