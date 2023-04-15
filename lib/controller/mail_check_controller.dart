import '../apis/mail_check_api.dart';
import '../views/bottom_nav_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../auth_service.dart';
import '../styles/common_module/my_alert_dilog.dart';
import '../styles/common_module/my_snack_bar.dart';


class MailCheckController extends GetxController{

   var isLoading = false.obs;

  mailCheck (deviceId) async {
    MyAlertDialog.circularProgressDialog();

    final box = GetStorage();
    isLoading(true);
    String mailDM = FirebaseAuth.instance.currentUser!.email!;
    var apiResponse = await MailCheckApi.mailCheck(mailDM, deviceId);

    //print()
    if(apiResponse!=null){

      if(apiResponse.response=='success'){
        String role = apiResponse.data!.role.toString();
        box.write('id', apiResponse.data!.id.toString());
        box.write('name', apiResponse.data!.name.toString());
        box.write('email', apiResponse.data!.email.toString());
        box.write('avatar', apiResponse.data!.avatar.toString());
        box.write('role', apiResponse.data!.role.toString());
        box.write('isLoading', true);
        box.write('deviceID', deviceId);
        Get.offAll(() => const BottomNavPage());
        MySnackbar.successSnackBar('Login Success', 'You logged in as $role ');
      }


      else if(apiResponse.response=='false'){
        await AuthService().signOut();
        Get.back();
        MySnackbar.infoSnackBar('Email is not Registered', 'Please enter a registered email !!');
      }
      else {
        await AuthService().signOut();
        Get.back();
        MySnackbar.errorSnackBar('Server Down', 'Please try again later');
      }
    }else{
      await AuthService().signOut();
      Get.back();
      MySnackbar.errorSnackBar('Server Down', 'Please try again later');
     // Get.offAll(const LoginPage());
    }
  }
}