
import '../styles/common_module/buttons.dart';
import '../utils/constants/size_orientation.dart';
import 'package:expandable/expandable.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:wakelock/wakelock.dart';

import '../controller/accept_controller.dart';
import '../controller/full_view_controller.dart';
import '../styles/app_colors.dart';
import '../styles/common_module/my_snack_bar.dart';
import 'download_file_page.dart';


class FullView extends StatefulWidget {
  const FullView({Key? key}) : super(key: key);

  @override
  State<FullView> createState() => _FullViewState();
}

class _FullViewState extends State<FullView> {

  TodayListControllerFull listController5 = Get.put(TodayListControllerFull());
  AcceptController acceptController1 = Get.find();
  String? notificationsStr;

  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey1 =
  GlobalKey<RefreshIndicatorState>();
  Future<void> _pullRefresh(var _refreshIndicatorKey) async {
    print('.............pull request');
    // _refreshIndicatorKey.currentState?.show();
    listController5.getTodayLists_full();
    // listController5.getPending();
    //final fcmToken = await FirebaseMessaging.instance.getToken();
 //   print('My FCM ...........$fcmToken');
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

  @override
  void initState() {
    Wakelock.enable();
    getNotifications();
    super.initState();
  }
  @override
  void dispose() {
    Wakelock.disable();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {


    // final DateTime now = DateTime. now();
    // final DateFormat formatter = DateFormat('dd -MM -yyyy');
    // final String formatted = formatter. format(now);
    final box = GetStorage();
    ScreenContext.getScreenContext(context);
    if(ScreenContext.width! > 550){
      ///Tablets............
      return  SafeArea(
        child: Scaffold(
            body:
            GetX<TodayListControllerFull>(initState: (context){
              listController5.getTodayLists_full();
            },builder: (controller){
              if (controller.isLoading.value){
                return Scaffold(
                    body: Center(child: CircularProgressIndicator(color: AppColors.themeColor,)));
              } else{
                return  Column(
                  children: [
                    const SizedBox(height: 15,),
                    controller.appointmentList.isEmpty?
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: const[
                          Center(child: Text('No Appointments for today!!',style: TextStyle(fontSize: 17))),
                        ],
                      ),
                    ):
                    Expanded(
                      child: RefreshIndicator(
                        key: _refreshIndicatorKey1,
                        onRefresh: () {
                          return _pullRefresh(_refreshIndicatorKey1);
                        },
                        color: AppColors.themeColor,
                        child: ListView.builder(
                          itemCount: controller.appointmentList.length,
                          padding: const EdgeInsets.only(bottom: 20),
                          itemBuilder: (context, index) {
                            return Container(
                              margin: const EdgeInsets.symmetric(vertical: 3,horizontal: 10),
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
                              child: ExpandablePanel(
                                collapsed: Container(),
                                expanded: Column(
                                  children: [
                                    Divider(height: 2,),
                                    SizedBox(height: 10,),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Expanded(
                                          child:  Padding(
                                            padding: const EdgeInsets.only(left: 23.0),
                                            child: Text('Details -  ${controller.appointmentList[index].meetingSubject}',
                                              style: TextStyle(
                                                  fontSize: 12,
                                                  color: Colors.grey[600]),
                                            ),
                                          ),
                                        ),
                                        controller.appointmentList[index].meetingDocuments == '0'?
                                        Container(width: 45,):
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: InkWell(
                                            onTap: () async {
                                              // print('DOWNLOAD btn');
                                              Get.to(()=>DownloadFilePage(controller.appointmentList[index].meetingDocuments!));
                                            },
                                            child: Container(
                                              child: Column(
                                                children: [
                                                  Image.asset('assets/images/pdf_img.png',
                                                      width: 19,height: 24,fit: BoxFit.contain,color: AppColors.themeColor,),
                                                  const Text('Document',style: TextStyle(fontSize: 10,
                                                  )),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 5,),
                                    controller.appointmentList[index].videoConfaranceLink == null
                                        || controller.appointmentList[index].videoConfaranceLink == '0'?
                                    Container():
                                    Padding(
                                      padding: const EdgeInsets.only(left: 23.0),
                                      child: Row(
                                        // mainAxisAlignment: MainAxisAlignment.end,
                                        children: [
                                          InkWell(
                                              onTap: () {
                                                print(controller.appointmentList[index].videoConfaranceLink);
                                                Clipboard.setData(ClipboardData(
                                                    text:controller.appointmentList[index].videoConfaranceLink))
                                                    .then((_) => ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                                                    content: Text(
                                                      'Copied to clipboard',
                                                      // textAlign: TextAlign.right,
                                                    ))));
                                              },
                                              child: Icon(Icons.copy,size: 20,)),
                                          SizedBox(width: 5,),
                                          Expanded(
                                              flex: 1,
                                              child: InkWell(
                                                onTap: () {
                                                  print(controller.appointmentList[index].videoConfaranceLink!);
                                                  _launchUrl(controller.appointmentList[index].videoConfaranceLink!);
                                                },
                                                child: Text(
                                                  controller.appointmentList[index].videoConfaranceLink!,style: TextStyle(
                                                    decoration: TextDecoration.underline,color: AppColors.themeColor),),
                                              )
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(height: 10,),
                                  ],
                                ),
                                header : Column(
                                  children: [
                                    const SizedBox(height: 2),
                                    Row(
                                      mainAxisAlignment:  MainAxisAlignment.spaceEvenly,
                                      children: [
                                        const SizedBox(width: 20,),
                                        Expanded(
                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            crossAxisAlignment : CrossAxisAlignment.start,
                                            children: [
                                              const SizedBox(height: 10,),
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.start,
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  controller.appointmentList[index].status.toString() == '1'?
                                                  SizedBox(
                                                      height: 18,
                                                      width: 18,
                                                      child: Image.asset(
                                                          'assets/images/pre_approved.png')):
                                                  controller.appointmentList[index].status.toString() == '0'?
                                                  SizedBox(
                                                      height: 18,
                                                      width: 18,
                                                      child: Image.asset(
                                                          'assets/images/pending.png')):
                                                  controller.appointmentList[index].status.toString() == '3'?
                                                  SizedBox(
                                                      height: 18,
                                                      width: 18,
                                                      child: Image.asset(
                                                          'assets/images/rejected.png')):
                                                  SizedBox(
                                                      height: 18,
                                                      width: 18,
                                                      child: Image.asset(
                                                          'assets/images/recent_visitor.png')),
                                                  Expanded(
                                                    child:  Padding(
                                                      padding: const EdgeInsets.only(left: 5.0),
                                                      child:
                                                      controller.appointmentList[index].meetingType == '0'? // Pending.....
                                                      Text('${controller.appointmentList[index].recipientName}',
                                                        style: const TextStyle(
                                                            fontSize: 14,
                                                            color: Colors.black),):
                                                      const Text('Meeting (Pre Approved)',style: TextStyle(
                                                          fontSize: 14,
                                                          color: Colors.black),),
                                                    ),
                                                  ),
                                                  MyButtons.rescheduleIcon(index,28,controller.appointmentList)
                                                ],
                                              ),

                                              const SizedBox(height: 10,),




                                              ///page for DM




                                              box.read('role').toString() == 'DM'?
                                              controller.appointmentList[index].status == 0?
                                              // Approve + reject + wrong entry
                                              Column(
                                                children: [
                                                  Row(
                                                    mainAxisAlignment: MainAxisAlignment.end,
                                                    crossAxisAlignment: CrossAxisAlignment.center,
                                                    children: [
                                                      const SizedBox(width: 5,),
                                                      InkWell(
                                                        onTap: () {
                                                          acceptController1.acceptRequestFullView(controller.appointmentList[index].id.toString());
                                                        },
                                                        child: Container(
                                                          padding: const EdgeInsets.symmetric(vertical: 7,horizontal: 10),
                                                          decoration: BoxDecoration(
                                                              color: AppColors.themeColorTwo,
                                                              borderRadius: BorderRadius.circular(5)
                                                          ),
                                                          child: const Center(
                                                              child:
                                                              // Icon(Icons.done,color: AppColors.themeColorTwo,)
                                                              Text('Approve',style:  TextStyle(color: Colors.white),)
                                                          ),
                                                        ),
                                                      ),
                                                      const SizedBox(width: 5,),
                                                      InkWell(
                                                        onTap: () {
                                                          acceptController1.rejectRequest(controller.appointmentList[index].id.toString());
                                                        },
                                                        child: Container(
                                                          padding: const EdgeInsets.symmetric(vertical: 7,horizontal: 10),
                                                          decoration: BoxDecoration(
                                                              color: Colors.redAccent,
                                                              borderRadius: BorderRadius.circular(5)
                                                          ),
                                                          child: const Center(
                                                              child:
                                                              //Icon(Icons.cancel_outlined,color: Colors.redAccent,)
                                                              Text('  Reject  ',
                                                                style:  TextStyle(color: Colors.white),)
                                                          ),
                                                        ),
                                                      ),
                                                      const SizedBox(width: 5,),
                                                      //MyButtons.reschedule(index),
                                                    ],
                                                  ),
                                                  const SizedBox(height: 5,),
                                                ],
                                              ):
                                              controller.appointmentList[index].status == 1?
                                              //Pre Approved page
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                crossAxisAlignment: CrossAxisAlignment.center,
                                                children: [
                                                  //MyButtons.reschedule(index),
                                                  const SizedBox(width: 5,),
                                                ],
                                              ):
                                              controller.appointmentList[index].status == 2?
                                              //after approving appointment
                                              Container()
                                                  :
                                              controller.appointmentList[index].status == 3?
                                              //After Rejected
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                crossAxisAlignment: CrossAxisAlignment.center,
                                                children: [
                                                  //  const SizedBox(width: 5,),
                                                  const SizedBox(width: 15,),
                                                 // MyButtons.reschedule(index),
                                                  const SizedBox(width: 5,),
                                                ],
                                              ):
                                              controller.appointmentList[index].status == 4?
                                              //Visitor arrived
                                              Column(
                                                children: [
                                                  Row(
                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                    crossAxisAlignment: CrossAxisAlignment.center,
                                                    children: [
                                                      const SizedBox(width: 15,),
                                                      InkWell(
                                                        child: Container(
                                                          padding: const EdgeInsets.symmetric(vertical: 7,horizontal: 10),
                                                          decoration: BoxDecoration(
                                                              color: AppColors.themeColorTwo,
                                                              borderRadius: BorderRadius.circular(5)
                                                          ),
                                                          child: const Center(
                                                              child:
                                                              // Icon(Icons.done,color: AppColors.themeColorTwo,)
                                                              Text('Waiting...',style:  TextStyle(color: Colors.white),)
                                                          ),
                                                        ),
                                                      ),
                                                      const SizedBox(width: 5,),
                                                      InkWell(
                                                        onTap: () {
                                                          acceptController1.sendInRequest(controller.appointmentList[index].id.toString());
                                                        },
                                                        child: Container(
                                                          padding: const EdgeInsets.symmetric(vertical: 7,horizontal: 10),
                                                          decoration: BoxDecoration(
                                                              color: AppColors.themeColor,
                                                              borderRadius: BorderRadius.circular(5)
                                                          ),
                                                          child: const Center(
                                                              child:
                                                              Text('Send Inside',
                                                                style:  TextStyle(color: Colors.white),)
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  const SizedBox(height: 5,),
                                                ],
                                              )
                                              //pa only waiting
                                                  :
                                              controller.appointmentList[index].status == 5?
                                              Column(
                                                children: [
                                                  Row(
                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                    crossAxisAlignment: CrossAxisAlignment.center,
                                                    children: [
                                                      InkWell(
                                                        onTap: () {
                                                          acceptController1.completeRequest(controller.appointmentList[index].id.toString());
                                                        },
                                                        child: Container(
                                                          padding: const EdgeInsets.symmetric(vertical: 7,horizontal: 10),
                                                          decoration: BoxDecoration(
                                                              color: AppColors.themeColorTwo,
                                                              borderRadius: BorderRadius.circular(5)
                                                          ),
                                                          child: const Center(
                                                              child:
                                                              // Icon(Icons.done,color: AppColors.themeColorTwo,)
                                                              Text('Complete conversation',style:  TextStyle(color: Colors.white),)
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  const SizedBox(height: 5,),
                                                ],
                                              )
                                              //Waiting approved.....
                                                  :
                                              controller.appointmentList[index].status == 6?
                                              const Center(child: Text('Conversation Complete!!')):
                                              const Center(child: Text('Something went Wrong!!')):




                                              ///page for PA



                                              controller.appointmentList[index].status == 0?
                                              //wrong entry
                                              Column(
                                                children: [
                                                  Row(
                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                    crossAxisAlignment: CrossAxisAlignment.center,
                                                    children: [
                                                      // InkWell(
                                                      //   onTap: () {
                                                      //   },
                                                      //   child: Container(
                                                      //     padding: const EdgeInsets.symmetric(vertical: 7,horizontal: 10),
                                                      //     decoration: BoxDecoration(
                                                      //         color: AppColors.themeColor,
                                                      //         borderRadius: BorderRadius.circular(5)
                                                      //     ),
                                                      //     child: const Center(
                                                      //         child:
                                                      //         //Icon(Icons.edit,size: 22,color: AppColors.themeColor,)
                                                      //         Text('Wrong Entry?',
                                                      //           style:  TextStyle(color: Colors.white),)
                                                      //     ),
                                                      //   ),
                                                      // ),
                                                    ],
                                                  ),
                                                  const SizedBox(height: 5),
                                                ],
                                              ):
                                              controller.appointmentList[index].status == 1?
                                              //Pre Approved page
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                crossAxisAlignment: CrossAxisAlignment.center,
                                                children: [
                                                  //  const SizedBox(width: 5,),
                                                  const SizedBox(width: 15,),
                                                  // InkWell(
                                                  //   onTap: () {
                                                  //   },
                                                  //   child: Container(
                                                  //     padding: const EdgeInsets.symmetric(vertical: 7,horizontal: 10),
                                                  //     decoration: BoxDecoration(
                                                  //         color: AppColors.themeColor,
                                                  //         borderRadius: BorderRadius.circular(5)
                                                  //     ),
                                                  //     child: const Center(
                                                  //         child:
                                                  //         //Icon(Icons.edit,size: 22,color: AppColors.themeColor,)
                                                  //         Text('Wrong Entry?',
                                                  //           style:  TextStyle(color: Colors.white))
                                                  //     ),
                                                  //   ),
                                                  // ),
                                                  const SizedBox(width: 5,),
                                                ],
                                              ):
                                              controller.appointmentList[index].status == 2?
                                              //after approving appointment
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                crossAxisAlignment: CrossAxisAlignment.center,
                                                children: [
                                                  InkWell(
                                                    onTap: () {
                                                      acceptController1.arrivedRequest(controller.appointmentList[index].id.toString());
                                                    },
                                                    child: Container(
                                                      padding: const EdgeInsets.symmetric(vertical: 8,horizontal: 15),
                                                      decoration: BoxDecoration(
                                                          color: AppColors.themeColor,
                                                          borderRadius: BorderRadius.circular(5)
                                                      ),
                                                      child: const Center(
                                                          child:  Text('Arrived?',style:  TextStyle(color: Colors.white),)
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ) :
                                              controller.appointmentList[index].status == 3?
                                              //After Rejected
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                crossAxisAlignment: CrossAxisAlignment.center,
                                                children: [
                                                  //  const SizedBox(width: 5,),
                                                  const SizedBox(width: 15,),
                                                  // InkWell(
                                                  //   onTap: () {
                                                  //   },
                                                  //   child: Container(
                                                  //     padding: const EdgeInsets.symmetric(vertical: 7,horizontal: 10),
                                                  //     decoration: BoxDecoration(
                                                  //         color: AppColors.themeColor,
                                                  //         borderRadius: BorderRadius.circular(5)
                                                  //     ),
                                                  //     child: const Center(
                                                  //         child:
                                                  //         //Icon(Icons.edit,size: 22,color: AppColors.themeColor,)
                                                  //         Text('Wrong Entry?',
                                                  //           style:  TextStyle(color: Colors.white),)
                                                  //     ),
                                                  //   ),
                                                  // ),
                                                  const SizedBox(width: 5,),
                                                ],
                                              ):
                                              controller.appointmentList[index].status == 4?
                                              //Visitor arrived
                                              Column(
                                                children: [
                                                  Row(
                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                    crossAxisAlignment: CrossAxisAlignment.center,
                                                    children: [
                                                      const SizedBox(width: 15,),
                                                      InkWell(
                                                        onTap: () {
                                                        },
                                                        child: Container(
                                                          padding: const EdgeInsets.symmetric(vertical: 7,horizontal: 10),
                                                          decoration: BoxDecoration(
                                                              color: AppColors.themeColorTwo,
                                                              borderRadius: BorderRadius.circular(5)
                                                          ),
                                                          child: const Center(
                                                              child:
                                                              // Icon(Icons.done,color: AppColors.themeColorTwo,)
                                                              Text('Waiting...',style:  TextStyle(color: Colors.white),)
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  const SizedBox(height: 5,),
                                                ],
                                              ) :
                                              controller.appointmentList[index].status == 5?
                                              Column(
                                                children: [
                                                  Row(
                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                    crossAxisAlignment: CrossAxisAlignment.center,
                                                    children: [
                                                      InkWell(
                                                        child: Container(
                                                          padding: const EdgeInsets.symmetric(vertical: 7,horizontal: 10),
                                                          decoration: BoxDecoration(
                                                              color: AppColors.themeColorTwo,
                                                              borderRadius: BorderRadius.circular(5)
                                                          ),
                                                          child: const Center(
                                                              child:
                                                              // Icon(Icons.done,color: AppColors.themeColorTwo,)
                                                              Text('Waiting approved',style:  TextStyle(color: Colors.white),)
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  const SizedBox(height: 5,),
                                                ],
                                              ) :
                                              controller.appointmentList[index].status == 6?
                                              const Center(child: Text('Conversation Complete!!')):
                                              const Center(child: Text('Something went Wrong!!')),
                                              SizedBox(height: 5,),
                                              Divider(height: 2,),
                                              const SizedBox(height: 8,),
                                              Text('  Date : ${controller.appointmentList[index].meetingDate!.day} - '
                                                  '${controller.appointmentList[index].meetingDate!.month} - '
                                                  '${controller.appointmentList[index].meetingDate!.year}             '
                                                  'Time :  '
                                                  '${DateFormat("h:mm a").format(DateFormat("hh:mm").parse(controller.appointmentList[index].meetingTime!))}',
                                                style: TextStyle(
                                                    fontSize: 12,
                                                    color: Colors.grey[600]),),
                                            ],
                                          ),
                                        ),
                                        const SizedBox(width: 20,),
                                      ],
                                    ),
                                    const SizedBox(height: 10,)
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                );
              }
            })
        ),
      );
   }
    ///Phones............
    return SafeArea(
      child: Scaffold(
        body:
        GetX<TodayListControllerFull>(initState: (context){
          listController5.getTodayLists_full();
        },builder: (controller){
          if (controller.isLoading.value){
            return Scaffold(
                body: Center(child: CircularProgressIndicator(color: AppColors.themeColor,)));
          } else{
            return  Column(
              children: [
                const SizedBox(height: 15,),
                controller.appointmentList.isEmpty?
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: const[
                      Center(child: Text('No Appointments for today!!',style: TextStyle(fontSize: 17))),
                    ],
                  ),
                ):
                Expanded(
                 child: RefreshIndicator(
                   key: _refreshIndicatorKey1,
                   onRefresh: () {
                     return _pullRefresh(_refreshIndicatorKey1);
                   },
                   color: AppColors.themeColor,
                   child: ListView.builder(
                     itemCount: controller.appointmentList.length,
                     padding: const EdgeInsets.only(bottom: 20),
                     itemBuilder: (context, index) {
                       String duration = listController5.appointmentList[index].minutes!;
                       int totalMinutes = int.parse(duration);
                       int hours = (totalMinutes) ~/ 60; // ~ operator performs integer division
                       int minutes = totalMinutes % 60;
                       String _formatDateTime() {
                         if(hours== 0){
                           return  ' $minutes min';
                         }else if(minutes == 0){
                           return '$hours hr';
                         }
                         return '$hours hr $minutes min';
                       }
                       String formattedTime = _formatDateTime();
                       return Container(
                         margin: const EdgeInsets.symmetric(vertical: 3,horizontal: 10),
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
                         child: ExpandablePanel(
                           collapsed: Container(),
                           expanded: Column(
                             children: [
                               Divider(height: 2,),
                               SizedBox(height: 10,),
                               Row(
                                 mainAxisAlignment: MainAxisAlignment.start,
                                 crossAxisAlignment: CrossAxisAlignment.start,
                                 children: [
                                   Expanded(
                                     child:  Padding(
                                       padding: const EdgeInsets.only(left: 23.0),
                                       child:
                                       controller.appointmentList[index].meetingType == '0'?
                                       Text('  ${controller.appointmentList[index].recipientName}',
                                         style: TextStyle(
                                             fontSize: 12,
                                             color: Colors.grey[600]),
                                       ):
                                       Text('Meeting',style: TextStyle(
                                           fontSize: 12,
                                           color: Colors.grey[600]),),
                                     ),
                                   ),
                                   controller.appointmentList[index].meetingDocuments == '0'?
                                   Container(width: 45,):
                                   Padding(
                                     padding: const EdgeInsets.all(8.0),
                                     child: InkWell(
                                       onTap: () async {
                                         // print('DOWNLOAD btn');
                                         Get.to(()=>DownloadFilePage(controller.appointmentList[index].meetingDocuments!));
                                       },
                                       child: Container(
                                         child: Column(
                                           children: [
                                             Image.asset('assets/images/pdf_img.png',
                                                 width: 17,height: 22,fit: BoxFit.contain),
                                             const Text('Document',style: TextStyle(fontSize: 10,
                                             )),
                                           ],
                                         ),
                                       ),
                                     ),
                                   ),
                                 ],
                               ),
                               SizedBox(height: 5,),
                               controller.appointmentList[index].videoConfaranceLink == null
                               || controller.appointmentList[index].videoConfaranceLink == '0'?
                               Container():
                               Padding(
                                 padding: const EdgeInsets.only(left: 23.0),
                                 child: Row(
                                   // mainAxisAlignment: MainAxisAlignment.end,
                                   children: [
                                     InkWell(
                                         onTap: () {
                                           Clipboard.setData(ClipboardData(text: controller.appointmentList[index].videoConfaranceLink));
                                         },
                                         child: Icon(Icons.copy,size: 20,)),
                                     SizedBox(width: 5,),
                                     Expanded(
                                         flex: 1,
                                         child: InkWell(
                                           onTap: () {
                                             print(controller.appointmentList[index].videoConfaranceLink!);
                                             _launchUrl(controller.appointmentList[index].videoConfaranceLink!);
                                           },
                                           child: Text(
                                             controller.appointmentList[index].videoConfaranceLink!,style: TextStyle(
                                               decoration: TextDecoration.underline,color: AppColors.themeColor),),
                                       )
                                     ),
                                   ],
                                 ),
                               ),
                               SizedBox(height: 10,),
                             ],
                           ),
                           header : Column(
                             children: [
                               const SizedBox(height: 2),
                               Row(
                                 mainAxisAlignment:  MainAxisAlignment.spaceEvenly,
                                 children: [
                                   const SizedBox(width: 20,),
                                   Expanded(
                                     child: Column(
                                       mainAxisAlignment: MainAxisAlignment.center,
                                       crossAxisAlignment : CrossAxisAlignment.start,
                                       children: [
                                         const SizedBox(height: 10,),
                                         Row(
                                           mainAxisAlignment: MainAxisAlignment.start,
                                           crossAxisAlignment: CrossAxisAlignment.start,
                                           children: [
                                             controller.appointmentList[index].status.toString() == '1'?
                                             SizedBox(
                                                 height: 18,
                                                 width: 18,
                                                 child: Image.asset(
                                                     'assets/images/pre_approved.png')):
                                             controller.appointmentList[index].status.toString() == '0'?
                                             SizedBox(
                                                 height: 18,
                                                 width: 18,
                                                 child: Image.asset(
                                                     'assets/images/pending.png')):
                                             controller.appointmentList[index].status.toString() == '3'?
                                             SizedBox(
                                                 height: 18,
                                                 width: 18,
                                                 child: Image.asset(
                                                     'assets/images/rejected.png')):
                                             SizedBox(
                                                 height: 18,
                                                 width: 18,
                                                 child: Image.asset(
                                                     'assets/images/recent_visitor.png')),
                                             Expanded(
                                               child:  Padding(
                                                 padding: const EdgeInsets.only(left: 5.0),
                                                 child:
                                                // controller.appointmentList[index].meetingType == '0'? // Pending.....
                                                 Text('${controller.appointmentList[index].meetingSubject}',
                                                   style: const TextStyle(
                                                       fontSize: 14,
                                                       color: Colors.black),)
                                               ),
                                             ),
                                             MyButtons.rescheduleIcon(index,20,controller.appointmentList)
                                           ],
                                         ),

                                         const SizedBox(height: 10,),




                                         ///page for DM




                                         box.read('role').toString() == 'DM'?
                                         controller.appointmentList[index].status == 0?
                                         // Approve + reject + wrong entry
                                         Column(
                                           children: [
                                             Row(
                                               mainAxisAlignment: MainAxisAlignment.end,
                                               crossAxisAlignment: CrossAxisAlignment.center,
                                               children: [
                                                 const SizedBox(width: 5,),
                                                 InkWell(
                                                   onTap: () {
                                                     acceptController1.acceptRequestFullView(controller.appointmentList[index].id.toString());
                                                   },
                                                   child: Container(
                                                     padding: const EdgeInsets.symmetric(vertical: 7,horizontal: 10),
                                                     decoration: BoxDecoration(
                                                         color: AppColors.themeColorTwo,
                                                         borderRadius: BorderRadius.circular(5)
                                                     ),
                                                     child: const Center(
                                                         child:
                                                         // Icon(Icons.done,color: AppColors.themeColorTwo,)
                                                         Text('Approve',style:  TextStyle(color: Colors.white),)
                                                     ),
                                                   ),
                                                 ),
                                                 const SizedBox(width: 5,),
                                                 InkWell(
                                                   onTap: () {
                                                     acceptController1.rejectRequest(controller.appointmentList[index].id.toString());
                                                   },
                                                   child: Container(
                                                     padding: const EdgeInsets.symmetric(vertical: 7,horizontal: 10),
                                                     decoration: BoxDecoration(
                                                         color: Colors.redAccent,
                                                         borderRadius: BorderRadius.circular(5)
                                                     ),
                                                     child: const Center(
                                                         child:
                                                         //Icon(Icons.cancel_outlined,color: Colors.redAccent,)
                                                         Text('  Reject  ',
                                                           style:  TextStyle(color: Colors.white),)
                                                     ),
                                                   ),
                                                 ),
                                                 const SizedBox(width: 5,),
                                                 //MyButtons.reschedule(index),
                                               ],
                                             ),
                                             const SizedBox(height: 5,),
                                           ],
                                         ):
                                         controller.appointmentList[index].status == 1?
                                         //Pre Approved page
                                         Row(
                                           mainAxisAlignment: MainAxisAlignment.center,
                                           crossAxisAlignment: CrossAxisAlignment.center,
                                           children: [
                                            // MyButtons.reschedule(index),

                                             const SizedBox(width: 5,),
                                           ],
                                         ):
                                         controller.appointmentList[index].status == 2?
                                         //after approving appointment
                                         Container()
                                             :
                                         controller.appointmentList[index].status == 3?
                                         //After Rejected
                                         Row(
                                           mainAxisAlignment: MainAxisAlignment.center,
                                           crossAxisAlignment: CrossAxisAlignment.center,
                                           children: [
                                             //  const SizedBox(width: 5,),
                                             const SizedBox(width: 15,),
                                            // MyButtons.reschedule(index),
                                             const SizedBox(width: 5,),
                                           ],
                                         ):
                                         controller.appointmentList[index].status == 4?
                                         //Visitor arrived
                                         Column(
                                           children: [
                                             Row(
                                               mainAxisAlignment: MainAxisAlignment.center,
                                               crossAxisAlignment: CrossAxisAlignment.center,
                                               children: [
                                                 const SizedBox(width: 15,),
                                                 InkWell(
                                                   onTap: () {
                                                    // acceptController1.acceptRequest1(controller.appointmentList[index].id.toString());
                                                   },
                                                   child: Container(
                                                     padding: const EdgeInsets.symmetric(vertical: 7,horizontal: 10),
                                                     decoration: BoxDecoration(
                                                         color: AppColors.themeColorTwo,
                                                         borderRadius: BorderRadius.circular(5)
                                                     ),
                                                     child: const Center(
                                                         child:
                                                         // Icon(Icons.done,color: AppColors.themeColorTwo,)
                                                         Text('Waiting...',style:  TextStyle(color: Colors.white),)
                                                     ),
                                                   ),
                                                 ),
                                                 const SizedBox(width: 5,),
                                                 InkWell(
                                                   onTap: () {
                                                      acceptController1.sendInRequest(controller.appointmentList[index].id.toString());
                                                   },
                                                   child: Container(
                                                     padding: const EdgeInsets.symmetric(vertical: 7,horizontal: 10),
                                                     decoration: BoxDecoration(
                                                         color: AppColors.themeColor,
                                                         borderRadius: BorderRadius.circular(5)
                                                     ),
                                                     child: const Center(
                                                         child:
                                                         //Icon(Icons.edit,size: 22,color: AppColors.themeColor,)
                                                         Text('Send In',
                                                           style:  TextStyle(color: Colors.white),)
                                                     ),
                                                   ),
                                                 ),
                                               ],
                                             ),
                                             const SizedBox(height: 5,),
                                           ],
                                         )
                                         //pa only waiting
                                             :
                                         controller.appointmentList[index].status == 5?
                                         Column(
                                           children: [
                                             Row(
                                               mainAxisAlignment: MainAxisAlignment.center,
                                               crossAxisAlignment: CrossAxisAlignment.center,
                                               children: [
                                                 InkWell(
                                                   onTap: () {
                                                     acceptController1.acceptRequestFullView(controller.appointmentList[index].id.toString());
                                                   },
                                                   child: Container(
                                                     padding: const EdgeInsets.symmetric(vertical: 7,horizontal: 10),
                                                     decoration: BoxDecoration(
                                                         color: AppColors.themeColorTwo,
                                                         borderRadius: BorderRadius.circular(5)
                                                     ),
                                                     child: const Center(
                                                         child:
                                                         // Icon(Icons.done,color: AppColors.themeColorTwo,)
                                                         Text('Complete conversation',style:  TextStyle(color: Colors.white),)
                                                     ),
                                                   ),
                                                 ),
                                               ],
                                             ),
                                             const SizedBox(height: 5,),
                                           ],
                                         )
                                         //Waiting approved.....
                                             :
                                         controller.appointmentList[index].status == 6?
                                         const Center(child: Text('Conversation Complete!!')):
                                         const Center(child: Text('Something went Wrong!!')):




                                         ///page for PA



                                         controller.appointmentList[index].status == 0?
                                         //wrong entry
                                         Column(
                                           children: [
                                             Row(
                                               mainAxisAlignment: MainAxisAlignment.center,
                                               crossAxisAlignment: CrossAxisAlignment.center,
                                               children: [
                                                // MyButtons.reschedule(index),
                                               ],
                                             ),
                                             const SizedBox(height: 5,),
                                           ],
                                         ):
                                         controller.appointmentList[index].status == 1?
                                         //Pre Approved page
                                         Row(
                                           mainAxisAlignment: MainAxisAlignment.center,
                                           crossAxisAlignment: CrossAxisAlignment.center,
                                           children: [
                                             //  const SizedBox(width: 5,),
                                             const SizedBox(width: 15,),
                                            // MyButtons.reschedule(index),
                                             const SizedBox(width: 5,),
                                           ],
                                         ):
                                         controller.appointmentList[index].status == 2?
                                         //after approving appointment
                                         Row(
                                           mainAxisAlignment: MainAxisAlignment.center,
                                           crossAxisAlignment: CrossAxisAlignment.center,
                                           children: [
                                             InkWell(
                                               onTap: () {
                                                 acceptController1.arrivedRequest(controller.appointmentList[index].id.toString());
                                               },
                                               child: Container(
                                                 padding: const EdgeInsets.symmetric(vertical: 8,horizontal: 15),
                                                 decoration: BoxDecoration(
                                                     color: AppColors.themeColor,
                                                     borderRadius: BorderRadius.circular(5)
                                                 ),
                                                 child: const Center(
                                                     child:  Text('Arrived?',style:  TextStyle(color: Colors.white),)
                                                 ),
                                               ),
                                             ),
                                           ],
                                         ) :
                                         controller.appointmentList[index].status == 3?
                                         //After Rejected
                                         Row(
                                           mainAxisAlignment: MainAxisAlignment.center,
                                           crossAxisAlignment: CrossAxisAlignment.center,
                                           children: [
                                             //  const SizedBox(width: 5,),
                                             const SizedBox(width: 15,),
                                            // MyButtons.reschedule(index),
                                             const SizedBox(width: 5,),
                                           ],
                                         ):
                                         controller.appointmentList[index].status == 4?
                                         //Visitor arrived
                                         Column(
                                           children: [
                                             Row(
                                               mainAxisAlignment: MainAxisAlignment.center,
                                               crossAxisAlignment: CrossAxisAlignment.center,
                                               children: [
                                                 const SizedBox(width: 15,),
                                                 InkWell(
                                                   onTap: () {
                                                   //  acceptController1.acceptRequest1(controller.appointmentList[index].id.toString());
                                                   },
                                                   child: Container(
                                                     padding: const EdgeInsets.symmetric(vertical: 7,horizontal: 10),
                                                     decoration: BoxDecoration(
                                                         color: AppColors.themeColorTwo,
                                                         borderRadius: BorderRadius.circular(5)
                                                     ),
                                                     child: const Center(
                                                         child:
                                                         // Icon(Icons.done,color: AppColors.themeColorTwo,)
                                                         Text('Waiting...',style:  TextStyle(color: Colors.white),)
                                                     ),
                                                   ),
                                                 ),
                                               ],
                                             ),
                                             const SizedBox(height: 5,),
                                           ],
                                         )
                                             :
                                         controller.appointmentList[index].status == 5?
                                         Column(
                                           children: [
                                             Row(
                                               mainAxisAlignment: MainAxisAlignment.center,
                                               crossAxisAlignment: CrossAxisAlignment.center,
                                               children: [
                                                 InkWell(
                                                   onTap: () {

                                                   },
                                                   child: Container(
                                                     padding: const EdgeInsets.symmetric(vertical: 7,horizontal: 10),
                                                     decoration: BoxDecoration(
                                                         color: AppColors.themeColorTwo,
                                                         borderRadius: BorderRadius.circular(5)
                                                     ),
                                                     child: const Center(
                                                         child:
                                                         // Icon(Icons.done,color: AppColors.themeColorTwo,)
                                                         Text('Waiting approved',style:  TextStyle(color: Colors.white),)
                                                     ),
                                                   ),
                                                 ),
                                               ],
                                             ),
                                             const SizedBox(height: 5,),
                                           ],
                                         ) :
                                         controller.appointmentList[index].status == 6?
                                         const Center(child: Text('Conversation Complete!!')):
                                         const Center(child: Text('Something went Wrong!!')),
                                         SizedBox(height: 5,),
                                         Divider(height: 2,),
                                         const SizedBox(height: 8,),
                                         Row(
                                           mainAxisAlignment: MainAxisAlignment.spaceAround,
                                           children: [
                                             Text( '${DateFormat("h:mm a").format(DateFormat("hh:mm").parse(controller.appointmentList[index].meetingTime!))}',
                                               style: TextStyle(
                                                   fontSize: 12,
                                                   color: AppColors.themeColor),),
                                             SizedBox(width: 10,),
                                             Text('  Duration : $formattedTime  ',
                                                 style: TextStyle(
                                                     fontSize: 12,
                                                     color: AppColors.themeColor))
                                           ],
                                         ),
                                       ],
                                     ),
                                   ),
                                   const SizedBox(width: 20,),
                                 ],
                               ),
                               const SizedBox(height: 10,)
                             ],
                           ),
                         ),
                       );
                     },
                   ),
                 ),
                    ),
              ],
            );
          }
          })
      ),
    );
  }

  getNotifications() {
    //On Terminated
    FirebaseMessaging.instance.getInitialMessage().then((event) {
      if (event != null) {
        print("notification event: ${event.notification}, notification msg: ${event.notification!.title}");
        listController5.getTodayLists_full();
      }
      // if(event!.notification != null){
      //   {
      //   }
      // }
    });

    //On Foreground
    FirebaseMessaging.onMessage.listen((event) {
      print('Got a message whilst in the foreground!');
      print('Message data: ${event.data}');
      listController5.getTodayLists_full();
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
    FirebaseMessaging.onMessageOpenedApp.listen((event) => setState(() {
        notificationsStr =
        'Title : ${event.notification!.title}, Body : ${event.notification!.body} This is from Background State';
        MySnackbar.whiteSnackbar('Notification for you', notificationsStr!);
      }),);
  }
}

