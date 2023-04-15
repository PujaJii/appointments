import '../apis/edit_appointment.dart';
import '../views/bottom_nav_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../styles/common_module/my_alert_dilog.dart';
import '../styles/common_module/my_snack_bar.dart';



class EditAppointmentController extends GetxController{

  // var isLoaded = false.obs;
  final box = GetStorage();

  String typeVal = '1';
  String statusVal = '0';
  String serviceVal = '';
  TextEditingController nameTEC = TextEditingController();
  TextEditingController dateTEC = TextEditingController();
  TextEditingController timeTEC = TextEditingController();
  TextEditingController typeTEC = TextEditingController();
  TextEditingController subjectTEC = TextEditingController();
  TextEditingController videoLink = TextEditingController();
  TextEditingController minutes = TextEditingController();



  editAppointment (String appointment_id,String type,String status,String serviceType, {dynamic imgPath}) async {
    MyAlertDialog.circularProgressDialog();
    //final box = GetStorage();
    // isLoaded(true);
    if(type == 'Visitors'){
      typeVal = '0';
    }else if(type == 'VIP'){
      typeVal = '2';
    }

    if(status == 'Approved'){
      statusVal = '1';
    }

    if(nameTEC.text == ''){
      nameTEC.text = '0';
    }

    var apiResponse = await EditAppointmentApi.editAppointment(

      nameTEC.text,///
      dateTEC.text,
      timeTEC.text,
      typeVal,
      subjectTEC.text,
      box.read('id').toString(),  //userid
      statusVal,
      serviceType.toString(),///
      videoLink.text,///
      appointment_id, ///*****************
      minutes.text,
      document: imgPath,///
    );

    if(apiResponse!=null){

      if(apiResponse.response=='true'){



        Get.back();
        MySnackbar.successSnackBar(
          'Submitted', 'Appointment has been Edited',
        );
        Get.offAll(()=>const BottomNavPage());
      }
      else{
        Get.back();
        MySnackbar.errorSnackBar('Server Down', 'Please try again later');
        print('Response ------ ${apiResponse.response}');
      }

    }else{
      Get.back();
      MySnackbar.errorSnackBar('Server Down ', 'Please try again later');
    }
  }
}