import '../styles/common_module/my_widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/list_today_controller.dart';
import '../styles/app_colors.dart';


class OnlyApprovedList {
  static Widget onlyApproved(BuildContext context, var myController,) {
    return
      GetX<TodayListController>(initState: (context) {
        myController.getApproved();
      }, builder: (controller) {
        if (controller.isLoadingApproved.value) {
          return
              Expanded(
                  child: Center(child: CircularProgressIndicator(color: AppColors.themeColor,)));
        } else {
          return
            Expanded(
              child: Column(
                children: [
                  const SizedBox(height: 5,),
                  controller.listApproved.isEmpty?
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: const[
                        Center(child: Text('No Appointments found!!',style: TextStyle(fontSize: 17),)),
                      ],
                    ),
                  ):
                  Expanded(
                    child: ListView.builder(
                      itemCount: controller.listApproved.length,
                      // shrinkWrap: true,
                      padding: const EdgeInsets.only(bottom: 30),
                      itemBuilder: (context, index) {
                        return MyWidgets.myContainer(context,index, controller.listApproved,'');
                        },
                      ),
                    ),
            ],
          ),
        );
      }
    });
  }
}
