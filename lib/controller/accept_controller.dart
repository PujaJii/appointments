import '../apis/accept_api.dart';
import '../views/full_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';
import '../styles/common_module/my_alert_dilog.dart';
import '../styles/common_module/my_snack_bar.dart';
import '../views/bottom_nav_bar.dart';


class AcceptController extends GetxController{

  var isUpdated = false.obs;
  final _box = GetStorage();

  acceptRequest1(String userId) async {
    MyAlertDialog.circularProgressDialog();
   // final box = GetStorage();
    isUpdated(true);
    var apiResponse = await AcceptApi.acceptAppointment('accept_request',userId);
    if(apiResponse!=null){
      if(apiResponse.response=='success'){
        Get.offAll(() => const BottomNavPage());
        //Get.back();
        MySnackbar.successSnackBar('Accepted', 'Appointment approved');
        Get.back();
      } else if(apiResponse.response=='false'){
        Get.back();
        MySnackbar.infoSnackBar('Wrong Input', 'Appointment ID Missing');

      } else {
        Get.back();
        MySnackbar.errorSnackBar('Server Down', 'Please try again later');

      }
    } else{
      Get.back();
      MySnackbar.errorSnackBar('Server Down', 'Please try again later');
    }
  }

  acceptRequestFullView(String userId) async {
    //MyAlertDialog.circularProgressDialog();
    // final box = GetStorage();
    isUpdated(true);
    var apiResponse = await AcceptApi.acceptAppointment('accept_request',userId);
    if(apiResponse!=null){
      if(apiResponse.response=='success'){
        Get.off(() => const FullView());
        //Get.back();
        MySnackbar.successSnackBar('Accepted', 'Appointment approved');
        Get.back();
      } else if(apiResponse.response=='false'){
        Get.back();
        MySnackbar.infoSnackBar('Wrong Input', 'Appointment ID Missing');

      } else {
        Get.back();
        MySnackbar.errorSnackBar('Server Down', 'Please try again later');

      }
    } else{
      Get.back();
      MySnackbar.errorSnackBar('Server Down', 'Please try again later');
    }
  }

  rejectRequest(String userId) async {
    MyAlertDialog.circularProgressDialog();
    // final box = GetStorage();
    isUpdated(true);
    var apiResponse = await AcceptApi.acceptAppointment('reject_request',userId);

    if(apiResponse!=null){

      if(apiResponse.response=='success'){
        Get.back();
        MySnackbar.successSnackBar('Rejected', 'Appointment Rejected');

      } else if(apiResponse.response=='false'){
        Get.back();
        MySnackbar.infoSnackBar('Wrong Input', 'Appointment ID Missing');

      } else {
        Get.back();
        MySnackbar.errorSnackBar('Server Down', 'Please try again later');

      }
    } else{
      Get.back();
      MySnackbar.errorSnackBar('Server Down', 'Please try again later');
    }
  }

  arrivedRequest(String userId) async {
    MyAlertDialog.circularProgressDialog();
    // final box = GetStorage();
    isUpdated(true);
    var apiResponse = await AcceptApi.acceptAppointment('arrived',userId);

    if(apiResponse!=null){

      if(apiResponse.response=='success'){
        Get.back();
        MySnackbar.successSnackBar('Arrived', 'Visitor Arrived');

      } else if(apiResponse.response=='false'){
        Get.back();
        MySnackbar.infoSnackBar('Wrong Input', 'Appointment ID Missing');

      } else {
        Get.back();
        MySnackbar.errorSnackBar('Server Down', 'Please try again later');

      }
    } else{
      Get.back();
      MySnackbar.errorSnackBar('Server Down', 'Please try again later');
    }
  }

  sendInRequest(String userId) async {
    MyAlertDialog.circularProgressDialog();
    // final box = GetStorage();
    isUpdated(true);
    var apiResponse = await AcceptApi.acceptAppointment('SendIn',userId);

    if(apiResponse!=null){

      if(apiResponse.response=='success'){
        Get.back();
        final TimeOfDay now = TimeOfDay.now();
        //final DateFormat formatter = DateFormat('yyyy-MM-dd');
        var pickedTime = '${now.hour}:${now.minute}';
        var sendTime = '${DateFormat("h:mm a").format(DateFormat("hh:mm").parse(pickedTime))}';

        _box.write('sendTime', sendTime);
        print(sendTime);

        MySnackbar.successSnackBar('Send In', 'Sending in the visitor');

      } else if(apiResponse.response=='false'){
        Get.back();
        MySnackbar.infoSnackBar('Wrong Input', 'Appointment ID Missing');

      } else {
        Get.back();
        MySnackbar.errorSnackBar('Server Down', 'Please try again later');

      }
    } else{
      Get.back();
      MySnackbar.errorSnackBar('Server Down', 'Please try again later');
    }
  }

  completeRequest(String userId) async {
    MyAlertDialog.circularProgressDialog();
    // final box = GetStorage();
    isUpdated(true);
    var apiResponse = await AcceptApi.acceptAppointment('Complete',userId);

    if(apiResponse!=null){

      if(apiResponse.response=='success'){
        Get.back();
        final TimeOfDay now = TimeOfDay.now();
        //final DateFormat formatter = DateFormat('yyyy-MM-dd');
        var pickedTime = '${now.hour}:${now.minute}';
        var completeTime = '${DateFormat("h:mm a").format(DateFormat("hh:mm").parse(pickedTime))}';
        _box.write('completeTime', completeTime);
        print(completeTime);

        MySnackbar.successSnackBar('Meeting Complete', 'Appointment has been completed');


      } else if(apiResponse.response=='false'){
        Get.back();
        MySnackbar.infoSnackBar('Wrong Input', 'Appointment ID Missing');

      } else {
        Get.back();
        MySnackbar.errorSnackBar('Server Down', 'Please try again later');

      }
    } else{
      Get.back();
      MySnackbar.errorSnackBar('Server Down', 'Please try again later');
    }
  }
}