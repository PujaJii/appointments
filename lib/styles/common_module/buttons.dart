import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../views/reschedule.dart';
import '../app_colors.dart';



class MyButtons{
  // static Widget reschedule(int index){
  //   return InkWell(
  //     onTap: () {
  //
  //       Get.to(()=> Reschedule(index: index));
  //     },
  //     child: Container(
  //       padding: const EdgeInsets.symmetric(vertical: 7,horizontal: 10),
  //       decoration: BoxDecoration(
  //           color: AppColors.themeColor,
  //           borderRadius: BorderRadius.circular(5)
  //       ),
  //       child: const Center(
  //           child:
  //           Text('Wrong Entry?',
  //             style:  TextStyle(color: Colors.white,fontSize: 12),)
  //       ),
  //     ),
  //   );
  // }
  static Widget rescheduleIcon(int index,double size, var controller){
    return InkWell(
      onTap: () {
        Get.to(()=> Reschedule(index: index, controller: controller,));
      },
        child: Icon(Icons.edit_outlined,size: size,color: AppColors.themeColorTwo,));
  }

  static Widget approvedButton (var acceptController, String id){
    return  InkWell(
      onTap: () {
        acceptController.acceptRequest1(id);
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
            Text('Approve',style:  TextStyle(color: Colors.white,fontSize: 12),)
        ),
      ),
    );
  }
  static Widget rejectButton( var acceptController, String id){
    return    InkWell(
      onTap: () {
        acceptController.rejectRequest(id);
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
              style:  TextStyle(color: Colors.white,fontSize: 12),)
        ),
      ),
    );
  }
}