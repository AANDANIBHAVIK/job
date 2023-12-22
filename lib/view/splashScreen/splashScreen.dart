// ignore_for_file: prefer_const_constructors, file_names, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:job_letter/view/splashScreen/splashController.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  SplashController controller = Get.put(SplashController());
  @override
  void initState() {
    // TODO: implement initState
    controller.check();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: FlutterLogo(
        size: 140,
        ),
      ),
    );
  }
}
