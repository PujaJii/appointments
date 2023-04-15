// import 'package:dm_app/controller/accept_controller.dart';
// import 'package:dm_app/controller/list_today_controller.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:intl/intl.dart';
//
// import '../styles/app_colors.dart';
// import '../utils/constants/size_orientation.dart';
// import 'download_file_page.dart';
//
//
// class OnlyPending extends StatelessWidget {
//   const OnlyPending({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//
//     TodayListController listController3 = Get.find();
//     AcceptController acceptController = Get.find();
//     ScreenContext.getScreenContext(context);
//
//     if(ScreenContext.width! > 550) {
//
//       ///tablets........
//       return
//         GetX<TodayListController>(initState: (context) {
//           listController3.getPending();
//         }, builder: (controller) {
//           if (controller.isLoading3.value) {
//             return Expanded(child: Center(child: CircularProgressIndicator(color: AppColors.themeColor,)));
//           } else {
//             return
//               controller.appointmentList3.isEmpty?
//               Expanded(
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   crossAxisAlignment: CrossAxisAlignment.center,
//                   children: const[
//                     Center(child: Text('No Pending Appointments found!!',style: TextStyle(fontSize: 17),)),
//                   ],
//                 ),
//               ):
//               Expanded(
//               child: ListView.builder(
//                 itemCount: controller.appointmentList3.length,
//                 // shrinkWrap: true,
//                 //padding: const EdgeInsets.only(bottom: 30),
//                 itemBuilder: (context, index) {
//                   return Container(
//                     margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 15),
//                     decoration: BoxDecoration(
//                       boxShadow: const [
//                         BoxShadow(
//                           color: Colors.grey,
//                           blurRadius: 3,
//                           offset: Offset(
//                             0,
//                             3,
//                           ),
//                         )
//                       ],
//                       color: AppColors.white,
//                       borderRadius: BorderRadius.circular(10),
//                       // border: Border(
//                       //     bottom: BorderSide(
//                       //         color: Colors.black))
//                     ),
//                     child: Column(
//                       children: [
//                         const SizedBox(height: 8),
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                           children: [
//                             const SizedBox(width: 20,),
//                             Expanded(
//                               child: Column(
//                                 mainAxisAlignment: MainAxisAlignment.center,
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   Row(
//                                     mainAxisAlignment: MainAxisAlignment.end,
//                                     crossAxisAlignment: CrossAxisAlignment.end,
//                                     children: [
//                                       Icon(Icons.cancel_outlined,
//                                           color: Colors.grey[600]),
//                                     ],
//                                   ),
//                                   Row(
//                                     mainAxisAlignment: MainAxisAlignment
//                                         .spaceBetween,
//                                     children: [
//                                       Row(
//                                         children: [
//                                           SizedBox(
//                                               height: 20,
//                                               width: 20,
//                                               child: Image.asset(
//                                                   'assets/images/pending.png')),
//                                           Text(
//                                            '   ${controller.appointmentList3[index].recipientName!}',
//                                             style: const TextStyle(
//                                                 fontSize: 16,
//                                                 color: Colors.black),),
//                                         ],
//                                       ),
//                                       // const Text('Duration : 30 min   ',style: TextStyle(
//                                       //     fontSize: 11,
//                                       //     color: Colors.grey),),
//                                     ],
//                                   ),
//                                   // SizedBox(height: 10,),
//                                   Row(
//                                     mainAxisAlignment: MainAxisAlignment
//                                         .spaceBetween,
//                                     crossAxisAlignment: CrossAxisAlignment.start,
//                                     children: [
//                                        Expanded(
//                                         child: Padding(
//                                           padding: const EdgeInsets.only(left: 30.0),
//                                           child: Text(
//                                             'Details  -  ${controller.appointmentList3[index].meetingSubject!}',
//                                             style: const TextStyle(
//                                                 fontSize: 14,
//                                                 color: Colors.black),),
//                                         ),
//                                       ),
//                                       Row(
//                                         children: [
//                                           const SizedBox(width: 20,),
//                                           controller.appointmentList3[index].meetingDocuments == '0'?
//                                           Container():
//                                           Container(
//                                             child: Column(
//                                               children: [
//                                                 Image.asset('assets/images/pdf_img.png',
//                                                     width: 18,height: 24,fit: BoxFit.cover),
//                                                 const Text('Document',style: TextStyle(fontSize: 12,
//                                                     fontWeight: FontWeight.bold)),
//                                               ],
//                                             ),
//                                           ),
//                                           const SizedBox(width: 10),
//                                           InkWell(
//                                             onTap: () {
//                                               // Get.to(()=> const Reschedule());
//                                             },
//                                             child: Container(
//                                               padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 10),
//                                               decoration: BoxDecoration(
//                                                   color: AppColors.themeColorTwo,
//                                                   borderRadius: BorderRadius.circular(5)
//                                               ),
//                                               child: const Center(
//                                                   child:  Text('Approve',style:  TextStyle(color: Colors.white),)
//                                               ),
//                                             ),
//                                           ),
//                                           const SizedBox(width: 5,),
//                                           InkWell(
//                                             onTap: () {
//                                               // Get.to(()=> const Reschedule());
//                                             },
//                                             child: Container(
//                                               padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 10),
//                                               decoration: BoxDecoration(
//                                                   color: Colors.redAccent,
//                                                   borderRadius: BorderRadius.circular(5)
//                                               ),
//                                               child: const Center(
//                                                   child:  Text('  Reject  ',style:  TextStyle(color: Colors.white),)
//                                               ),
//                                             ),
//                                           ),
//                                           const SizedBox(width: 5,),
//                                           InkWell(
//                                             onTap: () {
//                                               // Get.to(()=> const Reschedule());
//                                             },
//                                             child: Container(
//                                               padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 10),
//                                               decoration: BoxDecoration(
//                                                   color: AppColors.themeColor,
//                                                   borderRadius: BorderRadius.circular(5)
//                                               ),
//                                               child: const Center(
//                                                   child:  Text('Wrong Entry?',style:  TextStyle(color: Colors.white),)
//                                               ),
//                                             ),
//                                           )
//                                         ],
//                                       ),
//                                     ],
//                                   ), const SizedBox(height: 5,),
//                                   Container(
//                                     height: 0.2,
//                                     width: double.infinity,
//                                     color: Colors.black,
//                                   ), const SizedBox(height: 8,),
//                                   Text(
//                                     '   Date : 13-11-2022         '
//                                         'Time : ${DateFormat("h:mm a").format(DateFormat("hh:mm").parse(controller.appointmentList3[index].meetingTime!))}',
//                                     style: TextStyle(
//                                         fontSize: 14,
//                                         color: Colors.grey[600]),),
//                                   const SizedBox(height: 8,),
//                                 ],
//                               ),
//                             ),
//                             const SizedBox(width: 20,),
//                           ],
//                         ),
//                         const SizedBox(height: 10,)
//                       ],
//                     ),
//                   );
//                 },),
//             );
//           }
//         }
//         );
//     }
//     ///phones........
//
//     return
//       GetX<TodayListController>(initState: (context) {
//         listController3.getPending();
//       }, builder: (controller) {
//         if (controller.isLoading3.value) {
//           return  Expanded(child: Center(child: CircularProgressIndicator(color: AppColors.themeColor,)));
//         } else {
//           return Expanded(
//             child: Column(
//               children: [
//                 const SizedBox(height: 5,),
//                 controller.appointmentList3.isEmpty?
//                 Expanded(
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     crossAxisAlignment: CrossAxisAlignment.center,
//                     children: const[
//                       Center(child: Text('No Pending Appointments found!!',style: TextStyle(fontSize: 17),)),
//                     ],
//                   ),
//                 ):
//                 Expanded(
//                   child: ListView.builder(
//                     itemCount: controller.appointmentList3.length,
//                     // shrinkWrap: true,
//                     padding: const EdgeInsets.only(bottom: 30),
//                     itemBuilder: (context, index) {
//                       return Container(
//                         margin: const EdgeInsets.symmetric(vertical: 8,horizontal: 15),
//                         // height: 100,
//                         decoration: BoxDecoration(
//                           boxShadow: const [
//                             BoxShadow(
//                               color: Colors.grey,
//                               blurRadius: 3,
//                               offset: Offset(
//                                 0,
//                                 3,
//                               ),
//                             )],
//                           color: Colors.white,
//                           borderRadius: BorderRadius.circular(10),
//                         ),
//                         child: Column(
//                           children: [
//                             const SizedBox(height: 8),
//                             Row(
//                               mainAxisAlignment:  MainAxisAlignment.spaceEvenly,
//                               children: [
//                                 const SizedBox(width: 20,),
//                                 Expanded(
//                                   child: Column(
//                                     mainAxisAlignment: MainAxisAlignment.center,
//                                     crossAxisAlignment: CrossAxisAlignment.start,
//                                     children: [
//                                       // Row(
//                                       //   mainAxisAlignment: MainAxisAlignment.end,
//                                       //   crossAxisAlignment: CrossAxisAlignment.end,
//                                       //   children:  [
//                                       //     Icon(Icons.cancel_outlined,color: Colors.grey[600]),
//                                       //   ],
//                                       // ),
//                                       const SizedBox(height: 10,),
//                                       Row(
//                                         mainAxisAlignment: MainAxisAlignment.start,
//                                         crossAxisAlignment: CrossAxisAlignment.start,
//                                         children: [
//                                           SizedBox(
//                                               height: 18,
//                                               width: 18,
//                                               child: Image.asset(
//                                                   'assets/images/pending.png')),
//                                            Expanded(
//                                             child:  Padding(
//                                               padding: const EdgeInsets.only(left: 5.0),
//                                               child: Text(controller.appointmentList3[index].recipientName!,style: const  TextStyle(
//                                                   fontSize: 14,
//                                                   color: Colors.black),),
//                                             ),
//                                           ),
//                                         ],
//                                       ),
//                                       // SizedBox(height: 10,),
//                                       Row(
//                                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                         crossAxisAlignment: CrossAxisAlignment.start,
//                                         children: [
//                                           Expanded(
//                                             child:  Padding(
//                                               padding: const EdgeInsets.only(left: 23.0),
//                                               child: Text('Details -  ${controller.appointmentList3[index].meetingSubject}',
//                                                 style: TextStyle(
//                                                     fontSize: 12,
//                                                     color: Colors.grey[600]),),
//                                             ),
//                                           ),
//                                         ],
//                                       ),
//                                       const SizedBox(height: 10,),
//
//                                       Column(
//                                         children: [
//                                           Row(
//                                             mainAxisAlignment: MainAxisAlignment.end,
//                                             crossAxisAlignment: CrossAxisAlignment.end,
//                                             children: [
//                                               controller.appointmentList3[index].meetingDocuments == '0'?
//                                               Container():
//                                               InkWell(
//                                                 onTap: () async {
//                                                   print('DOWNLOAD btn');
//                                                   Get.to(DownloadFilePage(controller.appointmentList3[index].meetingDocuments!));
//                                                 },
//                                                 child: Container(
//                                                   child: Column(
//                                                     children: [
//                                                       Image.asset('assets/images/pdf_img.png',
//                                                           width: 17,height: 22,fit: BoxFit.contain),
//                                                       const Text('Download',style: TextStyle(fontSize: 10,
//                                                       )),
//                                                     ],
//                                                   ),
//                                                 ),
//                                               ),
//                                               const SizedBox(width: 15,),
//                                               InkWell(
//                                                 onTap: () {
//                                                   acceptController.acceptRequest1(controller.appointmentList3[index].id.toString());
//                                                 },
//                                                 child: Container(
//                                                   padding: const EdgeInsets.symmetric(vertical: 4,horizontal: 10),
//                                                   decoration: BoxDecoration(
//                                                       color: Colors.white70,
//                                                       borderRadius: BorderRadius.circular(5)
//                                                   ),
//                                                   child:  Center(
//                                                       child:
//                                                       Icon(Icons.done,color: AppColors.themeColorTwo,)
//                                                     // Text('    Approve    ',style:  TextStyle(color: Colors.white),)
//                                                   ),
//                                                 ),
//                                               ),
//                                               const SizedBox(width: 5,),
//                                               InkWell(
//                                                 onTap: () {
//                                                   acceptController.rejectRequest(controller.appointmentList3[index].id.toString());
//                                                 },
//                                                 child: Container(
//                                                   padding: const EdgeInsets.symmetric(vertical: 4,horizontal: 10),
//                                                   decoration: BoxDecoration(
//                                                       color: Colors.white70,
//                                                       borderRadius: BorderRadius.circular(5)
//                                                   ),
//                                                   child: const Center(
//                                                       child:  Icon(Icons.cancel_outlined,color: Colors.redAccent,)
//                                                     // Text('      Reject      ',
//                                                     //   style:  TextStyle(color: Colors.white),)
//                                                   ),
//                                                 ),
//                                               ), const SizedBox(width: 5,),
//                                               InkWell(
//                                                 onTap: () {
//                                                   // Get.to(()=> const Reschedule());
//                                                 },
//                                                 child: Container(
//                                                   padding: const EdgeInsets.symmetric(vertical: 5,horizontal: 10),
//                                                   decoration: BoxDecoration(
//                                                       color: Colors.white70,
//                                                       borderRadius: BorderRadius.circular(5)
//                                                   ),
//                                                   child: Center(
//                                                       child:  Icon(Icons.edit,size: 22,color: AppColors.themeColor,)
//                                                     // Text('      Reject      ',
//                                                     //   style:  TextStyle(color: Colors.white),)
//                                                   ),
//                                                 ),
//                                               ),
//                                             ],
//                                           ),
//                                           const SizedBox(height: 5,),
//                                         ],
//                                       ),
//                                       const SizedBox(height: 8,),
//                                       Container(
//                                         height: 0.2,
//                                         width: double.infinity,
//                                         color: Colors.black,
//                                       ), const SizedBox(height: 8,),
//                                       Text('   Date : ${controller.appointmentList3[index].meetingDate!.year}-'
//                                           '${controller.appointmentList3[index].meetingDate!.month}-'
//                                           '${controller.appointmentList3[index].meetingDate!.day}             '
//                                           'Time : ${DateFormat("h:mm a").format(DateFormat("hh:mm").parse(controller.appointmentList3[index].meetingTime!))}',
//                                         style: TextStyle(
//                                             fontSize: 12,
//                                             color: Colors.grey[600]),),
//                                     ],
//                                   ),
//                                 ),
//                                 const SizedBox(width: 20,),
//                               ],
//                             ),
//                             const SizedBox(height: 10,)
//                           ],
//                         ),
//                       );
//                     },
//                   ),
//                 ),
//               ],
//             ),
//           );
//         }
//       }
//       );
//
//   }
// }
