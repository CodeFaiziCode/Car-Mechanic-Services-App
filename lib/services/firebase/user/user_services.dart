import 'dart:developer';

import 'package:car_fix_up/controller/user_controller.dart';
import 'package:car_fix_up/resources/constatnt.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class UserServices extends GetxController {
  final auth = FirebaseAuth.instance;
  final _db = FirebaseFirestore.instance;
  UserController userController = Get.find<UserController>();

  Future<DocumentSnapshot> getUserData() async {
    final user = auth.currentUser;
    if (userController.userType == UserType.user) {
      final userData = await _db.collection('users').doc(user!.uid).get();
      log('User Data: $userData');
      return userData;
    }
    if (userController.userType == UserType.vendor) {
      final userData = await _db.collection('vendors').doc(user!.uid).get();
      log('Vendor Data: $userData');
      return userData;
    }
    throw Exception('User type not recognized');
  }
}
