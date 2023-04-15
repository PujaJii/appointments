import '../controller/del_ap_controller.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_animated_dialog/flutter_animated_dialog.dart';

import '../views/download_file_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

import '../controller/list_today_controller.dart';
import '../styles/app_colors.dart';
import '../styles/common_module/my_snack_bar.dart';
import '../utils/constants/size_orientation.dart';


class VipPage extends StatefulWidget {
  const VipPage({Key? key}) : super(key: key);

  @override
  State<VipPage> createState() => _VipPageState();
}

class _VipPageState extends State<VipPage> {
  TodayListController listController12 = Get.find();
  @override
  Widget build(BuildContext context) {
    //final box = GetStorage();

    DeleteController deleteController = Get.put(DeleteController());
    final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
    GlobalKey<RefreshIndicatorState>();

    ScreenContext.getScreenContext(context);
    Future<void> _pullRefresh(var _refreshIndicatorKey) async {
      listController12.getVIPLists();
    }
    Future<void> _launchUrl(String urls) async {
      var url = urls;
      try{
        if (!await launchUrl(Uri.parse(url))) {
          throw Exception('Could not launch $url');
        }
      }catch(c){
        MySnackbar.infoSnackBar('Link not correct', 'Invalid link, please copy the link and open external');
      }
    }
    if(ScreenContext.width! > 550){
      ///Tablet view.....................
      return Scaffold(
        // appBar: MyAppBars.myAppBar(context,
        //   box.read('avatar').toString(),box.read('role').toString()),
        body: GetX<TodayListController>(initState : (context){
        listController12.getVIPLists();
        },builder: (controller){
          if(controller.isLoadingVIP.value){
            return Scaffold(
                body: Center(child: CircularProgressIndicator(color: AppColors.themeColor,)));
          }else{
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 25,),
                Text('    VIP visitor list :', style: TextStyle(fontSize: 18)),
                controller.listVIP.isEmpty?
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: const[
                      Center(
                          child: Text(
                              'No Appointments for today!!',style: TextStyle(fontSize: 17)
                          )
                      ),
                    ],
                  ),
                ):
                Expanded(
                    child: RefreshIndicator(
                      key: _refreshIndicatorKey,
                      onRefresh: () {
                        return _pullRefresh(_refreshIndicatorKey);
                      },
                      color: AppColors.themeColor,
                      child: ListView.builder(
                        itemCount: controller.listVIP.length,
                        itemBuilder: (context, index) {
                          return Container(
                            margin: const EdgeInsets.symmetric(vertical: 8,horizontal: 15),
                            decoration: BoxDecoration(
                              boxShadow: const [
                                BoxShadow(
                                  color: Colors.grey,
                                  blurRadius: 3,
                                  offset: Offset(
                                    0,
                                    3,
                                  ),
                                )],
                              color: AppColors.white,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Column(
                              children: [
                                //const SizedBox(height: 8),

                                Row(
                                  mainAxisAlignment:  MainAxisAlignment.spaceEvenly,
                                  children: [
                                    const SizedBox(width: 20,),
                                    Expanded(
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          const SizedBox(height: 15,),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.end,
                                            crossAxisAlignment: CrossAxisAlignment.end,
                                            children:  [
                                              InkWell(
                                                  onTap: (){
                                                    showAnimatedDialog(context: context,
                                                        animationType: DialogTransitionType.scale,
                                                        curve: Curves.fastOutSlowIn,
                                                        // duration: const Duration(seconds: 1),
                                                        barrierDismissible: true,
                                                        builder: (BuildContext context) {
                                                          return AlertDialog(
                                                            title: Text("Delete Appointment!!",
                                                                style: TextStyle(color: Colors.redAccent)),
                                                            content: const Text(
                                                                "Are you sure you want to delete this appointment?"),
                                                            actions: [
                                                              ElevatedButton(
                                                                onPressed: () {
                                                                  deleteController.deleteRequest(controller.listVIP[index].id.toString());
                                                                  Navigator.of(context).pop();
                                                                },
                                                                style: ButtonStyle(
                                                                    backgroundColor: MaterialStateProperty.all(
                                                                        Colors.redAccent)),
                                                                child: const Text('Delete'),
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
                                                  child: Icon(Icons.cancel_outlined,
                                                      size: 25,
                                                      color: Colors.grey[600])),
                                            ],
                                          ),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              SizedBox(
                                                  height: 18,
                                                  width: 35,
                                                  child: Image.asset(
                                                    'assets/images/vip.png',fit: BoxFit.fill,color: Colors.amber,)
                                              ),
                                              Expanded(
                                                child: Padding(
                                                  padding: const EdgeInsets.only(left: 8),
                                                  child:
                                                  controller.listVIP[index].meetingType == '0'?
                                                  Text('${controller.listVIP[index].recipientName}',
                                                    style: const TextStyle(
                                                        fontSize: 16,
                                                        color: Colors.black),):
                                                  Text('${controller.listVIP[index].recipientName}',
                                                    style: TextStyle(
                                                        fontSize: 16,
                                                        color: Colors.black),),
                                                ),
                                              ),
                                            ],
                                          ),const SizedBox(height: 10,),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Expanded(
                                                child: Padding(
                                                  padding: const EdgeInsets.only(left: 23.0),
                                                  child: Text('Details  -  ${controller.listVIP[index].meetingSubject}',
                                                      style: TextStyle(
                                                          fontSize: 14,
                                                          color: Colors.grey[600])),
                                                ),
                                              ),
                                              const SizedBox(height: 15,),
                                              Row(
                                                children: [
                                                  const SizedBox(width: 20),
                                                  controller.listVIP[index].meetingDocuments == '0'?
                                                  Container():
                                                  Container(
                                                    child: Column(
                                                      children: [
                                                        Image.asset('assets/images/pdf_img.png',
                                                            width: 18,height: 24,fit: BoxFit.cover,color: AppColors.themeColor),
                                                        const Text('Document',style: TextStyle(fontSize: 12,
                                                            fontWeight: FontWeight.bold)),
                                                      ],
                                                    ),
                                                  ),


                                                ],
                                              ),
                                            ],
                                          ),
                                          const SizedBox(height: 5,),
                                          controller.listVIP[index].videoConfaranceLink == null || controller.listVIP[index].videoConfaranceLink == '0' ?
                                          Container():
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.end,
                                            crossAxisAlignment: CrossAxisAlignment.end,
                                            children: [
                                              InkWell(
                                                  onTap: () {
                                                    print(controller.listVIP[index].videoConfaranceLink);
                                                    Clipboard.setData(ClipboardData(
                                                        text: controller.listVIP[index].videoConfaranceLink))
                                                        .then((_) => ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                                                        content: Text(
                                                          'Copied to clipboard',
                                                          // textAlign: TextAlign.right,
                                                        ))));
                                                  },
                                                  child: Icon(Icons.copy)),
                                              SizedBox(width: 5,),
                                              Expanded(
                                                  child:InkWell(
                                                    onTap: () {
                                                      print(controller.listVIP[index].videoConfaranceLink!);
                                                      _launchUrl(controller.listVIP[index].videoConfaranceLink!);
                                                    },
                                                    child: Text(
                                                      controller.listVIP[index].videoConfaranceLink!,
                                                      style: TextStyle(  decoration: TextDecoration.underline,color: AppColors.themeColor),),
                                                  )),
                                            ],
                                          ),
                                          const SizedBox(height: 5,),
                                          Container(
                                            height: 0.2,
                                            width: double.infinity,
                                            color: Colors.black,
                                          ),const SizedBox(height: 8,),
                                          Text('   Date : ${controller.listVIP[index].meetingDate!.year}'
                                              '-${controller.listVIP[index].meetingDate!.month}-'
                                              '${controller.listVIP[index].meetingDate!.day}         '
                                              'Time : ${DateFormat("h:mm a").format(DateFormat("hh:mm").parse(controller.listVIP[index].meetingTime!))}',
                                            style: TextStyle(
                                                fontSize: 14,
                                                color: Colors.grey[600]),),
                                          const SizedBox(height: 8,),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(width: 20,),
                                  ],
                                ),
                                const SizedBox(height: 10,)
                              ],
                            ),
                          );
                        },),
                    )
                ),
              ],
            );
          }
        },)

      );
    }

    ///Phone view.....................

    return
      Scaffold(
        // appBar: MyAppBars.myAppBar(context, box.read('avatar').toString(),box.read('role').toString()),
        body: GetX<TodayListController>(initState: (context){
          listController12.getVIPLists();
        },builder: (controller){
          if (controller.isLoadingVIP.value){
            return Scaffold(
                body: Center(child: CircularProgressIndicator(color: AppColors.themeColor,)));
          } else{
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 15,),
                Text('    VIP visitor list :', style: TextStyle(fontSize: 16)),
                const SizedBox(height: 10,),
                controller.listVIP.isEmpty?
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: const[
                      Center(
                          child: Text(
                              'No Appointments for today!!',style: TextStyle(fontSize: 17)
                          )
                      ),
                    ],
                  ),
                ):
                Expanded(
                  child: RefreshIndicator(
                    key: _refreshIndicatorKey,
                    onRefresh: () {
                      return _pullRefresh(_refreshIndicatorKey);
                    },
                    color: AppColors.themeColor,
                    child: ListView.builder(
                      itemCount: controller.listVIP.length,
                      padding: const EdgeInsets.only(bottom: 30),
                      itemBuilder: (context, index) {
                        return Container(
                          margin: const EdgeInsets.symmetric(vertical: 8,horizontal: 10),
                          decoration: BoxDecoration(
                            boxShadow: const [
                              BoxShadow(
                                color: Colors.grey,
                                blurRadius: 3,
                                offset: Offset(
                                  0,
                                  3,
                                ),
                              )
                            ],
                            color: AppColors.white,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Column(
                            children: [
                              //const SizedBox(height: 8),

                              Row(
                                mainAxisAlignment:  MainAxisAlignment.spaceEvenly,
                                children: [
                                  const SizedBox(width: 20,),
                                  Expanded(
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        const SizedBox(height: 8,),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.end,
                                          crossAxisAlignment: CrossAxisAlignment.end,
                                          children:  [
                                            InkWell(
                                                onTap: (){
                                                  showAnimatedDialog(context: context,
                                                      animationType: DialogTransitionType.scale,
                                                      curve: Curves.fastOutSlowIn,
                                                      // duration: const Duration(seconds: 1),
                                                      barrierDismissible: true,
                                                      builder: (BuildContext context) {
                                                        return AlertDialog(
                                                          title: Text("Delete Appointment!!",
                                                              style: TextStyle(color: Colors.redAccent)),
                                                          content: const Text(
                                                              "Are you sure you want to delete this appointment?"),
                                                          actions: [
                                                            ElevatedButton(
                                                              onPressed: () {
                                                                deleteController.deleteRequest(controller.listVIP[index].id.toString());
                                                                Navigator.of(context).pop();
                                                              },
                                                              style: ButtonStyle(
                                                                  backgroundColor: MaterialStateProperty.all(
                                                                      Colors.redAccent)),
                                                              child: const Text('Delete'),
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
                                                child: Icon(Icons.cancel_outlined,color: Colors.grey[600])),
                                          ],
                                        ),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            SizedBox(
                                                height: 18,
                                                width: 35,
                                                child: Image.asset(
                                                  'assets/images/vip.png',fit: BoxFit.fill,color: Colors.amber,)
                                            ),
                                            SizedBox(height: 10,),
                                            Expanded(
                                              child: Padding(
                                                  padding: const EdgeInsets.only(left: 5.0),
                                                  child:
                                                  Text('${controller.listVIP[index].recipientName}',
                                                    style: const TextStyle(
                                                        fontSize: 14,
                                                        color: Colors.black),)

                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: 10,),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Expanded(
                                              child:  Padding(
                                                padding: const EdgeInsets.only(left: 23.0),
                                                child: Text('Details -  ${controller.listVIP[index].meetingSubject}',
                                                  style: TextStyle(
                                                      fontSize: 12,
                                                      color: Colors.grey[600]),),
                                              ),
                                            ),
                                            controller.listVIP[index].meetingDocuments == '0'?
                                            Container(width: 45,):
                                            InkWell(
                                              onTap: () {
                                                Get.to(()=>DownloadFilePage(controller.listVIP[index].meetingDocuments));
                                              },
                                              child: Container(
                                                child: Column(
                                                  children: [
                                                    Image.asset('assets/images/pdf_img.png',
                                                        width: 15,height: 20,fit: BoxFit.contain,color: AppColors.themeColor),
                                                    const Text('Document',style: TextStyle(fontSize: 10,
                                                    )
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        //const SizedBox(height: 10,),
                                        const SizedBox(height: 5,),
                                        controller.listVIP[index].videoConfaranceLink == null || controller.listVIP[index].videoConfaranceLink == '0' ?
                                        Container():
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.end,
                                          children: [
                                            InkWell(
                                                onTap: () {
                                                  Clipboard.setData(ClipboardData(text: controller.listVIP[index].videoConfaranceLink));
                                                },
                                                child: Icon(Icons.copy,size: 18,)
                                            ),
                                            const SizedBox(width: 5),
                                            Expanded(
                                                flex: 1,
                                                child: InkWell(
                                                  onTap: () {
                                                    print(controller.listVIP[index].videoConfaranceLink!);
                                                    _launchUrl(controller.listVIP[index].videoConfaranceLink!);
                                                  },
                                                  child: Text(
                                                    controller.listVIP[index].videoConfaranceLink!,style: TextStyle(
                                                      decoration: TextDecoration.underline,color: AppColors.themeColor),),
                                                )
                                            ),
                                          ],
                                        ),
                                        const SizedBox(height: 8,),
                                        Container(
                                          height: 0.2,
                                          width : double.infinity,
                                          color : Colors.black,
                                        ),
                                        const SizedBox(height: 5,),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                          children: [
                                            Text('  Date : ${controller.listVIP[index].meetingDate!.day} - '
                                                '${controller.listVIP[index].meetingDate!.month} - '
                                                '${controller.listVIP[index].meetingDate!.year}',
                                              style: TextStyle(
                                                  fontSize: 12,
                                                  color: Colors.grey[600]),),
                                            Text('  Time : ${DateFormat("h:mm a").format(DateFormat("hh:mm").parse(controller.listVIP[index].meetingTime!))}',
                                                style: TextStyle(
                                                    fontSize: 12,
                                                    color: Colors.grey[600])),
                                            Text('  Duration : ${controller.listVIP[index].minutes}',
                                                style: TextStyle(
                                                    fontSize: 12,
                                                    color: Colors.grey[600]))
                                          ],
                                        )
                                        // Text('  Date : ${controller.listVIP[index].meetingDate!.day} - '
                                        //     '${controller.listVIP[index].meetingDate!.month} - '
                                        //     '${controller.listVIP[index].meetingDate!.year}             '
                                        //     'Time :  '
                                        //     '${DateFormat("h:mm a").format(DateFormat("hh:mm").parse(controller.listVIP[index].meetingTime!))}',
                                        //   style: TextStyle(
                                        //       fontSize: 12,
                                        //       color: Colors.grey[600]),),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(width: 20,),
                                ],
                              ),
                              const SizedBox(height: 10,)
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ],
            );
          }
        },
        ),
      );
  }
  getNotifications() {
    //On Terminated
    FirebaseMessaging.instance.getInitialMessage().then((event) {
      if (event != null) {
        //print("notification event: ${event.notification}, notification msg: ${event.notification!.title}");
        // listController.getTodayLists();
        // listController.getPending();
        listController12.getVIPLists();
      }
    });

    //On Foreground
    FirebaseMessaging.onMessage.listen((event) {
      print('Got a message whilst in the foreground!');
      print('Message data: ${event.data}');
      listController12.getVIPLists();
      // listController.getTodayLists();
      // listController.getPending();
      // if (event.notification != null) {
      //   setState(() {
      //     notificationsStr =
      //     'Title : ${event.notification!.title}, Body : ${event.notification!.body} This is from Foreground State';
      //     MySnackbar.whiteSnackbar('Notification for you', notificationsStr!);
      //   });
      //   print('Message also contained a notification: ${event.notification}');
      // }
    });

    //Background
    FirebaseMessaging.onMessageOpenedApp.listen((event) =>
        setState(() {
          // notificationsStr =
          // 'Title : ${event.notification!.title}, Body : ${event.notification!.body} This is from Background State';
          // MySnackbar.whiteSnackbar('Notification for you', notificationsStr!);
        }),
      ///listController.getTodayLists()
    );
  }
}
