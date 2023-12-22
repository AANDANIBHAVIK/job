// ignore_for_file: prefer_const_constructors, invalid_return_type_for_catch_error, camel_case_types

import 'dart:async';

import 'package:http/http.dart' as http;
import 'package:firedart/firestore/firestore.dart';
import 'package:firedart/firestore/models.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:job_letter/main.dart';
import 'package:job_letter/model/newOrderModel.dart';
import 'package:job_letter/utils/widgets/customSnackbar.dart';

class firebase {
  static void insertLoginData(
      BuildContext context, String email, String password, String type) {
    Firestore firebaseFirestore = Firestore.instance;

    firebaseFirestore.collection('login').add(
      {"email": email, "password": password, "type": type},
    ).then((value) {
      Get.back();

      SnackBars.successSnackBar(content: "Success Login");
    }).catchError(
        (error) => SnackBars.errorSnackBar(content: "Something Went Wrong"));
  }
  static void insertDeviceToken(
      String token) {
    Firestore firebaseFirestore = Firestore.instance;

    firebaseFirestore.collection('tokens').add(
      {"token": token},
    ).then((value) {
debugPrint("Success Token : $fcmToken");

    }).catchError(
            (error) => debugPrint("Failed")
    );
  }


  static void insertOrderData(
    BuildContext context,
    String emailID,
    int jobNO,
    String orderDate,
    String deliveryDate,
    String name,
    String paymentStatus,
    String itemTypeValue,
    String image,
    String sidewallColor,
    String acrylicColor,
    String streyDetail,
    String channelOtherDetail,
    String channelInch,
    String ssColor,
    String ssOtherDetail,
    String ssInch,
    String cuttingTypeName,
    String cuttingType,
    var typeNumOne,
    var typeNumTwo,
    String total,
    String orderStatus,
  ) async {
    Firestore firebaseFirestore = Firestore.instance;
    await firebaseFirestore.collection('Order').add(
      {
        "email": emailID,
        "jobNo": jobNO,
        "orderDate": orderDate,
        "deliveryDate": deliveryDate,
        "image": image,
        "partyName": name,
        "paymentStatus": paymentStatus,
        "itemTypeValue": itemTypeValue,
        'channelLatter': {
          "colorSideWall": sidewallColor,
          "coloracreyLic": acrylicColor,
          "streyDetail": streyDetail,
          "channelOtherdetail": channelOtherDetail,
          "channelInch": channelInch,
        },
        'ssLatter': {
          "colorSS": ssColor,
          "ssOtherDetail": ssOtherDetail,
          "ssInch": ssInch,
        },
        'onlyCutting': {
          "cuttingTypeName": cuttingTypeName,
          "cuttingType": cuttingType,
          "typeNumTwo": typeNumTwo,
          "typeNumOne": typeNumOne,
          "total": total,
        },
        'status': {
          "oldStatus": orderStatus,
          "orderStatus": orderStatus,
        },
      },
    ).then((value) {
      SnackBars.successSnackBar(content: "Order Successfully");
    }).catchError(
        (error) => SnackBars.errorSnackBar(content: "Something Went Wrong"));
  }

  // static readOrderdata2() {
  //   Firestore firebaseFirestore = Firestore.instance;
  //   return firebaseFirestore.collection("Order").where("jobNo",isEqualTo: 14).;
  // }

  static Stream<List<Document>> readOrderdata() {
    Firestore firebaseFirestore = Firestore.instance;
    return firebaseFirestore.collection("Order").stream;
  }

  static void updateStatus(BuildContext context, int key, String newStatus,String oldStatus) {
    Firestore.instance
        .collection("Order")
        .where("jobNo", isEqualTo: key)
        .get()
        .then((value) {
      var id = value.first.id;
      Firestore.instance.collection("Order").document(id).update({
        "status": {
          "oldStatus": oldStatus,
          "orderStatus": newStatus,
        },

      }).then((_) {

      });
    });
  }

  static void updateOrderData(
    BuildContext context,
    int key,
    String emailID,
    int jobNO,
    String orderDate,
    String deliveryDate,
    String name,
      String paymentStatus,

    String itemTypeValue,
    String image,
    String sidewallColor,
    String acrylicColor,
    String streyDetail,
    String channelOtherDetail,
    String channelInch,
    String ssColor,
    String ssOtherDetail,
    String ssInch,
    String cuttingTypeName,
    String cuttingType,
      var typeNumOne,
      var typeNumTwo,
    String total,
    String orderStatus,
  ) {
    Firestore firebaseFirestore = Firestore.instance;
    firebaseFirestore
        .collection("Order")
        .where("jobNo", isEqualTo: key)
        .get()
        .then((value) {
      var id = value.first.id;

      Firestore.instance.collection("Order").document(id).update(
        {
          "email": emailID,
          "jobNo": jobNO,
          "orderDate": orderDate,
          "deliveryDate": deliveryDate,
          "image": image,
          "partyName": name,
          "paymentStatus": paymentStatus,
          "itemTypeValue": itemTypeValue,
          'channelLatter': {
            "colorSideWall": sidewallColor,
            "coloracreyLic": acrylicColor,
            "streyDetail": streyDetail,
            "channelOtherdetail": channelOtherDetail,
            "channelInch": channelInch,
          },

          'ssLatter': {
            "colorSS": ssColor,
            "ssOtherDetail": ssOtherDetail,
            "ssInch": ssInch,
          },
          'onlyCutting': {
            "cuttingTypeName": cuttingTypeName,
            "cuttingType": cuttingType,
            "typeNumOne": typeNumOne,
            "typeNumTwo": typeNumTwo,
            "total": total,
          },
          'status': {
            "oldStatus": orderStatus,
            "orderStatus": orderStatus,
          }
        },
      ).then((value) {
        Get.back();

        SnackBars.successSnackBar(content: "Update Successfully");
      }).catchError(
          (error) => SnackBars.errorSnackBar(content: "Something Went Wrong"));
    });
  }

  static void insertChat(int key, List<GroupChat> list) {
    Firestore firebaseFirestore = Firestore.instance;
    firebaseFirestore
        .collection("Order")
        .where("jobNo", isEqualTo: key)
        .get()
        .then(
      (value) async {
        var id = value.first.id;

        NewOrderModel newOrderModel = NewOrderModel(groupChat: list);

        await firebaseFirestore
            .collection('Order')
            .document(id)
            .update(newOrderModel.toJson());
      },
    );
    // SetOptions(merge: true);
  }
  // 1690622722042

 static Future deleteOrderData(int key)async  {
    Firestore firebaseFirestore = Firestore.instance;
    firebaseFirestore
        .collection("Order")
        .where("jobNo", isEqualTo: key)
        .get()
        .then(
      (value) async {
        var id = value.first.id;
        // print("----->> : ${value.first['image']}");
        await firebaseFirestore.collection("Order").document(id).delete();
        var request = http.delete(
            Uri.parse(
                value.first['image']));
        print("---- request   :   $request");

        SnackBars.successSnackBar(content: "Delete Successfully",duration: 650,animationDuration: 350);
      },
    );
  }

}
