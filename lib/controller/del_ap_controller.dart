import 'dart:math';

import '../apis/del_api.dart';
import 'package:get/get.dart';
import '../styles/common_module/my_alert_dilog.dart';
import '../styles/common_module/my_snack_bar.dart';
import '../views/bottom_nav_bar.dart';


class DeleteController extends GetxController{

  var isUpdated = false.obs;

  deleteRequest(String uniqueID) async {
    MyAlertDialog.circularProgressDialog();
    // final box = GetStorage();
    isUpdated(true);
    Random random = new Random();
    int randomNumber = random.nextInt(1000000);


    var apiResponse = await DeleteApi.delAppointment('$randomNumber$uniqueID');
    print('$randomNumber$uniqueID');
    if(apiResponse!=null){
      if(apiResponse.response=='true'){
        Get.offAll(() => const BottomNavPage());
        MySnackbar.successSnackBar('Deleted', 'Appointment Deleted successfully');
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
}