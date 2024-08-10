import 'dart:developer';

import 'package:car_fix_up/resources/constatnt.dart';
import 'package:get/get.dart';

class UserController extends GetxController {
  late String _uid;
  late String _name;
  late String _email;
  late String _password;
  late String _contactNo;
  late UserType _userType;
  late String _deviceToken;

  //Getter
  String get uid => _uid;
  String get name => _name;
  String get email => _email;
  String get password => _password;
  String get contactNo => _contactNo;
  UserType get userType => _userType;
  String get deviceToken => _deviceToken;

  // Setters
  set uid(String value) {
    _uid = value;
  }

  set name(String value) {
    _name = value;
  }

  set email(String value) {
    _email = value;
  }

  set password(String value) {
    _password = value;
  }

  set contactNo(String value) {
    _contactNo = value;
  }

  set userType(UserType value) {
    _userType = value;
  }

  set deviceToken(String value) {
    _deviceToken = value;
  }

  void setInfo({
    required String uid,
    required String name,
    required String email,
    required String password,
    required String contactNo,
    required UserType userType,
    required String deviceToken,
  }) {
    log('Setting user info: $uid, $name, $email, $password, $contactNo, $userType, $deviceToken');
    this.uid = uid;
    this.name = name;
    this.email = email;
    this.password = password;
    this.contactNo = contactNo;
    this.userType = userType;
    this.deviceToken = deviceToken;
  }
}
