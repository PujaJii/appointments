import '../controller/list_today_controller.dart';
import '../styles/common_module/my_widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../styles/app_colors.dart';


class RejectedList  {

 static Widget onlyRejects(BuildContext context, var myController){
    return
      GetX<TodayListController>(initState: (context) {
        myController.getRejectList();
      },
          builder: (controller) {
        if (controller.isLoadingReject.value) {
          return  Expanded(child: Center(child: CircularProgressIndicator(color: AppColors.themeColor,)));
        } else {
          print(controller.listReject.length);
          return Expanded(
            child: Column(
              children: [
                const SizedBox(height: 5,),
                controller.listReject.isEmpty?
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: const[
                      Center(child: Text('No Rejected Appointments found!!',style: TextStyle(fontSize: 17),)),
                    ],
                  ),
                ):
                Expanded(
                  child: ListView.builder(
                    itemCount: controller.listReject.length,
                    // shrinkWrap: true,
                    padding: const EdgeInsets.only(bottom: 30),
                    itemBuilder: (context, index) {
                      return MyWidgets.myContainer(context,index,controller.listReject,'');
                    },
                  ),
                ),
              ],
            ),
          );
        }
      }
     );
  }
}
