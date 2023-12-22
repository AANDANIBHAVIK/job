// ignore_for_file: unrelated_type_equality_checks, prefer_const_constructors

import 'package:firedart/firedart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:job_letter/firebase/firebase.dart';
import 'package:job_letter/main.dart';
import 'package:job_letter/routes.dart';
import 'package:job_letter/utils/string.dart';
import 'package:job_letter/utils/widgets/customSnackbar.dart';

class LoginController extends GetxController {
  var formKey = GlobalKey<FormState>();

  TextEditingController txtEmail = TextEditingController();
  TextEditingController txtPassword = TextEditingController();
  RxBool isEmail = false.obs;
  RxBool isPassword = false.obs;
  RxBool isType = false.obs;

  Future checkLogin(BuildContext context) async {
    var id = '';
    try {
      Firestore firebaseFirestore = Firestore.instance;
      await firebaseFirestore
          .collection("login")
          .where("email", isEqualTo: txtEmail.text)
          .get()
          .then((value) async {
        id = value.first.id;

        // print("----${value}");
        // print("--------${value.first.id}");
        print("------id $id");

      });
      var document = await firebaseFirestore.collection('login').document(id);
      await document.get().then((value) {
        isEmail.value = value['email'] == txtEmail.text;
        isPassword.value = value['password'] == txtPassword.text;
        isType.value = value['type'] == "admin";

        if (isEmail == true && isPassword == true) {
          box.write(GetString.email, value['email']);
          box.write(GetString.type, isType.value);

          Get.offAllNamed(AppPages.allorder);
          SnackBars.successSnackBar(content: "Success Login");
          firebase.insertDeviceToken(fcmToken);

          txtEmail.clear();
          txtPassword.clear();
        } else if (isEmail == false && isPassword == false) {
          SnackBars.errorSnackBar(content: "Email Not Found");

        } else if (isPassword == false) {
          SnackBars.errorSnackBar(content: "Password is Incorrect");

        }

        // print("-===  email $isEmail");
        // print("-===    email $isPassword");
        // print("-===  email $isType");
        // print("-===-${value['password']}");
        // print("-=-=---=-=-=-${value['password'] == txtPassword.text}");
      });
    } catch (e) {
      if (txtEmail.text.isEmpty && txtPassword.text.isEmpty) {
        SnackBars.errorSnackBar(content: "Something Went Wrong");

      } else {
        SnackBars.errorSnackBar(content: "User Not Found");

      }
    }
  }
}
