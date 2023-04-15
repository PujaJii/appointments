import '../apis/log_history_api.dart';
import 'package:get/get.dart';

import '../models/log_history_model.dart';



class LogHistoryController extends GetxController{

  var isLoading = false.obs;
  var logHistoryList = <LogHistoryList>[].obs;


  getLogHistoryList() async {
    try {
      isLoading(true);
      var apiResponse = await LogHistoryApi.getLogHistory('log_history');

      if (apiResponse != null) {
        if (apiResponse.response == 'success') {
          logHistoryList.assignAll(apiResponse.data!.reversed);
          // logHistoryList.reversed;
        }
      }
    } finally {
      isLoading(false);
    }
  }
}
