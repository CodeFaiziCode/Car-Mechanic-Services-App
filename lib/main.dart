import 'dart:developer';
import 'package:car_fix_up/Routes/routes.dart';
import 'package:car_fix_up/firebase_options.dart';
import 'package:car_fix_up/resources/constatnt.dart';
import 'package:car_fix_up/services/notification/push_notification.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';
import 'package:zego_uikit_signaling_plugin/zego_uikit_signaling_plugin.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  //ZegoUIKitPrebuiltCallInvitationService().setNavigatorKey(navigatorKey);
  // // call the useSystemCallingUI
  // ZegoUIKit().initLog().then((value) {
  //   ZegoUIKitPrebuiltCallInvitationService().useSystemCallingUI(
  //     [ZegoUIKitSignalingPlugin()],
  //   );
  // });

  PushNotification().initializeLocalNotifications();

  runApp(const MyApp());
}

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  log("===Incoming message===");
  log("Handling a background message: ${message.messageId}");
  log("Handling a background message: ${message.data}");
  log("Handling a background message: ${message.notification}");
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  @pragma('vm:entry-point')
  void initState() {
    super.initState();
    PushNotification.requestPermissions();
    FirebaseMessaging.instance.getInitialMessage();
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      log("===Incoming message===");
      log("Handling a background message: ${message.messageId}");
      log("Handling a background message: ${message.data}");
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;

      if (notification != null && android != null) {
        PushNotification.showLocalNotification(
            notification.title!, notification.body!, message.data.toString());
      }
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print('A new onMessageOpenedApp event was published!');
      log("===Incoming message===");
      log("Handling a background message: ${message.messageId}");
      log("Handling a background message: ${message.data}");
      PushNotification.handleNotificationTap(message.data);
    });
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      child: GetMaterialApp(
        debugShowCheckedModeBanner: false,
        getPages: AppRoutes.appRoute(),
      ),
    );
  }
}
