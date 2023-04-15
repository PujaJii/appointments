
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animated_dialog/flutter_animated_dialog.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../controller/del_ap_controller.dart';
import '../../utils/constants/size_orientation.dart';
import '../../views/download_file_page.dart';
import '../app_colors.dart';
import 'buttons.dart';
import 'my_snack_bar.dart';

class MyWidgets {
  static Widget textView(String text, Color colors, double fontSize,
          {FontWeight? fontWeight}
      ) =>
      Text(
        text,
        style: TextStyle(
            color: colors, fontSize: fontSize, fontWeight: fontWeight),
      );
  static Widget myContainer(BuildContext context,int? index,var controllerList,String time,
  {var acceptController}){
    DeleteController deleteController = Get.find();

    final box = GetStorage();

    String duration = controllerList[index].minutes.toString();
    String _formatDateTime() {
      if(duration != 'null'){
        int totalMinutes = int.parse(duration);
        int hours = (totalMinutes) ~/ 60; // ~ operator performs integer division
        int minutes = totalMinutes % 60;
        if(hours== 0){
          return  ' $minutes min';
        }else if(minutes == 0){
          return '$hours hr';
        }
        return '$hours hr $minutes min';
      }
      return '';
    }
    String formattedTime = _formatDateTime();
    //String formattedTime = '$hours hr $minutes min';

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
    int daysBetween(DateTime from,DateTime to) {
      from = DateTime(from.year, from.month, from.day);
      to =  DateTime(to.year, to.month, to.day);
      return (from.difference(to).inHours / 24).round();
    }
    ScreenContext.getScreenContext(context);
    if(ScreenContext.width! >= 550) {
      ///Tablet...............
      return
        controllerList[index].status.toString() == '3'?
        Container():
        Container(
          margin: const EdgeInsets.symmetric(vertical: 2,horizontal: 25),
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
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment:  MainAxisAlignment.spaceEvenly,
                children: [
                  const SizedBox(width: 20,),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 10,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children:  [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                // Text('  Date : ${controllerList[index].meetingDate!.day} - '
                                //     '${controllerList[index].meetingDate!.month} - '
                                //     '${controllerList[index].meetingDate!.year}',
                                //   style: TextStyle(
                                //       fontSize: 12,
                                //       color: Colors.grey[600]),),
                                Text('   ${DateFormat("h:mm a").format(DateFormat("hh:mm").parse(controllerList[index].meetingTime!))}',
                                    style: TextStyle(
                                        fontSize: 12,
                                        color: AppColors.themeColor)),
                                const SizedBox(width: 25,),
                                Text('  Duration : ${controllerList[index].minutes} min',
                                    style: TextStyle(
                                        fontSize: 12,
                                        color: Colors.grey[600]))
                              ],
                            ),
                            time == 'history'?
                            const SizedBox():
                            Row(
                              children: [
                                MyButtons.rescheduleIcon(index!,28,controllerList),
                                const SizedBox(width: 25,),
                                InkWell(
                                    onTap: (){
                                      showAnimatedDialog(context: context,
                                          animationType: DialogTransitionType.scale,
                                          curve: Curves.fastOutSlowIn,
                                          // duration: const Duration(seconds: 1),
                                          barrierDismissible: true,
                                          builder: (BuildContext context) {
                                            return AlertDialog(
                                              title: const Text("Delete Appointment!!",
                                                  style: TextStyle(color: Colors.redAccent)),
                                              content: const Text(
                                                  "Are you sure you want to delete this appointment?"),
                                              actions: [
                                                ElevatedButton(
                                                  onPressed: () {
                                                    deleteController.deleteRequest(controllerList[index].id.toString());
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
                                    child: Icon(Icons.cancel_outlined,size: 28,color: Colors.grey[600])),
                              ],
                            ),

                          ],
                        ),
                        const SizedBox(height: 8),
                        Container(
                          height: 0.2,
                          width : double.infinity,
                          color : Colors.black,
                        ),
                        const SizedBox(height: 8,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            controllerList[index].meetingType.toString() == '2'?
                            SizedBox(
                                height: 18,
                                width: 35,
                                child: Image.asset(
                                  'assets/images/vip.png',fit: BoxFit.fill,color: Colors.amber,)):
                            controllerList[index].status.toString() == '1'?
                            SizedBox(
                                height: 23,
                                width: 23,
                                child: Image.asset(
                                    'assets/images/pre_approved.png')):
                            controllerList[index].status.toString() == '0'?
                            SizedBox(
                                height: 23,
                                width: 23,
                                child: Image.asset(
                                    'assets/images/pending.png')):
                            controllerList[index].status.toString() == '3'?
                            SizedBox(
                                height: 23,
                                width: 23,
                                child: Image.asset(
                                    'assets/images/rejected.png')):
                            SizedBox(
                                height: 23,
                                width: 23,
                                child: Image.asset(
                                    'assets/images/recent_visitor.png')),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.only(left: 5.0),
                                child:  Text('${controllerList[index].meetingSubject}',
                                  style: const TextStyle(
                                      fontSize: 14,
                                      color: Colors.black),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child:  Padding(
                                padding: const EdgeInsets.only(left: 23.0),
                                child:  controllerList[index].meetingType == '1'? // Pre Approved.....
                                Text('Meeting',
                                  style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.grey[600]),):
                                Text('Visitor: ${controllerList[index].recipientName}',
                                  style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.grey[600]),
                                ),
                              ),
                            ),const SizedBox(width: 5,),
                            time == 'history'?
                            Center(child:
                            Text(
                              daysBetween(DateTime.now(),controllerList[index].meetingDate).toString() == '1'?
                              '${daysBetween(DateTime.now(),controllerList[index].meetingDate)} Day ago':
                              '${daysBetween(DateTime.now(),controllerList[index].meetingDate)} Days ago',
                              style: TextStyle(color: AppColors.themeColor3),)):
                            time== 'Upcoming'?
                            Center(child:
                            Text(
                              daysBetween(controllerList[index].meetingDate, DateTime.now()).toString() == '1'?
                              '${daysBetween(controllerList[index].meetingDate, DateTime.now())} Day Remaining':
                              '${daysBetween(controllerList[index].meetingDate, DateTime.now())} Days Remaining',
                              style: TextStyle(color: AppColors.themeColor3),)):


                            ///page for DM




                            box.read('role').toString() == 'DM'?
                            controllerList[index].meetingType.toString() == '2'?
                            const SizedBox():
                            controllerList[index].status == 0?
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
                                        acceptController.acceptRequest1(controllerList[index].id.toString());
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
                                        acceptController.rejectRequest(controllerList[index].id.toString());
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
                                    //MyButtons.reschedule(index!),
                                  ],
                                ),
                                const SizedBox(height: 5,),
                              ],
                            ):
                            controllerList[index].status == 1?
                            //Pre Approved page
                            const Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                //MyButtons.reschedule(index!),
                                SizedBox(width: 5,),
                              ],
                            ):
                            controllerList[index].status == 2?
                            //after approving appointment
                            Container() :
                            controllerList[index].status == 3?
                            //After Rejected
                            const Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                //  const SizedBox(width: 5,),
                                SizedBox(width: 15,),
                                //MyButtons.reschedule(index!),
                                SizedBox(width: 5,),
                              ],
                            ):
                            controllerList[index].status == 4?
                            //Visitor arrived
                            Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    const SizedBox(width: 15,),
                                    Container(
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
                                    const SizedBox(width: 5,),
                                    InkWell(
                                      onTap: () {
                                        acceptController.sendInRequest(controllerList[index].id.toString());
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
                            controllerList[index].status == 5?
                            Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        acceptController.completeRequest(controllerList[index].id.toString());
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
                            controllerList[index].status == 6?
                            Center(child: Column(
                              children: [
                                Text('Meeting time: ${box.read('sendTime')} - ${box.read('completeTime')}',
                                  style: TextStyle(color: AppColors.themeColorTwo,fontSize: 11),),
                                Text('Conversation Complete!!',
                                  style: TextStyle(color: AppColors.themeColorTwo,fontSize: 16),),
                              ],
                            ),):
                            const Center(child: Text('Something went Wrong!!')):




                            ///page for PA


                            controllerList[index].meetingType.toString() == '2'?
                            const SizedBox():
                            controllerList[index].status == 0?
                            //wrong entry
                            const Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    //MyButtons.reschedule(index!),
                                  ],
                                ),
                                SizedBox(height: 5,),
                              ],
                            ):
                            controllerList[index].status == 1?
                            //Pre Approved page
                            const Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                //  const SizedBox(width: 5,),
                                SizedBox(width: 15,),
                               // MyButtons.reschedule(index!),
                                SizedBox(width: 5,),
                              ],
                            ):
                            controllerList[index].status == 2?
                            //after approving appointment
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                InkWell(
                                  onTap: () {
                                    acceptController.arrivedRequest(controllerList[index].id.toString());
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
                            ):
                            controllerList[index].status == 3?
                            //After Rejected
                            const Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                //  const SizedBox(width: 5,),
                                SizedBox(width: 15,),
                               // MyButtons.reschedule(index!),
                                SizedBox(width: 5,),
                              ],
                            ):
                            controllerList[index].status == 4?
                            //Visitor arrived
                            Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    const SizedBox(width: 15,),
                                    Container(
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
                                  ],
                                ),
                                const SizedBox(height: 5,),
                              ],
                            ):
                            controllerList[index].status == 5?
                            Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        acceptController.completeRequest(controllerList[index].id.toString());
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
                            ):
                            controllerList[index].status == 6?
                            Center(child: Column(
                              children: [
                                Text('Meeting time: ${box.read('sendTime')} - ${box.read('completeTime')}',
                                  style: TextStyle(color: AppColors.themeColorTwo,fontSize: 11),),
                                Text('Conversation Complete!!',
                                  style: TextStyle(color: AppColors.themeColorTwo,fontSize: 16),),
                              ],
                            )):
                            const Center(child: Text('Something went Wrong!!')),
                          ],
                        ),
                        const SizedBox(height: 10,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            controllerList[index].videoConfaranceLink == null
                                || controllerList[index].videoConfaranceLink == '0' ?
                            Container(width: 5,):
                            InkWell(
                                onTap: () {
                                  //print(controllerList[index].videoConfaranceLink);
                                  Clipboard.setData(ClipboardData(
                                      text: controllerList[index].videoConfaranceLink))
                                      .then((_) => ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                                           content: Text(
                                            'Copied to clipboard',
                                           // textAlign: TextAlign.right,
                                 ))));
                                },
                                child: const Icon(Icons.copy,size: 22,)),
                            const SizedBox(width: 8),
                            controllerList[index].videoConfaranceLink == null || controllerList[index].videoConfaranceLink == '0' ?
                                Container(width: 5,):
                            Expanded(
                                flex: 1,
                                child: InkWell(
                                  onTap: () {
                                  //  print('Hello');
                                    _launchUrl(controllerList[index].videoConfaranceLink!);
                                  },
                                  child: Text(
                                    controllerList[index].videoConfaranceLink!,style: TextStyle(
                                      decoration: TextDecoration.underline,color: AppColors.themeColor,fontSize: 15),),
                                )
                            ),
                            controllerList[index].meetingDocuments == '0'?
                            Container(width: 5,):
                            InkWell(
                              onTap: () {
                                Get.to(()=>DownloadFilePage(controllerList[index].meetingDocuments!));
                              },
                              child: Container(
                                child: Column(
                                  children: [
                                    Image.asset('assets/images/pdf_img.png',
                                        width: 15,height: 20,fit: BoxFit.contain,color: AppColors.themeColor),
                                    const Text('Document',style: TextStyle(fontSize: 10,
                                    )),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 5,),
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
    }
    ///Phones.................
    return
      controllerList[index].status.toString() == '3'?
      Container():
      Container(
      margin: const EdgeInsets.symmetric(vertical: 2,horizontal: 10),
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
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment:  MainAxisAlignment.spaceEvenly,
            children: [
              const SizedBox(width: 20,),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            //Text(DateFormat('h:mm a').format(DateFormat("HH:mm").parse(controllerList[index].meetingTime!))),
                            Text('   ${DateFormat("h:mm a").format(DateFormat("HH:mm").parse(controllerList[index].meetingTime!))}',
                                style: TextStyle(
                                    fontSize: 13,
                                    color: AppColors.themeColor)),
                            const SizedBox(width: 15),
                            Text('  Duration : ${formattedTime.toString()}  ',
                                style: TextStyle(
                                    fontSize: 12,
                                    color: AppColors.themeColor))
                          ],
                        ),
                        //SizedBox(width: 5,),
                        time == 'history'?
                        const SizedBox():
                        Row(
                          children: [
                            MyButtons.rescheduleIcon(index!,20,controllerList),
                            const SizedBox(width: 15),
                            InkWell(
                                onTap: () {
                                  showAnimatedDialog(context: context,
                                      animationType: DialogTransitionType.scale,
                                      curve: Curves.fastOutSlowIn,
                                      // duration: const Duration(seconds: 1),
                                      barrierDismissible: true,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          title: const Text("Delete Appointment!!",
                                              style: TextStyle(color: Colors.redAccent)),
                                          content: const Text(
                                              "Are you sure you want to delete this appointment?"),
                                          actions: [
                                            ElevatedButton(
                                              onPressed: () {
                                                deleteController.deleteRequest(controllerList[index].id.toString());
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
                      ],
                    ),
                    const SizedBox(height: 5,),
                    Container(
                      height: 0.2,
                      width : double.infinity,
                      color : Colors.grey,
                    ),
                    const SizedBox(height: 5,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        controllerList[index].meetingType.toString() == '2'?
                        SizedBox(
                            height: 18,
                            width: 35,
                            child: Image.asset(
                              'assets/images/vip.png',fit: BoxFit.fill,color: Colors.amber)):
                        controllerList[index].status.toString() == '0'?
                        SizedBox(
                            height: 19,
                            width: 19,
                            child: Image.asset(
                                'assets/images/pending.png')):
                        controllerList[index].status.toString() == '1'?
                        SizedBox(
                            height: 19,
                            width: 19,
                            child: Image.asset(
                                'assets/images/pre_approved.png')):
                        controllerList[index].status.toString() == '3'?
                        SizedBox(
                            height: 19,
                            width: 19,
                            child: Image.asset(
                                'assets/images/rejected.png')):
                        SizedBox(
                            height: 19,
                            width: 19,
                            child: Image.asset(
                                'assets/images/recent_visitor.png')),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(left: 5.0),
                            child:
                            Text('${controllerList[index].meetingSubject}',
                              style: const TextStyle(
                                  fontSize: 13,
                                  color: Colors.black),
                            ),

                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child:  Padding(
                            padding: const EdgeInsets.only(left: 23,top: 5),
                            child: controllerList[index].meetingType == '1'? // Pending.....
                            Text('Meeting',
                              style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey[600]),):
                            Text('Visitor : ${controllerList[index].recipientName}',
                              style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey[600]),),
                          ),
                        ),
                        controllerList[index].meetingDocuments == '0'?
                        Container(width: 45,):
                        InkWell(
                          onTap: () {
                            Get.to(()=> DownloadFilePage(controllerList[index].meetingDocuments!));
                          },
                          child: Container(
                            child: Column(
                              children: [
                                Image.asset('assets/images/pdf_img.png',
                                    width: 15,height: 20,fit: BoxFit.contain,color: AppColors.themeColor),
                                const Text('Document',style: TextStyle(fontSize: 10,
                                )),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    //const SizedBox(height: 2,),


                    time == 'history'?
                    Center(child:
                    Text(
                        daysBetween(DateTime.now(),controllerList[index].meetingDate).toString() == '1'?
                      '${daysBetween(DateTime.now(),controllerList[index].meetingDate)} Day ago':
                        '${daysBetween(DateTime.now(),controllerList[index].meetingDate)} Days ago',
                      style: TextStyle(color: AppColors.themeColor3),)):
                    time== 'Upcoming'?
                    Center(child:
                     Text(
                       daysBetween(controllerList[index].meetingDate, DateTime.now()).toString() == '1'?
                      '${daysBetween(controllerList[index].meetingDate, DateTime.now())} Day Remaining':
                      '${daysBetween(controllerList[index].meetingDate, DateTime.now())} Days Remaining',
                      style: TextStyle(color: AppColors.themeColor3),)):


                    ///page for DM


                    box.read('role').toString() == 'DM'?
                    controllerList[index].meetingType.toString() == '2'?
                    const SizedBox():
                    controllerList[index].status == 0?
                    // Approve + reject + wrong entry
                    Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const SizedBox(width: 5,),
                            MyButtons.approvedButton(acceptController, controllerList[index].id.toString()),
                            const SizedBox(width: 5,),
                            MyButtons.rejectButton(acceptController, controllerList[index].id.toString()),
                            const SizedBox(width: 5,),
                           // MyButtons.reschedule(index!),
                          ],
                        ),
                        const SizedBox(height: 5,),
                      ],
                    ):
                    controllerList[index].status == 1?
                    //Pre Approved page
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        //MyButtons.reschedule(index!),
                        SizedBox(width: 5,),
                      ],
                    ):
                    controllerList[index].status == 2?
                    //after approving appointment
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(vertical: 8,horizontal: 15),
                          decoration: BoxDecoration(
                              color: AppColors.themeColor,
                              borderRadius: BorderRadius.circular(5)
                          ),
                          child: const Center(
                              child:  Text('Not Arrived',style:  TextStyle(color: Colors.white,fontSize: 12),)
                          ),
                        ),
                      ],
                    ):
                    controllerList[index].status == 3?
                    //After Rejected
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        //  const SizedBox(width: 5,),
                        SizedBox(width: 15,),
                        //MyButtons.reschedule(index!),
                        SizedBox(width: 5,),
                      ],
                    ):
                    controllerList[index].status == 4?
                    //Visitor arrived
                    Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const SizedBox(width: 15,),
                            Container(
                              padding: const EdgeInsets.symmetric(vertical: 7,horizontal: 10),
                              decoration: BoxDecoration(
                                  color: AppColors.themeColorTwo,
                                  borderRadius: BorderRadius.circular(5)
                              ),
                              child: const Center(
                                  child:
                                  // Icon(Icons.done,color: AppColors.themeColorTwo,)
                                  Text('Waiting...',style:  TextStyle(color: Colors.white,fontSize: 12),)
                              ),
                            ),
                            const SizedBox(width: 5,),
                            InkWell(
                              onTap: () {
                                acceptController.sendInRequest(controllerList[index].id.toString());
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
                                      style:  TextStyle(color: Colors.white,fontSize: 12),)
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 5,),
                      ],
                    ):
                    //pa only waiting
                    controllerList[index].status == 5?
                    Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            InkWell(
                              onTap: () {
                                acceptController.completeRequest(controllerList[index].id.toString());
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
                                    Text('Complete conversation',style:  TextStyle(color: Colors.white,fontSize: 12),)
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 5,),
                      ],
                    ):
                    //Waiting approved.....
                    controllerList[index].status == 6?
                    Center(
                     child: Column(
                      children: [
                        box.read('sendTime')== null||box.read('completeTime')==null?
                        Text('Meeting time: ${box.read('sendTime')} - ${box.read('completeTime')}',
                          style: TextStyle(color: AppColors.themeColorTwo,fontSize: 10),):
                        const SizedBox(),
                        Text('Conversation Complete!!',
                          style: TextStyle(color: AppColors.themeColorTwo,fontSize: 15))
                      ],
                    ),):
                    const Center(child: Text('Something went Wrong!!')):




                    ///page for PA



                    controllerList[index].meetingType.toString() == '2'?
                    const SizedBox():
                    controllerList[index].status == 0?
                    //wrong entry
                    const Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            //MyButtons.reschedule(index!),
                          ],
                        ),
                        SizedBox(height: 5,),
                      ],
                    ):
                    controllerList[index].status == 1?
                    //Pre Approved page
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        //  const SizedBox(width: 5,),
                        SizedBox(width: 15,),
                        //MyButtons.reschedule(index!),
                        SizedBox(width: 5,),
                      ],
                    ):
                    controllerList[index].status == 2?
                    //after approving appointment
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        InkWell(
                          onTap: () {
                            acceptController.arrivedRequest(controllerList[index].id.toString());
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(vertical: 8,horizontal: 15),
                            decoration: BoxDecoration(
                                color: AppColors.themeColor,
                                borderRadius: BorderRadius.circular(5)
                            ),
                            child: const Center(
                                child:  Text('Arrived?',style:  TextStyle(color: Colors.white,fontSize: 12),)
                            ),
                          ),
                        ),
                      ],
                    ) :
                    controllerList[index].status == 3?
                    //After Rejected
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        //  const SizedBox(width: 5,),
                        SizedBox(width: 15,),
                        //MyButtons.reschedule(index!),
                        SizedBox(width: 5,),
                      ],
                    ):
                    controllerList[index].status == 4?
                    //Visitor arrived
                    Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const SizedBox(width: 15,),
                            Container(
                              padding: const EdgeInsets.symmetric(vertical: 7,horizontal: 10),
                              decoration: BoxDecoration(
                                  color: AppColors.themeColorTwo,
                                  borderRadius: BorderRadius.circular(5)
                              ),
                              child: const Center(
                                  child:
                                  // Icon(Icons.done,color: AppColors.themeColorTwo,)
                                  Text('Waiting...',style:  TextStyle(color: Colors.white,fontSize: 12),)
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 5,),
                      ],
                    )
                        :
                    controllerList[index].status == 5?
                    Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            InkWell(
                              onTap: () {
                              //  acceptController.completeRequest(controllerList[index].id.toString());
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
                                    Text('Waiting approved',style:  TextStyle(color: Colors.white,fontSize: 12),)
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 5,),
                      ],
                    ) :
                    controllerList[index].status == 6?
                     Center(child: Column(
                       children: [
                         Text('Meeting time: ${box.read('sendTime')} - ${box.read('completeTime')}',
                           style: TextStyle(color: AppColors.themeColorTwo,fontSize: 10)),
                         Text('Conversation Complete!!',
                           style: TextStyle(color: AppColors.themeColorTwo,fontSize: 15),),

                       ],
                     )):
                    const Center(child: Text('Something went Wrong!!')),



                    //const SizedBox(height: 5,),
                    controllerList[index].videoConfaranceLink == null
                    || controllerList[index].videoConfaranceLink == '0' ?
                    Container():
                    Row(
                       mainAxisAlignment: MainAxisAlignment.end,
                       children: [
                        InkWell(
                            onTap: () {
                              Clipboard.setData(ClipboardData(text: controllerList[index].videoConfaranceLink));
                            },
                            child: const Icon(Icons.copy,size: 18,)),
                        const SizedBox(width: 5),
                        Expanded(
                          flex: 1,
                            child: InkWell(
                              onTap: () {
                              //  print('Hello');
                                _launchUrl(controllerList[index].videoConfaranceLink!);
                              },
                              child: Text(
                                  controllerList[index].videoConfaranceLink!,style: TextStyle(
                                  decoration: TextDecoration.underline,color: AppColors.themeColor),),
                            )
                        ),
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
    );
  }
}