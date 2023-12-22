// ignore_for_file: prefer_const_constructors, file_names

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:job_letter/firebase/firebase.dart';
import 'package:job_letter/main.dart';
import 'package:job_letter/view/loginScreen/loginController.dart';
import 'package:job_letter/utils/color.dart';
import 'package:job_letter/utils/style.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  LoginController controller = Get.put(LoginController());


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: Text("Latter Job"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Form(
          key: controller.formKey,
          child: Column(
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: Text("Email", style: ThemeText.textBoldStyle),
              ),
              SizedBox(
                height: 5.h,
              ),
              TextFormField(
                controller: controller.txtEmail,
                textInputAction: TextInputAction.next,
                cursorColor: ColorTheme.lightblue,
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(6.sp)),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: ColorTheme.lightblue, width: 2.0),
                    ),
                    hintText: 'Enter Email',
                    hintStyle: ThemeText.textHintStyle),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please Enter Email';
                  }
                  return null;
                },
              ),
              SizedBox(
                height: 10.h,
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Text("Password", style: ThemeText.textBoldStyle),
              ),
              SizedBox(
                height: 5.h,
              ),
              TextFormField(
                controller: controller.txtPassword,
                textInputAction: TextInputAction.next,
                obscureText: true,
                cursorColor: ColorTheme.lightblue,
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(6.sp)),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: ColorTheme.lightblue, width: 2.0),
                    ),
                    hintText: 'Enter Password',
                    hintStyle: ThemeText.textHintStyle),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please Enter Password';
                  }
                  return null;
                },
              ),
              SizedBox(
                height: 30.h,
              ),
              MaterialButton(
                onPressed: () async {
                  await controller.checkLogin(context);
                },
                minWidth: 120.w,
                height: 45.h,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14.sp),
                ),
                color: ColorTheme.lightblue,
                child: Text(
                  "Login",
                  style: TextStyle(fontSize: 18.sp, color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
