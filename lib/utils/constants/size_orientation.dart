import 'package:flutter/material.dart';

class ScreenContext{
  static Size? size;
  static double? width;
   static getScreenContext(BuildContext context){
    size = MediaQuery.of(context).size;
    width = size!.width > size!.height ? size!.height : size!.width;
  }
}