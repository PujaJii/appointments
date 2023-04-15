import '../apis/list_today_api.dart';
import 'package:get/get.dart';

import '../models/list_today_model.dart';


class TodayListControllerFull extends GetxController{

  var isLoading = false.obs;
  static var pendingListLength = 0.obs;
  var appointmentList = <Appointments>[].obs;
  static var notificationNum = '0'.obs;


  getTodayLists_full() async {
    try {
      isLoading(true);
      var apiResponse = await TodayListApi.getTodayList('all');

      if (apiResponse != null) {
        if (apiResponse.response == 'success') {
          appointmentList.assignAll(apiResponse.data!);
          notificationNum.value = appointmentList.length.toString();
        }
      }
    } finally {
      isLoading(false);
    }
  }

}
