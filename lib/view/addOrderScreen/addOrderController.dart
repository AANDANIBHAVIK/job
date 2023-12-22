// ignore_for_file: prefer_const_constructors, prefer_typing_uninitialized_variables, invalid_use_of_protected_member, unnecessary_null_comparison, unrelated_type_equality_checks

import 'package:firedart/firedart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:job_letter/main.dart';
import 'package:job_letter/model/newOrderModel.dart';
import 'package:job_letter/utils/string.dart';

class AddOrderController extends GetxController {
  TextEditingController txtname = TextEditingController();
  TextEditingController txtchennelotherDetail = TextEditingController();
  TextEditingController txtssotherDetail = TextEditingController();
  TextEditingController txtno1 = TextEditingController();
  TextEditingController txtno2 = TextEditingController();
  TextEditingController txtanswer = TextEditingController();
  TextEditingController txtsscolor = TextEditingController();
  TextEditingController txtcuttingtype = TextEditingController();
  TextEditingController txtsidewallColor = TextEditingController();
  TextEditingController txtacrylicColor = TextEditingController();
  TextEditingController txtstrey = TextEditingController();
  TextEditingController txtchennelinch = TextEditingController();
  TextEditingController txtssinch = TextEditingController();
  TextEditingController txtsendmsg = TextEditingController();

  RxList<String> sidewallcolor = <String>[].obs;
  RxList<String> acreyliccolor = <String>[].obs;
  RxList<String> streydetaillist = <String>[].obs;
  RxList<String> channelinchlist = <String>[].obs;
  RxList<String> sscolorlist = <String>[].obs;
  RxList<String> cuttingtypelist = <String>[].obs;
  RxList<String> ssinchlist = <String>[].obs;
  RxInt maxCount = 1.obs;

  var formKey = GlobalKey<FormState>();
  RxDouble cuttingStatus = 1.0.obs;
  RxString orderStatus = "Cotation".obs;
  RxString paymentStatus = "Pending".obs;
  RxString orderItemStatus = "Channel Latter".obs;
  RxString orderdate = "".obs;
  RxString deliverydate = "".obs;
  RxBool isLoading = false.obs;
  DateTime today = DateTime.now();
  final DateFormat formatter = DateFormat('yyyy-MM-dd');

  RxString imageUrl = "".obs;
  RxString result = '0'.obs;
  var sum1 = 0.0;
  var sum2 = 0.0;
  RxInt job = 1.obs;
  RxInt curJob = 1.obs;
  RxString uniqueid = "".obs;
  RxString imageName = "".obs;
  RxString imageToken = "".obs;
  RxList<GroupChat> groupList = <GroupChat>[].obs;

  resultChange() {
    var sumresult = sum2 / cuttingStatus.value * sum1 / cuttingStatus.value;
    result.value = sumresult.toStringAsFixed(3);
  }

  String curDate() {
    String curDate =
        "${today.day.toString().padLeft(2, '0')}-${today.month.toString().padLeft(2, '0')}-${today.year.toString()}";
    return curDate;
  }

  getImage(String name, String token) {
    return "https://firebasestorage.googleapis.com/v0/b/joblatter-36cbb.appspot.com/o/images%2F$name?alt=media&token=$token";
  }

  Future getOrderdata(int id) async {
    Firestore firebaseFirestore = Firestore.instance;
    await firebaseFirestore
        .collection("Order")
        .where("jobNo", isEqualTo: id)
        .get()
        .then((alldata) {
      NewOrderModel orderData;

      orderData = NewOrderModel.fromJson(alldata.first.map);

      job.value = orderData.jobNo ?? 0;
      orderdate.value = orderData.orderDate ?? '';
      deliverydate.value = orderData.deliveryDate ?? '';
      txtname.text = orderData.partyName ?? '';
      paymentStatus.value = orderData.paymentStatus ?? 'Pending';
      orderItemStatus.value = orderData.itemTypeValue ?? 'Channel Latter';
      imageUrl.value = orderData.image ?? '';
      txtsidewallColor.text = orderData.channelLatter?.colorSideWall ?? '';
      txtacrylicColor.text = orderData.channelLatter?.coloracreyLic ?? '';
      txtstrey.text = orderData.channelLatter?.streyDetail ?? '';
      txtchennelotherDetail.text =
          orderData.channelLatter?.channelOtherdetail ?? '';
      txtchennelinch.text = orderData.channelLatter?.channelInch ?? '';
      txtsscolor.text = orderData.ssLatter?.colorSS ?? '';
      txtssotherDetail.text = orderData.ssLatter?.ssOtherDetail ?? '';
      txtssinch.text = orderData.ssLatter?.ssInch ?? '';
      txtcuttingtype.text = orderData.onlyCutting?.cuttingTypeName ?? '';
      txtno1.text = orderData.onlyCutting?.typeNumOne ?? '';
      txtno1.text = orderData.onlyCutting?.typeNumTwo ?? '';
      result.value = orderData.onlyCutting?.total ?? '';
      orderStatus.value = orderData.status?.orderStatus ?? '';
      groupList.value = orderData.groupChat ?? [];
      uniqueid.value = alldata.first.id;
    });
  }

  clearValue() {
    job.value = 0;
    orderdate.value = "";
    deliverydate.value = "";
    txtname.clear();
    orderItemStatus.value = 'Channel Latter';
    imageUrl.value = '';
    txtsidewallColor.clear();
    txtacrylicColor.clear();
    txtstrey.clear();
    txtchennelotherDetail.clear();
    txtchennelinch.clear();
    txtsscolor.clear();
    txtssotherDetail.clear();
    txtssinch.clear();
    txtcuttingtype.clear();
    txtno1.clear();
    txtno2.clear();
    result.value = "";
    orderStatus.value = "Cotation";
    // uniqueid.value = "";
  }

  RxMap<double, String> dropdownCuttingItem = {
    1.0: "Feet",
    0.3048: "Meter",
    12.0: "Inch",
    30.48: "CM",
    304.8: "MM",
  }.obs;
  RxMap<String, String> dropdownOrderItem = {
    "Cotation": "Cotation",
    "Order Confirm": "Order Confirm",
    "Cutting": "Cutting",
    "Banding": "Banding",
    "Color": "Color",
    "Packing": "Packing",
    "Delivery": "Delivery",
    "Billing": "Billing",
  }.obs;

  RxMap<String, String> orderItem = {
    "Channel Latter": "Channel Latter",
    "SS Latter": "SS Latter",
    "Only Cutting": "Only Cutting",
  }.obs;
  RxMap<String, String> dropdownPaymentItem = {
    "Pending": "Pending",
    "Process": "Process",
    "Done": "Done",
  }.obs;

  Future getCurjobId() async {
    Firestore firebaseFirestore = Firestore.instance;
    await firebaseFirestore
        .collection("Order")
        .orderBy("jobNo", descending: true)
        .limit(1)
        .get()
        .then((value) {
      curJob.value = value.first["jobNo"] + 1;
      job.value = curJob.value;
    }).catchError((err) {
      job.value = curJob.value;
    });
  }

  cuttingType(double val) {
    switch (val) {
      case 1.0:
        return "Feet";
      case 0.3048:
        return "Meter";
      case 12.0:
        return "Inch";
      case 30.48:
        return "CM";
      case 304.8:
        return "MM";
    }
    update();
  }

  addColorList() {
    print("--->> color : $sidewallcolor");
    if (sidewallcolor.contains(txtsidewallColor.text) == false) {
      sidewallcolor.value.add(txtsidewallColor.text);
      box.write(GetString.wallcolor, sidewallcolor.value);
    }
    if (acreyliccolor.contains(txtacrylicColor.text) == false) {
      acreyliccolor.value.add(txtacrylicColor.text);

      box.write(GetString.acrylic, acreyliccolor.value);
    }

    if (streydetaillist.contains(txtstrey.text) == false) {
      streydetaillist.value.add(txtstrey.text);

      box.write(GetString.streydetail, streydetaillist.value);
    }

    if (channelinchlist.contains(txtchennelinch.text) == false) {
      channelinchlist.value.add(txtchennelinch.text);

      box.write(GetString.chennelinch, channelinchlist.value);
    }

    if (sscolorlist.contains(txtsscolor.text) == false) {
      sscolorlist.value.add(txtsscolor.text);

      box.write(GetString.sscolor, sscolorlist.value);
    }
    if (ssinchlist.contains(txtssinch.text) == false) {
      ssinchlist.value.add(txtssinch.text);

      box.write(GetString.ssinch, ssinchlist.value);
    }

    if (cuttingtypelist.contains(txtcuttingtype.text) == false) {
      cuttingtypelist.value.add(txtcuttingtype.text);

      box.write(GetString.cuttingtype, cuttingtypelist.value);
    }
  }

  showlist() {
    List<dynamic> listsidecolor = box.read(GetString.wallcolor) ?? [];
    List<dynamic> listacryliccolor = box.read(GetString.acrylic) ?? [];
    List<dynamic> liststreydetail = box.read(GetString.streydetail) ?? [];
    List<dynamic> listchennelinch = box.read(GetString.chennelinch) ?? [];
    List<dynamic> listsscolor = box.read(GetString.sscolor) ?? [];
    List<dynamic> listssinch = box.read(GetString.ssinch) ?? [];
    List<dynamic> listcuttingtype = box.read(GetString.cuttingtype) ?? [];

    sidewallcolor.clear();
    acreyliccolor.clear();
    streydetaillist.clear();
    channelinchlist.clear();
    sscolorlist.clear();
    cuttingtypelist.clear();
    ssinchlist.clear();

    for (var i in listsidecolor) {
      sidewallcolor.add(i.toString());
    }
    for (var i in listacryliccolor) {
      acreyliccolor.add(i.toString());
    }
    for (var i in liststreydetail) {
      streydetaillist.add(i.toString());
    }
    for (var i in listchennelinch) {
      channelinchlist.add(i.toString());
    }
    for (var i in listsscolor) {
      sscolorlist.add(i.toString());
    }
    for (var i in listssinch) {
      ssinchlist.add(i.toString());
    }
    for (var i in listcuttingtype) {
      cuttingtypelist.add(i.toString());
    }
  }
}
