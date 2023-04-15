
import '../styles/app_colors.dart';

import '../services/local_notificatio.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:permission_handler/permission_handler.dart';
import 'views/splash_view.dart';


//
// Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
//   // await Firebase.initializeApp();
//   // await setupFlutterNotifications();
//   // showFlutterNotification(message);
//   /// If you're going to use other Firebase services in the background, such as Firestore,
//   /// make sure you call `initializeApp` before using other Firebase services.
//   print('Handling a background message ${message.messageId}');
//   print('Handling a background message ${message.notification!.title}');
// }
//
// late AndroidNotificationChannel channel;
//
// bool isFlutterLocalNotificationsInitialized = false;
//
// Future<void> setupFlutterNotifications() async {
//   if (isFlutterLocalNotificationsInitialized) {
//     return;
//   }
//   channel = const AndroidNotificationChannel(
//     'high_importance_channel', // id
//     'High Importance Notifications', // title
//     description:
//     'This channel is used for important notifications.', // description
//     importance: Importance.max,
//   );
//
//    FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
//
//   /// Create an Android Notification Channel.
//   ///
//   /// We use this channel in the `AndroidManifest.xml` file to override the
//   /// default FCM channel to enable heads up notifications.
//   await flutterLocalNotificationsPlugin
//       .resolvePlatformSpecificImplementation<
//       AndroidFlutterLocalNotificationsPlugin>()
//       ?.createNotificationChannel(channel);
//
//   /// Update the iOS foreground notification presentation options to allow
//   /// heads up notifications.
//   await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
//     alert: true,
//     badge: true,
//     sound: true,
//   );
//   isFlutterLocalNotificationsInitialized = true;
// }
//
// void showFlutterNotification(RemoteMessage message) {
//   RemoteNotification? notification = message.notification;
//   AndroidNotification? android = message.notification?.android;
//   if (notification != null && android != null) {
//     flutterLocalNotificationsPlugin.show(
//       notification.hashCode,
//       notification.title,
//       notification.body,
//       NotificationDetails(
//         android: AndroidNotificationDetails(
//           channel.id,
//           channel.name,
//           channelDescription: channel.description,
//           // TODO add a proper drawable resource to android, for now using
//           //      one that already exists in example app.
//           icon: 'launch_background',
//         ),
//       ),
//     );
//   }
// }
//
// /// Initialize the [FlutterLocalNotificationsPlugin] package.
//  late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;


// FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

Future<void> main() async{

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  await FlutterDownloader.initialize(
     // debug: true, // optional: set to false to disable printing logs to console (default: true)
      ignoreSsl: true, // option: set to false to disable working with http links (default: false)
  );

  FirebaseMessaging.instance.onTokenRefresh.listen((fcmToken) async {
     await FirebaseMessaging.instance.setAutoInitEnabled(true);
    // Note: This callback is fired at each app startup and whenever a new
    // token is generated.
  }).onError((err) {
    // Error getting token.
    print('Error getting FCM $err');
  });
  FirebaseMessaging.onBackgroundMessage(LocalNotificationServices.firebaseMessagingBackgroundHandler);
  FirebaseMessaging.onMessage.listen((event) async {
    await Permission.notification.request();
    // if(not.isGranted) {
      LocalNotificationServices.showFlutterNotification(event);
    // }
  //  print('${event.notification!.title}  Foreground state message');
  });
  LocalNotificationServices.setupInteractedMessage();
  // await _flutterLocalNotificationsPlugin.initialize(InitializationSettings(
  //   android:  AndroidInitializationSettings('launcher_icon')
  // ));
  await GetStorage.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'DM Appointment',
     // initialBinding: BindingsBuilder(() => {Get.lazyPut(() => TodayListController())}),
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: AppColors.themeColor),
      ),
     home: const SplashView(),
     //  home: AuthService().handleAuthState(),
    );
  }
}
