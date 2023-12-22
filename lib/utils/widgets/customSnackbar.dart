import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SnackBars {
  ///
  /// Error SnackBar
  ///
  static errorSnackBar(
      {required String content,}) {
    return Get.rawSnackbar(
        message: content,
        backgroundColor: Colors.red.withOpacity(0.8),
        margin: const EdgeInsets.all(15),
        snackPosition:  SnackPosition.TOP,

        maxWidth: Get.width * 0.5,
        borderRadius: 10);
  }

  ///
  /// Success SnackBar
  ///
  static successSnackBar(
      {required String content,int duration= 3000,int animationDuration = 1000}) {
    return Get.rawSnackbar(
        message: content,
        backgroundColor: Colors.green.withOpacity(0.8),
        margin: const EdgeInsets.all(15),
        duration: Duration(milliseconds: duration),
        animationDuration:  Duration(milliseconds: animationDuration),
        maxWidth: Get.width * 0.5,
        snackPosition:  SnackPosition.TOP,
        borderRadius: 10);
  }
}