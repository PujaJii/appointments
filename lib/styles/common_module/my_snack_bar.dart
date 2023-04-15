import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MySnackbar {
  static void errorSnackBar(String title, String message) {
    Get.snackbar(title, message,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
        margin: const EdgeInsets.all(6.0)
    );
  }

  static void successSnackBar(String title, String message) {
    Get.snackbar(title, message,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green,
        colorText: Colors.white,
        margin: const EdgeInsets.all(6.0)
    );
  }

  static void infoSnackBar(String title, String message) {
    Get.snackbar(title, message,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.blue,
        colorText: Colors.white,
        margin: const EdgeInsets.all(6.0)
    );
  }
  static void transparentSnakbar(String title, String message) {
    Get.snackbar(title, message,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.white38,
        colorText: Colors.black,
        margin: const EdgeInsets.all(6.0),
        duration: const Duration(seconds: 1)
    );
  }

  static void whiteSnackbar(String title, String message) {
    Get.snackbar(title, message,
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.white,
        colorText: Colors.black,
        margin: const EdgeInsets.all(6.0),
        duration: const Duration(seconds: 3)
    );
  }
}
