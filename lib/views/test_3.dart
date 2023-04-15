// import 'package:flutter/material.dart';
// import 'package:permission_handler/permission_handler.dart';
//
//
//
// class MyNotification extends StatefulWidget {
//   const MyNotification({Key? key}) : super(key: key);
//
//   @override
//   State<MyNotification> createState() => _MyNotificationState();
//
// }
//
// class _MyNotificationState extends State<MyNotification> {
//   @override
//   Widget build(BuildContext context) {
//      void checkStatus() async {
//       final notify = await Permission.notification.request();
//       if(notify.isGranted){
//          print('my status.........permission granted');
//       }else{
//         print('my status.........permission not granted');
//       }
//       // FirebaseMessaging messaging = FirebaseMessaging.instance;
//       // NotificationSettings settings = await messaging.requestPermission(
//       //   alert: true,
//       //   announcement: false,
//       //   badge: true,
//       //   carPlay: false,
//       //   criticalAlert: false,
//       //   provisional: false,
//       //   sound: true,
//       // );
//       // print('................${settings.printError}');
//       //
//       // if (settings.authorizationStatus == AuthorizationStatus.authorized) {
//       //   print('..................User granted permission');
//       //
//       // } else if (settings.authorizationStatus == AuthorizationStatus.provisional) {
//       //   print('.......................User granted provisional permission');
//       // } else {
//       //   print('...................User declined or has not accepted permission');
//       // }
//     }
//      Future<void> requestPermission(Permission permission) async {
//        PermissionStatus _permissionStatus = PermissionStatus.granted;
//        final status = await permission.request();
//
//        setState(() {
//          print(status);
//          _permissionStatus = status;
//          print(_permissionStatus);
//        });
//      }
//
//     return Scaffold(
//       body: Center(
//         child: ElevatedButton(
//           onPressed: ()  {
//             checkStatus();
//             //requestPermission(Permission.notification);
//           },
//           child: Text('Notification'),
//         ),
//       ),
//     );
//   }
// }
