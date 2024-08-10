import 'package:car_fix_up/resources/constatnt.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

class Utils {
  static void fieldFocusChange(
      BuildContext context, FocusNode currentFocus, FocusNode nextFocus) {
    currentFocus.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);
  }

  static toastMessage(String message) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: kPrimaryLightColor,
        textColor: kWhiteColor,
        fontSize: 16.0);
  }

  static getSuccessSnackBar(String message) {
    return Get.snackbar("Success", message,
        icon: const Icon(
          Icons.check_circle,
          color: Colors.green,
        ),
        margin: const EdgeInsets.all(10),
        snackPosition: SnackPosition.TOP,
        backgroundColor: kPrimaryLightColor,
        colorText: kWhiteColor);
  }

  static getErrorSnackBar(String message) {
    return Get.snackbar("Error", message,
        icon: const Icon(
          Icons.error,
          color: Colors.red,
        ),
        margin: const EdgeInsets.all(10),
        snackPosition: SnackPosition.TOP,
        backgroundColor: kPrimaryLightColor,
        colorText: kWhiteColor);
  }
}
