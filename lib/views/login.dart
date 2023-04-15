import '../auth_service.dart';
import '../controller/mail_check_controller.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../styles/app_colors.dart';



class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}
bool isSelected1 = false;
bool isSelected2 = true;

class _LoginPageState extends State<LoginPage> {

  MailCheckController mailCheckController = Get.put(MailCheckController());
  late FirebaseMessaging messaging = FirebaseMessaging.instance;
  var deviceId;

  @override
  void initState() {
    // TODO: implement initState
    messaging = FirebaseMessaging.instance;
    messaging.getToken().then((value) {
      deviceId = value;
      print('Device Id in login: $value');
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    Size size = MediaQuery.of(context).size;
    double width = size.width > size.height ? size.height : size.width;
    Orientation orientation = MediaQuery.of(context).orientation;
    if(width >= 550) {
      ///  Do something for tablets here
      if(orientation.toString() == 'Orientation.landscape'){
        SafeArea(
          child: Scaffold(
            body: ListView(
              // mainAxisAlignment: MainAxisAlignment.center,
              // crossAxisAlignment: CrossAxisAlignment.center,
              //shrinkWrap: true,
              children: [
                // width == 552.8638200609188?
                // const SizedBox(height: 12,width: double.infinity,):
                //const SizedBox(height: 20,width: double.infinity,),
                Center(
                  child: SizedBox(
                    width: 170,
                    height: 240,
                    child: Image.asset('assets/images/logo.gif',fit: BoxFit.contain),
                  ),
                ),
                const Padding(
                  padding:  EdgeInsets.symmetric(vertical: 20.0,horizontal: 50),
                  child: Text('Office of the District Magistrate\nPaschim Bardhaman',
                    style: TextStyle(fontSize: 24,fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                ),
                //  width == 552.8638200609188?
                //  const SizedBox(height: 7,):
                const SizedBox(height: 20,),
                const Padding(
                  padding:  EdgeInsets.symmetric(horizontal: 50),
                  child: Text('Sign in with your Google Account to get your history,'
                      ' passwords and other settings on all your devices with more security.',
                    style: TextStyle(fontSize: 15),
                    textAlign: TextAlign.center,
                  ),
                ),
                //  width == 552.8638200609188?
                //  const SizedBox(height: 15,):
                const SizedBox(height: 20,),
                // // const SizedBox(height: 30,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    InkWell(
                      onTap: () {
                        setState(() {
                          isSelected1 = false;
                          isSelected2 = true;
                        });
                      },
                      child: Material(
                        elevation: 7,
                        borderRadius: BorderRadius.circular(10),
                        child: Container(
                          height: 50,
                          width: 175,
                          //  margin: const EdgeInsets.only(right: 5),
                          decoration: BoxDecoration(
                              color: isSelected1 ? AppColors.themeColorLight :
                              AppColors.themeColor,
                              borderRadius: BorderRadius.circular(10)),
                          child:  Center(
                              child: Text('I am DM',
                                style: TextStyle(
                                    color: isSelected1 ? Colors.black87 : Colors.white,
                                    fontWeight: FontWeight.bold,fontSize: 16),)
                          ),
                        ),
                      ),
                    ),const SizedBox(width: 10,),
                    InkWell(
                      onTap: () {
                        setState(() {
                          isSelected1 = true;
                          isSelected2 = false;
                        });
                      },
                      child: Material(
                        elevation: 7,
                        borderRadius: BorderRadius.circular(10),
                        child: Container(
                          height: 50,
                          width: 175,
                          // margin: const EdgeInsets.only(left: 5),
                          decoration: BoxDecoration(
                              color: isSelected2 ? const Color(0xFFD4EFFA):
                              const Color(0xFF007AFF),
                              borderRadius: BorderRadius.circular(10)),
                          child:  Center(
                              child: Text('I am PA',style: TextStyle(
                                  color: isSelected2 ? Colors.black87 : Colors.white,
                                  fontWeight: FontWeight.bold,fontSize: 16),)
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                // const SizedBox(height: 10,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 15.0),
                      child: InkWell(
                        onTap: () async {
                          await AuthService().signInWithGoogle();
                          mailCheckController.mailCheck(deviceId);
                        },
                        child: Material(
                          elevation: 7,
                          borderRadius: BorderRadius.circular(10),
                          child: Container(
                            height: 50,
                            width: 360,
                            decoration: BoxDecoration(
                                color: const Color(0xFFD4EFFA),
                                borderRadius: BorderRadius.circular(10)),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(
                                  height: 40,
                                  width: 40,
                                  child: Image.asset('assets/images/google_logo.png'),
                                ),const SizedBox(width: 10,),
                                const Center(child:  Text('  Login with Google',
                                  style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16),)),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                //  const SizedBox(height: 25,),
              ],
            ),
          ),
        );
      }
      return
        SafeArea(
          child: Scaffold(
            body: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              //shrinkWrap: true,
              children: [
                // width == 552.8638200609188?
                // const SizedBox(height: 12,width: double.infinity,):
                 //const SizedBox(height: 20,width: double.infinity,),
                Center(
                  child: SizedBox(
                    width: 170,
                    height: 240,
                    child: Image.asset('assets/images/logo.gif',fit: BoxFit.contain),
                  ),
                ),
                const Padding(
                  padding:  EdgeInsets.symmetric(vertical: 20.0,horizontal: 50),
                  child: Text('Office of the District Magistrate \n Paschim Bardhaman',
                    style: TextStyle(fontSize: 24,fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                ),
               //  width == 552.8638200609188?
               //  const SizedBox(height: 7,):
                const SizedBox(height: 20,),
                const Padding(
                  padding:  EdgeInsets.symmetric(horizontal: 50),
                  child: Text('Sign in with your Google Account to get your history,'
                      ' passwords and other settings on all your devices with more security.',
                    style: TextStyle(fontSize: 15),
                    textAlign: TextAlign.center,
                  ),
                ),
               //  width == 552.8638200609188?
               //  const SizedBox(height: 15,):
                const SizedBox(height: 20,),
               // // const SizedBox(height: 30,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    InkWell(
                      onTap: () {
                        setState(() {
                          isSelected1 = false;
                          isSelected2 = true;
                        });
                      },
                      child: Material(
                        elevation: 7,
                        borderRadius: BorderRadius.circular(10),
                        child: Container(
                          height: 50,
                          width: 175,
                          //  margin: const EdgeInsets.only(right: 5),
                          decoration: BoxDecoration(
                              color: isSelected1 ? AppColors.themeColorLight :
                              AppColors.themeColor,
                              borderRadius: BorderRadius.circular(10)),
                          child:  Center(
                              child: Text('I am DM',
                                style: TextStyle(
                                    color: isSelected1 ? Colors.black87 : Colors.white,
                                    fontWeight: FontWeight.bold,fontSize: 16),)
                          ),
                        ),
                      ),
                    ),const SizedBox(width: 10,),
                    InkWell(
                      onTap: () {
                        setState(() {
                          isSelected1 = true;
                          isSelected2 = false;
                        });
                      },
                      child: Material(
                        elevation: 7,
                        borderRadius: BorderRadius.circular(10),
                        child: Container(
                          height: 50,
                          width: 175,
                          // margin: const EdgeInsets.only(left: 5),
                          decoration: BoxDecoration(
                              color: isSelected2 ? const Color(0xFFD4EFFA):
                              const Color(0xFF007AFF),
                              borderRadius: BorderRadius.circular(10)),
                          child:  Center(
                              child: Text('I am PA',style: TextStyle(
                                  color: isSelected2 ? Colors.black87 : Colors.white,
                                  fontWeight: FontWeight.bold,fontSize: 16),)
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
               // const SizedBox(height: 10,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 15.0),
                      child: InkWell(
                        onTap: () async {
                          await AuthService().signInWithGoogle();
                          mailCheckController.mailCheck(deviceId);
                        },
                        child: Material(
                          elevation: 7,
                          borderRadius: BorderRadius.circular(10),
                          child: Container(
                            height: 50,
                            width: 360,
                            decoration: BoxDecoration(
                                color: const Color(0xFFD4EFFA),
                                borderRadius: BorderRadius.circular(10)),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(
                                  height: 35,
                                  width: 35,
                                  child: Image.asset('assets/images/google_logo.png'),
                                ),const SizedBox(width: 10,),
                                const Center(child:  Text('  Login with Google',
                                  style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16),)),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                  //  const SizedBox(height: 25,),
              ],
            ),
          ),
        );
    }
    ///  Do something for phone here
    return
      SafeArea(
        child: Scaffold(
          body: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
               const SizedBox(height: 40,width: double.infinity),
                Center(
                  child: SizedBox(
                    width: 150,
                    height: 200,
                    child: Image.asset('assets/images/logo.gif'),
                  ),
                ),const SizedBox(height: 15),
                const Padding(
                  padding:  EdgeInsets.symmetric(vertical: 15.0,horizontal: 50),
                  child: Text('Office of the District Magistrate Paschim Bardhaman',
                    style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                ),const SizedBox(height: 15),
                const Padding(
                  padding:  EdgeInsets.symmetric(vertical: 20.0,horizontal: 30),
                  child: Text('Sign in with your Google Account to get your history,'
                      ' passwords and other settings on all your devices with more security',
                    style: TextStyle(fontSize: 14),
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(height: 40,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    InkWell(
                      onTap: () {
                        setState(() {
                          isSelected1 = false;
                          isSelected2 = true;
                        });
                      },
                      child: Material(
                        elevation: 7,
                        borderRadius: BorderRadius.circular(10),
                        child: Container(
                          height: 45,
                          width: 130,
                          // margin: const EdgeInsets.only(right: 5),
                          decoration: BoxDecoration(
                              color: isSelected1 ? const Color(0xFFD4EFFA) :
                              const Color(0xFF007AFF),
                              borderRadius: BorderRadius.circular(10)),
                          child: Center(
                              child: Text('I am  DM',
                                style: TextStyle(
                                    color :isSelected1 ? Colors.black87 : Colors.white,
                                    fontWeight: FontWeight.bold,fontSize: 16),)),
                        ),
                      ),
                    ),const SizedBox(width: 10,),
                    InkWell(
                      onTap: () {
                        setState(() {
                          isSelected1 = true;
                          isSelected2 = false;
                        });
                      },
                      child: Material(
                        elevation: 7,
                        borderRadius: BorderRadius.circular(10),
                        child: Container(
                          height: 45,
                          width: 130,
                          // margin: const EdgeInsets.only(left: 5),
                          decoration: BoxDecoration(
                              color: isSelected2 ? const Color(0xFFD4EFFA) :
                              const Color(0xFF007AFF),
                              borderRadius: BorderRadius.circular(10)),
                          child: Center(
                              child: Text('I am  PA',style: TextStyle(
                                  color: isSelected2 ? Colors.black87 : Colors.white,
                                  fontWeight: FontWeight.bold,fontSize: 16),)
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10,),
                InkWell(
                  onTap: () async {
                    await AuthService().signInWithGoogle();
                    mailCheckController.mailCheck(deviceId);
                  },
                  child: Material(
                    elevation: 7,
                    borderRadius: BorderRadius.circular(10),
                    child: Container(
                      height: 45,
                      width: 270,
                      decoration: BoxDecoration(
                          color: const Color(0xFFD4EFFA),
                          borderRadius: BorderRadius.circular(10)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: 25,
                            width: 25,
                            child: Image.asset('assets/images/google_logo.png'),
                          ),const SizedBox(width: 10,),
                          const Center(child:  Text('  Login with Gogle',
                            style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16),)),
                        ],
                      ),
                    ),
                  ),
                ),const SizedBox(height: 15,)
              ],
            ),
          ),
        ),
      );
  }
}
