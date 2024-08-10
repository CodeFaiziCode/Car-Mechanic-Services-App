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
    final serviceAccountJson = {
      "type": "service_account",
      "project_id": "car-fix-up",
      "private_key_id": "c7243eca2a02fd352200900d6c88790db7767f40",
      "private_key":
          "-----BEGIN PRIVATE KEY-----\nMIIEvgIBADANBgkqhkiG9w0BAQEFAASCBKgwggSkAgEAAoIBAQCyapnsfUkHPOcZ\nLAgND7oPC4+insWuwiGa16ju56prP/laL/GsgKj7T0t+3mNYMvHuVzz/oas0a7OI\ncfH6QZnJ3BCO9uqvnRKOXC6ldXMQq2zoLgkv9+YbNhPWsE53zGQJ8T7vAO30gIBw\n1w/HBf7GUQtVdDXIVzsF0TSaTjCZOkbM0RSVK22hqrzAaS/raYwMOLTwYjmuSoUI\nkT1uJoR1LNrE+gZ13D7PMpwk+mgzCRD1BfmuEg3a7ct7JuVst1LrkcjUdBSjr2AU\nVRVbkHQvyiCFfK4wR+JyCw8c/ZB816ao4qW1Az4xzcqSE9crzBHvHSfXm9lAZ3sZ\n9TfbvcDBAgMBAAECggEAO8eA/F58BgtPaT06E1pGHn1iqnulQ6kzBkUlCqsfjCDa\nxO+Ue5Z+R/npE0CjK62iJxgezY4XJZDCjkCTcaTiSOLNv4EW4DFyQrW7QWAJZjfx\n3Rdzp5lZhZuIaSIYoIYgrL4itoTqtcYKgwRj+mzVURBdikvOK2qi0Y+nnt385ZG0\nUv+8d3Pdwrl9qh1z+b+gGfpYXRmROXUevYW8227bXuPqH91/uy5WtGGvxZxRmhUE\nEtMO4baYLglgWLNA2DlXzTJoUBFEbshXRO117zuHJz902ydek0SgxuV0EGxj1O5o\na9rvxTgbOIjEO4pncfBjg1bH1szgW7AXyU5WpVgsewKBgQDdQN6mud4iAsMSZo6a\nuOZhNEymXtGd7p+VshyffUf93NCck+MsEN/fX/z7rCEf+sXsVIvqadQ82U4oijtE\nuhIRITNOd8adWbyjCWgtBvBRjIwgaL7QuXA0oZs5XHqFCI2hfFnEqPOYX8pg2mO9\nZWLv0ld1kEp3AaM6JvcK6acExwKBgQDOb4prZQAvPkQSI2VzQ2j0jhube9ocTJz7\nvxJxf0wAAJyhwbWw9WWmKcARaiz4GVBVKxTZ3j4n4IZczzKNAdOvpBGkupE2Qgpn\ngI+2Vlh3hlcAJV3APa9eot4Tq8QxyfymuIGtuCnH1/iM0rXasAvKizhXtDFZwFaQ\n/aWr9hh2NwKBgQCl4wpM9VTAKVP7Ctvm07Ufsme54aPGhvAt+6IMTpFYnGPo0dTk\n6C4CO+ThCXi4knwtKmLROdHAYamBKcswR1Zec4cVUSagOXT+xIHQKMCsU/WIIyDW\nPAMN4xEP2++cqQIPzr07fvVNDJ0fKv7XNRoN96ZNZgb+3UJ1yls1WmQ4ZwKBgA44\nyv15GNkoXgIt5BhbxYhLngVJNA6NDKefU0L0dSTu5duS/9RwI4+eArhwayawf8NO\nU4Jq+DdBFaChOadTP+Uy1XBW1hg51oOo7L2wFyos3COLb3kGBuXrLIeIZtzTQI+v\n2GdCb8Zvz5TME3E8faN3kesg4+F+Cbi1cMt3CdpjAoGBALo0FdTEJwJmjIJ/iz/8\nlzSm+5KUa4anwapV/6OS1MfWG+QcSTAH42kdJVSx5FWjadRCqiG82Dd+QkuCl6yi\neheoINB/CRdKHJbx/YUo8VGa2PqUwrFyG1vrbqCKpCgUuH443voC9aNNKemt7wKl\nJknemAThx6X5aorT6TST7bVJ\n-----END PRIVATE KEY-----\n",
      "client_email": "carfixupadmin@car-fix-up.iam.gserviceaccount.com",
      "client_id": "115696344430186044321",
      "auth_uri": "https://accounts.google.com/o/oauth2/auth",
      "token_uri": "https://oauth2.googleapis.com/token",
      "auth_provider_x509_cert_url":
          "https://www.googleapis.com/oauth2/v1/certs",
      "client_x509_cert_url":
          "https://www.googleapis.com/robot/v1/metadata/x509/carfixupadmin%40car-fix-up.iam.gserviceaccount.com",
      "universe_domain": "googleapis.com"
    };
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
