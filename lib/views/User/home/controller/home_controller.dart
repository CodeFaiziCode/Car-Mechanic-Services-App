import 'dart:developer';
import 'package:car_fix_up/Routes/routes.dart';
import 'package:car_fix_up/controller/user_controller.dart';
import 'package:car_fix_up/resources/constatnt.dart';
import 'package:car_fix_up/services/firebase/user/user_services.dart';
import 'package:car_fix_up/services/local-storage/localStorage.dart';
import 'package:car_fix_up/shared/utils.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';
import 'package:zego_uikit_signaling_plugin/zego_uikit_signaling_plugin.dart';

class HomeController extends GetxController {
  UserServices userServices = UserServices();
  UserController userController = Get.find<UserController>();
  LocalStorageService localStorageService = LocalStorageService();
  final user = FirebaseAuth.instance.currentUser;
  var userData;

  @override
  void onInit() {
    super.onInit();
    fetchUserData();
    initZegoCallInvitationService();
  }

  void fetchUserData() async {
    userData = await userServices.getUserData();
    saveUserDataInController(userData);
    log('User Data: $userData');
  }

  void saveUserDataInController(DocumentSnapshot userData) {
    userController.setInfo(
      uid: userData["uid"],
      email: userData['email'],
      name: userData['name'],
      userType:
          (userData['userType'] == 'user') ? UserType.user : UserType.vendor,
      contactNo: userData['phone'],
      password: userData['password'],
      deviceToken: userData['deviceToken'],
    );
    localStorageService.saveUid(userData['uid']);
    localStorageService.saveUserType(userData['userType']);
    localStorageService.saveEmail(userData['email']);
    localStorageService.saveName(userData['name']);
    localStorageService.saveContactNo(userData['phone']);
    localStorageService.savePassword(userData['password']);
    localStorageService.saveDeviceToken(userData['deviceToken']);
  }

  void initZegoCallInvitationService() {
    try {
      ZegoUIKitPrebuiltCallInvitationService().init(
          appID: kAppID /*input your AppID*/,
          appSign: kAppSign /*input your AppSign*/,
          userID: "102",
          userName: user!.email!,
          plugins: [ZegoUIKitSignalingPlugin()],
          notificationConfig: ZegoCallInvitationNotificationConfig(
            androidNotificationConfig: ZegoCallAndroidNotificationConfig(
              showFullScreen: true,
            ),
          ),
          invitationEvents: ZegoUIKitPrebuiltCallInvitationEvents(
              onIncomingCallDeclineButtonPressed: () {
            ///  Add your custom logic here.
          }, onIncomingCallAcceptButtonPressed: () {
            ///  Add your custom logic here.
            Get.toNamed(RouteName.videoCall, arguments: "sos_call");
          }));
    } catch (e) {
      Utils.getErrorSnackBar('Error in initializing Zego Call Service $e');
    }
  }

  void sendCallInvitation(
      {required String callID,
      required bool isVideoCall,
      required String resourceID,
      required String id,
      required String name}) {
    try {
      ZegoUIKitPrebuiltCallInvitationService().send(
        callID: callID,
        isVideoCall: isVideoCall,
        resourceID: resourceID,
        invitees: [
          ZegoCallUser(id, name),
        ],
      );
    } catch (e) {
      Utils.getErrorSnackBar('Error in sending call invitation $e');
    }
  }
}
