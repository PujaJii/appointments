import '../views/bottom_nav_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../apis/create_appointment_api.dart';
import '../styles/common_module/my_alert_dilog.dart';
import '../styles/common_module/my_snack_bar.dart';



class CreateAppointmentController extends GetxController{

  // var isLoaded = false.obs;
  final box = GetStorage();

  String typeVal = '1';
  String  statusVal = '0';
  String serviceVal = '';
  TextEditingController nameTEC = TextEditingController();
  TextEditingController dateTEC = TextEditingController();
  TextEditingController timeTEC = TextEditingController();
  TextEditingController typeTEC = TextEditingController();
  TextEditingController subjectTEC = TextEditingController();
  TextEditingController videoLink = TextEditingController();
  TextEditingController minutes = TextEditingController();


  createAppointment (String type,String status,String serviceType, {dynamic imgPath}) async {
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

    var apiResponse = await CreateAppointmentApi.createAppointment(

        nameTEC.text,///
        dateTEC.text,
        timeTEC.text,
        typeVal,
        subjectTEC.text,
        box.read('id').toString(),  //userid
        statusVal,
        serviceType.toString(),///
        videoLink.text,///
        minutes.text,
        document: imgPath,///
    );
// print('..................${nameTEC.text}');
// print('..................${videoLink.text}');
// print('..................${imgPath}');
    if(apiResponse!=null){

      if(apiResponse.response=='true'){

        // String id = apiResponse.res!.id.toString();
        // String email = apiResponse.userData!.email.toString();
        //
        // box.write('id', id);
        // box.write('email', email);
        // box.write('isLoaded', 'true');

        Get.back();
        MySnackbar.successSnackBar(
          'Submitted', 'Appointment has been added',
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