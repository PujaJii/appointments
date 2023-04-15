import 'package:app_settings/app_settings.dart';
import 'package:permission_handler/permission_handler.dart';

import '../services/local_notificatio.dart';
import '../styles/common_module/app_bar.dart';
import '../views/log_history.dart';
import '../views/vip_page.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import '../styles/app_colors.dart';
import '../utils/constants/size_orientation.dart';
import 'add_appointments.dart';
import 'all_appointments.dart';
import 'home_page.dart';


class BottomNavPage extends StatefulWidget {
  const BottomNavPage({Key? key}) : super(key: key);

  @override
  State<BottomNavPage> createState() => _BottomNavPageState();
}


final ScrollController scrollController = ScrollController();

class _BottomNavPageState extends State<BottomNavPage> {
  var box = GetStorage();
  final List<Widget> _screens =
  [
    const HomePage(),
    const VipPage(),
    const AddNew(),
    const Appointments(),
    const LogHistory(),
  ];

  int initValue = 0;
  int counter = 0;

  // var flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
  // void showNotification(){
  //   counter ++;
  //   flutterLocalNotificationsPlugin.show(0, 'My notification', '$counter', NotificationDetails(
  //       android: AndroidNotificationDetails(
  //         'channel.id1',
  //         'channel.name1',
  //         channelDescription: 'channel.description1',
  //         importance: Importance.max,
  //         icon: '@mipmap/launcher_icon',
  //       )
  //   ));
  // }
  // void showFlutterNotification(RemoteMessage message) {
  //   RemoteNotification? notification = message.notification;
  //   AndroidNotification? android = message.notification!.android;
  //   if (notification != null && android != null) {
  //     flutterLocalNotificationsPlugin.show(
  //       notification.hashCode,
  //       notification.title,
  //       notification.body,
  //       NotificationDetails(
  //         android: AndroidNotificationDetails(
  //           'channel.id1',
  //           'channel.name1',
  //           channelDescription: 'channel.description1',
  //           icon: '@mipmap/ic_launcher',
  //         ),
  //       ),
  //     );
  //   }
  // }
  Future<void> getContactPermission() async {
    if (await Permission.notification.isGranted) {

    } else {
      await AppSettings.openNotificationSettings();
      await Permission.notification.request();
    }
    // if (await Permission.phone.isGranted) {
    //
    // } else {
    //   await Permission.phone.request();
    // }
    // if (await Permission.contacts.isGranted) {
    //
    // } else {
    //   await Permission.contacts.request();
    // }
  }

  @override
  void initState() {
   LocalNotificationServices.initialize();
    // FirebaseMessaging.instance.getInitialMessage().then((value) {
    //   if(value != null){
    //     print('${value.notification!.title}  Terminated state message');
    //   }
    // });
    // FirebaseMessaging.onMessage.listen((event) {
    //   LocalNotificationServices.showFlutterNotification(event);
    //   print('${event.notification!.title}  Foreground state message');
    // });
    // FirebaseMessaging.onMessageOpenedApp.listen((event) {
    //   print('${event.notification!.title}   Background state message');
    // });
    // FirebaseMessaging.onMessage.listen((event) async {
    //   await Permission.notification.request();
    //   // if(not.isGranted) {
    //   LocalNotificationServices.showFlutterNotification(event);
    //   // }
    //   //  print('${event.notification!.title}  Foreground state message');
    // });
    // FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
    //   print('A new onMessageOpenedApp event was published!');
    //   RemoteNotification? notification = message.notification;
    //   AndroidNotification? android = message.notification!.android;
    //   if (notification != null && android != null) {
    //     MySnackbar.infoSnackBar('title', notification.body!);
    //   }
      // Navigator.pushNamed(
      //   context,
      //   '/message',
      //   arguments: MessageArguments(message, true),
      // );
    // });
    getContactPermission();
    super.initState();
  }
  //late AndroidNotificationChannel channel;
  @override
  Widget build(BuildContext context) {
    Future<bool> showExitPopup() async {
      return await showDialog( //show confirm dialogue
        //the return value will be from "Yes" or "No" options
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Exit App'),
          content: const Text('Do you want to exit?'),
          actions:[
            ElevatedButton(
              onPressed: () => Navigator.of(context).pop(false),
              style: ButtonStyle(backgroundColor: MaterialStateProperty.all(AppColors.themeColor)),
              child:const Text('No'),
            ),
            ElevatedButton(
              onPressed: () => Navigator.of(context).pop(true),
              style: ButtonStyle(backgroundColor: MaterialStateProperty.all(AppColors.themeColor)),
              child:const Text('Yes'),
            ),
          ],
        ),
      )??false; //if showDialog had returned null, then return false
    }
    ScreenContext.getScreenContext(context);
    if(ScreenContext.width! > 550) {
      ///tablets...............
      return WillPopScope(
        onWillPop: showExitPopup,
        child: Scaffold(
          appBar: MyAppBars.myAppBar(
              context, box.read('avatar').toString(),box.read('role').toString()),
          body: IndexedStack(
            index: initValue,
            children: _screens,
          ),
          bottomNavigationBar: NavigationBarTheme(
            data: NavigationBarThemeData(
                indicatorColor: Colors.grey[100],
                labelTextStyle: MaterialStateProperty.all(TextStyle(color: AppColors.themeColor))
            ),
            child: NavigationBar(
              elevation: 5,
              labelBehavior: NavigationDestinationLabelBehavior.onlyShowSelected,
              onDestinationSelected: (value) {
                setState(() {
                  initValue = value;
                });
              },
              selectedIndex: initValue,
              // height: 500,
              backgroundColor: const Color(0xFFDFEFFF),
              animationDuration: const Duration(seconds: 1),
              destinations:  [
                NavigationDestination(
                    icon: const Icon(Icons.home_outlined,size: 34,),
                    selectedIcon: Icon(Icons.home,
                      size: 37,
                      color: AppColors.themeColor,),
                    label: 'Home'),
                NavigationDestination(
                    icon: Image.asset('assets/images/vip.png',color: Colors.black,width: 48,height: 48,),
                    selectedIcon: Image.asset('assets/images/vip.png',width: 53,height: 53,),
                    label: 'VIP'),
                NavigationDestination(
                    icon: const Icon(Icons.add_circle_outline,size: 32,),
                    selectedIcon: Icon(Icons.add_circle,
                      size: 36,
                      color: AppColors.themeColor,),
                    label: 'Create'),
                NavigationDestination(
                    icon: const Icon(Icons.file_open_outlined,size: 32,),
                    selectedIcon: Icon(Icons.file_open,
                      size: 36,
                      color: AppColors.themeColor,),
                    label: 'Tables'),
                NavigationDestination(
                    icon: const Icon(Icons.history,size: 32,),
                    selectedIcon: Icon(Icons.history,
                      size: 36,
                      color: AppColors.themeColor,),
                    label: 'History'),
              ],
            ),
          ),
        ),
      );
    }
    ///phones...............
    return WillPopScope(
      onWillPop: showExitPopup,
      child: Scaffold(
        appBar: MyAppBars.myAppBar(
            context, box.read('avatar').toString(),box.read('role').toString()),
        body: IndexedStack(
          index: initValue,
          children: _screens,
        ),

        bottomNavigationBar: NavigationBarTheme(
          data: NavigationBarThemeData(
            indicatorColor: Colors.grey[100],
            labelTextStyle:  MaterialStateProperty.all(TextStyle(
              color: AppColors.themeColor)
            ),
          ),
          child: NavigationBar(
            elevation: 5,
            labelBehavior: NavigationDestinationLabelBehavior.onlyShowSelected,
            onDestinationSelected: (value) {
              setState(() {
                initValue = value;
              });
            },
            selectedIndex: initValue,
            height: 70,
            backgroundColor: const Color(0xFFD4EFFA),
            animationDuration: const Duration(seconds: 1),
            destinations: [
              NavigationDestination(
                  icon: const Icon(Icons.home_outlined,size: 24,),
                  selectedIcon: Icon(Icons.home,
                    size: 26,
                    color: AppColors.themeColor,),
                  label: 'Home'),
              NavigationDestination(
                  icon: Image.asset('assets/images/vip.png',color: Colors.black,width: 38,height: 38,),
                  selectedIcon: Image.asset('assets/images/vip.png',width: 43,height: 43,),
                  label: 'VIP'),
              NavigationDestination(
                  icon: const Icon(Icons.add_circle_outline,size: 24),
                  selectedIcon: Icon(Icons.add_circle,
                    size: 26,
                    color: AppColors.themeColor,),
                  label: 'Create'),
              NavigationDestination(
                  icon: const Icon(Icons.file_open_outlined,size: 24),
                  selectedIcon: Icon(Icons.file_open,
                    size: 26,
                    color: AppColors.themeColor,),
                  label: 'Tables'),
              NavigationDestination(
                  icon: const Icon(Icons.history,size: 24),
                  selectedIcon: Icon(Icons.history,
                    size: 26,
                    color: AppColors.themeColor,),
                  label: 'History'),
            ],
          ),
        ),
      ),
    );
  }
}

