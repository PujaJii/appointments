import '../apis/filter_api.dart';
import '../apis/list_today_api.dart';
import 'package:get/get.dart';

import '../models/list_today_model.dart';


class TodayListController extends GetxController{

  //var myDate = ''.obs;
  //var isLoadingAll = false.obs;
  var isLoadingFilter = false.obs;
  var isLoadingPreApproved = false.obs;
  var isLoadingApproved = false.obs;
  var isLoadingPending = false.obs;
  var isLoadingReject = false.obs;
  var isLoadingVIP = false.obs;
  var isLoadingHistory = false.obs;
  var isLoadingUpcoming = false.obs;
  static var pendingListLength = 0.obs;
  //var listAll = <Appointments>[].obs;
  var listFilter = <Appointments>[].obs;
  var listPreApproved = <Appointments>[].obs;
  var listApproved = <Appointments>[].obs;
  var listPending = <Appointments>[].obs;
  var listReject = <Appointments>[].obs;
  var listVIP = <Appointments>[].obs;
  var listHistory = <Appointments>[].obs;
  var listUpcoming = <Appointments>[].obs;
  static var notificationNum = '0'.obs;

  // getTodayLists() async {
  //   try {
  //     isLoadingAll(true);
  //     var apiResponse = await TodayListApi.getTodayList('all');
  //
  //     if (apiResponse != null) {
  //       if (apiResponse.response == 'success') {
  //         listAll.assignAll(apiResponse.data!);
  //         notificationNum.value = listAll.length.toString();
  //       }
  //     }
  //   } finally {
  //     isLoadingAll(false);
  //   }
  // }

  getFilterLists(String date) async {
    try {
      isLoadingFilter(true);
      var apiResponse = await FilterListApi.getFilterList(date);

      if (apiResponse != null) {
        if (apiResponse.response == 'success') {
          listFilter.assignAll(apiResponse.data!);
          notificationNum.value = listFilter.length.toString();
        }
      }
    } finally {
      isLoadingFilter(false);
    }
  }

  getPreApproved() async {
    try {
      isLoadingPreApproved(true);
      var apiResponse = await TodayListApi.getTodayList('pre-approved');

      if (apiResponse != null) {
        if (apiResponse.response == 'success') {
          listPreApproved.assignAll(apiResponse.data!);
        }
      }
    } finally {
      isLoadingPreApproved(false);
    }
  }

  getApproved () async {
    try {
      isLoadingApproved(true);
      var apiResponse = await TodayListApi.getTodayList('approved');

      if (apiResponse != null) {
        if (apiResponse.response == 'success') {
          listApproved.assignAll(apiResponse.data!);
        }
      }
    } finally {
      isLoadingApproved(false);
    }
  }

  getPending () async {
    try {
      isLoadingPending(true);
      var apiResponse = await TodayListApi.getTodayList('new-visitors');

      if (apiResponse != null) {

        if (apiResponse.response == 'success') {
          listPending.assignAll(apiResponse.data!);
          pendingListLength.value = listPending.length;
        }
      }
    } finally {
      isLoadingPending(false);
    }
  }

  getRejectList () async {
    try {
      isLoadingReject(true);
      var apiResponse = await TodayListApi.getTodayList('reject');

      if (apiResponse != null) {
        if (apiResponse.response == 'success') {
          listReject.assignAll(apiResponse.data!);
        }
      }
    } finally {
      isLoadingReject(false);
    }
  }

  getVIPLists() async {
    try {
      isLoadingVIP(true);
      var apiResponse = await TodayListApi.getVIPList('all','VIP');
      if (apiResponse != null) {
        if (apiResponse.response == 'success') {
          listVIP.assignAll(apiResponse.data!);
         // notificationNum.value = appointmentList.length.toString();
        }
      }
    } finally {
      isLoadingVIP(false);
    }
  }

  getHistoryList() async {
    try {
      isLoadingHistory(true);
      var apiResponse = await TodayListApi.getTodayList('history');
      if (apiResponse != null) {
        if (apiResponse.response == 'success') {
          listHistory.assignAll(apiResponse.data!);
        }
      }
    } finally {
      isLoadingHistory(false);
    }
  }

  getUpcomingList() async {

    try {
      isLoadingUpcoming(true);
      var apiResponse = await TodayListApi.getTodayList('Upcoming');

      if (apiResponse != null) {
        if (apiResponse.response == 'success') {
          listUpcoming.assignAll(apiResponse.data!);

        }
      }
    } finally {
      isLoadingUpcoming(false);
    }
  }

}
