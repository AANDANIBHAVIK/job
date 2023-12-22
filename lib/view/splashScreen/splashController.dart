// ignore_for_file: prefer_const_constructors, file_names

import 'dart:async';

import 'package:get/get.dart';
import 'package:job_letter/main.dart';
import 'package:job_letter/routes.dart';
import 'package:job_letter/utils/string.dart';

class SplashController extends GetxController {
  void check() {
    Timer(Duration(seconds: 3), () {
      if (box.read(GetString.email) == null) {
        Get.offNamed(AppPages.login);
      } else {
        Get.offNamed(AppPages.allorder);
      }
    });
  }
}
