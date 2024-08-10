import 'dart:convert';
import 'dart:developer';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:firebase_core/firebase_core.dart';
import 'package:googleapis_auth/auth_io.dart' as auth;
import 'package:googleapis/servicecontrol/v1.dart' as servicecontrol;
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import '../../Routes/routes.dart';

class PushNotification {
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  Future<void> initializeLocalNotifications() async {
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    final InitializationSettings initializationSettings =
        InitializationSettings(
      android: initializationSettingsAndroid,
    );

    await flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: (payload) {
        if (payload != null) {
          Map<String, dynamic> data = json.decode(payload.payload!);
          handleNotificationTap(data);
        }
      },
    );
  }

  static void requestPermissions() async {
    FirebaseMessaging messaging = FirebaseMessaging.instance;
    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      log('User granted permission');
    } else if (settings.authorizationStatus ==
        AuthorizationStatus.provisional) {
      log('User granted provisional permission');
    } else {
      log('User declined or has not accepted permission');
    }
  }

  static void handleNotificationTap(Map<String, dynamic> data) {
    String notificationType = data['notification_type'];
    if (notificationType == 'CALL_NOTIFICATION') {
      String callId = data['call_id'];
      Get.toNamed(RouteName.videoCall, arguments: callId);
    } else if (notificationType == 'CLICK_NOTIFICATION') {
      // Navigate to another screen based on your app's requirements
      Get.toNamed(RouteName.dashboard);
    }
  }

  static void showLocalNotification(
      String title, String body, String payload) async {
    FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
        FlutterLocalNotificationsPlugin();
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
      'your channel id',
      'your channel name',
      importance: Importance.max,
      priority: Priority.high,
      showWhen: false,
    );
    const NotificationDetails platformChannelSpecifics =
        NotificationDetails(android: androidPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.show(
      0,
      title,
      body,
      platformChannelSpecifics,
      payload: payload,
    );
  }

  static Future<String> getAccessToken() async {
    List<String> scopes = [
      'https://www.googleapis.com/auth/userinfo.email',
      'https://www.googleapis.com/auth/firebase.database',
      'https://www.googleapis.com/auth/firebase.messaging',
    ];

    http.Client client = await auth.clientViaServiceAccount(
      auth.ServiceAccountCredentials.fromJson(serviceAccountJson),
      scopes,
    );

    auth.AccessCredentials credentials =
        await auth.obtainAccessCredentialsViaServiceAccount(
      auth.ServiceAccountCredentials.fromJson(serviceAccountJson),
      scopes,
      client,
    );

    client.close();

    return credentials.accessToken.data;
  }

  static sendNotification(String deviceToken, String title, String body,
      Map<String, String> data) async {
    final String servrKey = await getAccessToken();
    log('Server key: $servrKey');
    String enPointFirebaseCloudMessage =
        'https://fcm.googleapis.com/v1/projects/car-fix-up/messages:send';
    final Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $servrKey',
    };
    log("Server key: $servrKey");

    final Map<String, dynamic> payload = {
      "message": {
        "token": deviceToken,
        "notification": {"title": title, "body": body},
        "data": data
      }
    };
    final response = await http.post(
      Uri.parse(enPointFirebaseCloudMessage),
      headers: headers,
      body: json.encode(payload),
    );
    log(response.body);
    if (response.statusCode == 200) {
      log('Notification sent');
    } else {
      log('Notification not sent');
    }
  }
}
