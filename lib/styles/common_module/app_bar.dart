import '../../views/bottom_nav_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animated_dialog/flutter_animated_dialog.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../auth_service.dart';
import '../../controller/list_today_controller.dart';
import '../../utils/constants/size_orientation.dart';
import '../../views/login.dart';
import '../app_colors.dart';
import 'my_alert_dilog.dart';

//
// AppBar appBar(String name) => AppBar(
//   backgroundColor: AppColors.themeColor,
//   centerTitle: true,
//     title: Text(name,
//         style:
//             const TextStyle(color: Colors.white, fontWeight: FontWeight.w400, fontSize: 16)));


class MyAppBars {

  static AppBar myAppBar(BuildContext context, String avatar,
      String accountRole) {
    ScreenContext.getScreenContext(context);
    if (ScreenContext.width! >= 550) {
      ///Tablet..............
     return AppBar(
          backgroundColor: AppColors.themeColor,
          centerTitle: true,
          elevation: 0,
          titleSpacing: 0,
          leadingWidth: 70,
          toolbarHeight: 100,
          actions: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // const SizedBox(height: 5,),
                InkWell(
                  onTap: () {
                    showAnimatedDialog(context: context,
                        animationType: DialogTransitionType.slideFromTopFade,
                        curve: Curves.fastOutSlowIn,
                        //duration: const Duration(seconds: 1),
                        barrierDismissible: true,
                        builder: (BuildContext context) {
                          final box = GetStorage();
                          return AlertDialog(
                            title: Text(
                                "Log Out", style: TextStyle(color: AppColors
                                .themeColor)),
                            content: const Text(
                                "Are you sure you want to log out?"),
                            actions: [
                              ElevatedButton(
                                onPressed: () async {
                                  MyAlertDialog.circularProgressDialog();
                                  await AuthService().signOut();
                                  box.write('isLoading', false);
                                  Get.offAll(const LoginPage());
                                },
                                style: ButtonStyle(
                                    backgroundColor: MaterialStateProperty.all(
                                        AppColors.themeColor)),
                                child: const Text('Logout'),
                              ),
                              ElevatedButton(
                                style: ButtonStyle(
                                    backgroundColor: MaterialStateProperty.all(
                                        Colors.grey)),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: const Text("Cancel"),
                              )
                            ],
                          );
                        });
                  },
                  child: Container(
                    height: 45,
                    width: 45,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        image: DecorationImage(image: NetworkImage(avatar)),
                        borderRadius: BorderRadius.circular(27)),
                  ),
                ),
                Text('${FirebaseAuth.instance.currentUser!
                    .displayName!} ($accountRole)',
                    style: const TextStyle(fontSize: 17)),
                Text(FirebaseAuth.instance.currentUser!.email!,
                    style: const TextStyle(fontSize: 12)),
              ],
            ),
            const SizedBox(width: 12,)
          ],
          leading: Container(
              height: 50,
              width: 90,
              margin: const EdgeInsets.only(left: 12),
              child:
              Image.asset('assets/images/logo.png', fit: BoxFit.contain,)
          ),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              InkWell(
                onTap: () {
                  Get.offAll(() => const BottomNavPage());
                },
                child: Container(
                  // height: 35,
                  padding: const EdgeInsets.symmetric(
                      horizontal: 10, vertical: 10),
                  //width: 70,
                  decoration: BoxDecoration(
                      color: AppColors.themeColorTwo,
                      borderRadius: BorderRadius.circular(8)),
                  child: Row(
                    children: [
                      const Icon(Icons.notification_add, size: 18),
                      Obx(() =>
                          Text('  Approved (${TodayListController
                              .notificationNum})', style: const TextStyle(
                              fontSize: 11,
                              color: Colors.white),))
                    ],
                  ),
                ),
              ),
              //const SizedBox(width: 2,),
              InkWell(
                onTap: () {
                  Get.offAll(() => const BottomNavPage());
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 10, vertical: 10),
                  decoration: BoxDecoration(
                      color: AppColors.themeColor3,
                      borderRadius: BorderRadius.circular(8)),
                  child: Row(
                    children: [
                      const Icon(Icons.notification_important, size: 18),
                      Obx(() =>
                          Text(
                            '  Visitors (${TodayListController.pendingListLength
                                .value.toString()})', style: const TextStyle(
                              fontSize: 11,
                              color: Colors.white),
                          )
                      )
                    ],
                  ),
                ),
              )
            ],
          )
      );
    }
    ///Phone............
    return AppBar(
        backgroundColor: AppColors.themeColor,
        centerTitle: true,
        elevation: 0,
        titleSpacing: 0,
        toolbarHeight: 80,
        actions: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              const SizedBox(height: 5,),
              InkWell(
                onTap: () {
                  showAnimatedDialog(context: context,
                      animationType: DialogTransitionType.slideFromTopFade,
                      curve: Curves.fastOutSlowIn,
                      barrierDismissible: true,
                      builder: (BuildContext context) {
                        final box = GetStorage();
                        return AlertDialog(
                          title: Text("Log Out?",
                              style: TextStyle(color: AppColors.themeColor)),
                          content: const Text(
                              "Are you sure you want to log out?"),
                          actions: [
                            ElevatedButton(
                              onPressed: () async {
                                MyAlertDialog.circularProgressDialog();
                                await AuthService().signOut();
                                box.write('isLoading', false);
                                Get.offAll(const LoginPage());
                              },
                              style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all(
                                      AppColors.themeColor)),
                              child: const Text('Log Out'),
                            ),
                            ElevatedButton(
                              style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all(
                                      Colors.grey)),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: const Text("Cancel"),
                            )
                          ],
                        );
                      }
                  );
                },
                child: Container(
                  height: 30,
                  width: 30,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      image: DecorationImage(image: NetworkImage(avatar)),
                      borderRadius: BorderRadius.circular(20)),
                ),
              ),
              Text('${FirebaseAuth.instance.currentUser!
                  .displayName!} ($accountRole)',
                  style: const TextStyle(fontSize: 13)),
              Text(FirebaseAuth.instance.currentUser!.email!,
                  style: const TextStyle(fontSize: 10)),
            ],
          ),
          const SizedBox(width: 12,)
        ],
        leading: Container(
            height: 50,
            width: 90,
            margin: const EdgeInsets.only(left: 5),
            child:
            Image.asset('assets/images/logo.png', fit: BoxFit.contain,)
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            InkWell(
              onTap: () {
                Get.offAll(() => const BottomNavPage());
              },
              child: Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: 5, vertical: 5),
                decoration: BoxDecoration(
                    color: AppColors.themeColorTwo,
                    borderRadius: BorderRadius.circular(8)),
                child: Row(
                  children: [
                    const Icon(Icons.notification_add, size: 18),
                    Obx(() =>
                        Text(' (${TodayListController.notificationNum.value
                            .toString()})', style: const TextStyle(
                            fontSize: 12,
                            color: Colors.white),)
                    )
                  ],
                ),
              ),
            ),
            InkWell(
              onTap: () {
                Get.offAll(() => const BottomNavPage());
              },
              child: Container(
                // height: 35,
                padding: const EdgeInsets.symmetric(
                    horizontal: 5, vertical: 5),
                decoration: BoxDecoration(
                    color: AppColors.themeColor3,
                    borderRadius: BorderRadius.circular(8)),
                child: Row(
                  children: [
                    const Icon(Icons.notification_important, size: 18),
                    Obx(() =>
                        Text(' (${TodayListController.pendingListLength.value
                            .toString()})',
                          style: const TextStyle(
                              fontSize: 12,
                              color: Colors.white),
                        )
                    )
                  ],
                ),
              ),
            )
          ],
        )
    );
  }
}
//   static AppBar tabAppBar(BuildContext context,String avatar, String accountRole) =>
//
//
// }

// AppBar appBarCart(String name) => AppBar(
//   title: Text(name,
//       style:
//       const TextStyle(color: Colors.white, fontWeight: FontWeight.w400, fontSize: 16)),
//   actions: [
//     //Container(color:Colors.deepPurple,child: Text('data')),
//     Obx(()=>Badge(
//       badgeColor: Colors.deepOrange,
//       position: BadgePosition.topEnd(top: 2, end: 4),
//       badgeContent: Text(CartController.cartItem.value,
//       style: const TextStyle(color: Colors.white, fontSize: 11),),
//       child: IconButton(
//         icon: Icon(Icons.shopping_cart, color: AppColors.white),
//         onPressed: () {
//           Get.to(() => CartView());
//         },
//       ),
//     )),
//     const SizedBox(width: 4,)
//   ],
// );

