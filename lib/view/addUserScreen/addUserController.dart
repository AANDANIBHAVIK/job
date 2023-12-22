// ignore_for_file: iterable_contains_unrelated_type, prefer_const_constructors, prefer_is_empty, unrelated_type_equality_checks

import 'package:firedart/firedart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:job_letter/firebase/firebase.dart';
import 'package:job_letter/utils/widgets/customSnackbar.dart';

class AddUserController extends GetxController {
  var formKey = GlobalKey<FormState>();
  RxString type = "".obs;

  TextEditingController addEmail = TextEditingController();
  TextEditingController addPassword = TextEditingController();

  void checkUser(BuildContext context) async {
    if (formKey.currentState!.validate()) {
   if(type != "")
     {
       Firestore firebaseFirestore = Firestore.instance;
       await firebaseFirestore
           .collection("login")
           .where("email", isEqualTo: addEmail.text)
           .get()
           .then((value) {
         if (value.length != 0) {
           SnackBars.errorSnackBar(content: "Email Address Already Exist");
         } else {
           firebase.insertLoginData(
               context, addEmail.text, addPassword.text, type.value);
           addEmail.clear();
           addPassword.clear();
         }
       });
     }else
       {
         SnackBars.errorSnackBar(content: "Login Type Required!");
       }

    } else {
     return;
    }
    update();
  }

}
