import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import '../auth_service.dart';
import '../views/no_internet.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../utils/constants/size_orientation.dart';


class SplashView extends StatefulWidget {
  const SplashView({super.key});


  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  final _box = GetStorage();
  final Connectivity _connectivity = Connectivity();

  @override
  Widget build(BuildContext context) {
    print('isLoading: ${_box.read('isLoading')}');
    Timer(const Duration(seconds: 3), () async {
      ConnectivityResult connectivityResult = await _connectivity.checkConnectivity();
     // AuthService().handleAuthState();
      if (connectivityResult == ConnectivityResult.none) {
        // I am not connected to a network.
        Get.offAll(()=> const NoInternet());
      } else {
        // I am connected to a network.
        Get.offAll(AuthService().handleAuthState());
        // if (_box.read('isLoading') == true) {
        //   Get.offAll(()=>const BottomNavPage());
        // } else {
        //   Get.offAll(()=> const LoginPage());
        // }
      }
    });
    ScreenContext.getScreenContext(context);
    if(ScreenContext.width! > 550) {
      ///tablets...............
      return Scaffold(
          body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: SizedBox(
                  height: 280,
                  width: 200,
                  child: Image.asset('assets/images/logo.gif'),
                ),
              ),const SizedBox(height: 50,),
              const Padding(
                padding:  EdgeInsets.symmetric(horizontal: 60.0),
                child: Text('Office of the District Magistrate\nPaschim Bardhaman',
                  style: TextStyle(fontSize: 26,fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
              )
            ],
          )
      );
    }
    ///Phones...............
    return Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
          //  const SizedBox(width: double.infinity,height: 150,),
            Center(
              child: SizedBox(
                height: 250,
                width: 170,
                child: Image.asset('assets/images/logo.gif'),
              ),
            ),const SizedBox(height: 70,),
            const Padding(
              padding:  EdgeInsets.symmetric(horizontal: 50.0),
              child: Text('Office of the District Magistrate Paschim Bardhaman',
                style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
            )
          ],
        )
    );
  }
}
