import '../styles/common_module/my_widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/list_today_controller.dart';
import '../styles/app_colors.dart';

class PendingListPage{

  static Widget onlyPending(BuildContext context, var myController,var acceptCtrl,){
    ///Phones...................
    return GetX<TodayListController>(initState: (context) {
      myController.getPending();
    }, builder: (controller) {
      if (controller.isLoadingPending.value) {
        return  Expanded(child: Center(child: CircularProgressIndicator(color: AppColors.themeColor,)));
      } else {
        return Expanded(
          child: Column(
            children: [
              const SizedBox(height: 5,),
              controller.listPending.isEmpty?
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: const[
                    Center(child: Text('No Pending Appointments found!!',style: TextStyle(fontSize: 17),)),
                  ],
                ),
              ):
              Expanded(
                child: ListView.builder(
                  itemCount: controller.listPending.length,
                  // shrinkWrap: true,
                  padding: const EdgeInsets.only(bottom: 30),
                  itemBuilder: (context, index) {
                    return MyWidgets.myContainer(
                        context,index, controller.listPending,'',
                        acceptController: acceptCtrl,
                    );
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