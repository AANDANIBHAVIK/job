// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, unrelated_type_equality_checks, use_build_context_synchronously, unnecessary_null_comparison, prefer_interpolation_to_compose_strings, file_names, unnecessary_string_interpolations, empty_catches

import 'dart:convert';
import 'dart:io';
import 'package:firedart/firedart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:job_letter/firebase/firebase.dart';
import 'package:job_letter/main.dart';
import 'package:job_letter/model/imageModel.dart';
import 'package:job_letter/model/newOrderModel.dart';
import 'package:job_letter/utils/string.dart';
import 'package:job_letter/utils/widgets/autocompleteField.dart';
import 'package:job_letter/utils/widgets/customField.dart';
import 'package:job_letter/utils/widgets/customSnackbar.dart';
import 'package:job_letter/view/addOrderScreen/addOrderController.dart';
import 'package:job_letter/utils/color.dart';
import 'package:job_letter/utils/style.dart';

class AddOrderScreen extends StatefulWidget {
  const AddOrderScreen({super.key, this.id});

  final int? id;

  @override
  State<AddOrderScreen> createState() => _AddOrderScreenState();
}

class _AddOrderScreenState extends State<AddOrderScreen> {
  ImagePicker picker = ImagePicker();
  File? image;
  AddOrderController controller = Get.put(AddOrderController());

  @override
  void initState() {
    getdata();
    super.initState();
  }

  getdata() async {
    if (widget.id != null) {
      print("-------------- >> : ${widget.id!}");

      controller.isLoading.value = true;

      await controller.getOrderdata(widget.id!);
      controller.isLoading.value = false;
    } else {
      print("--------------- >> : ID IS NULL");

      controller.clearValue();

      await controller.getCurjobId();
    }
    controller.showlist();
  }

  ScrollController scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Order Form"),
      ),
      body: Form(
        key: controller.formKey,
        child: Obx(
          () => controller.isLoading.value == true
              ? Center(child: CircularProgressIndicator())
              : Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Obx(
                              () => Text(
                                "Job No. : ${controller.job.value}",
                                style: ThemeText.textBold17Black,
                              ),
                            ),
                            Spacer(),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Obx(
                                  () => GestureDetector(
                                    onTap: () async {
                                      DateTime? pickedDate =
                                          await showDatePicker(
                                              builder: (context, child) {
                                                return Theme(
                                                  data: Theme.of(context)
                                                      .copyWith(
                                                    colorScheme:
                                                        ColorScheme.light(
                                                      primary:
                                                          ColorTheme.lightblue,
                                                      onPrimary: Colors.white,
                                                      onSurface:
                                                          Colors.blueAccent,
                                                    ),
                                                    textButtonTheme:
                                                        TextButtonThemeData(
                                                      style: TextButton.styleFrom(
                                                          foregroundColor:
                                                              ColorTheme
                                                                  .lightblue),
                                                    ),
                                                  ),
                                                  child: child!,
                                                );
                                              },
                                              context: context,
                                              initialDate: DateTime.now(),

                                              //get today's date
                                              firstDate: DateTime(2000),
                                              lastDate: DateTime(3000));

                                      if (pickedDate != null) {
                                        String formattedDate =
                                            DateFormat('dd-MM-yyyy')
                                                .format(pickedDate);

                                        controller.orderdate.value =
                                            formattedDate;
                                      } else {
                                        print("Date is not selected");
                                      }
                                    },
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text("Order Date :  ",
                                            style: ThemeText.textnormalBlack),
                                        controller.orderdate != ""
                                            ? Obx(() => Text(
                                                  controller.orderdate.value,
                                                  style: ThemeText.datestyle,
                                                ))
                                            : Text(
                                                controller.curDate(),
                                                style: ThemeText.datestyle,
                                              )
                                      ],
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 5.h,
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("Delivery Date :  ",
                                        style: ThemeText.textnormalBlack),
                                    Obx(
                                      () => GestureDetector(
                                        onTap: () async {
                                          DateTime? pickedDate =
                                              await showDatePicker(
                                                  builder: (context, child) {
                                                    return Theme(
                                                      data: Theme.of(context)
                                                          .copyWith(
                                                        colorScheme:
                                                            ColorScheme.light(
                                                          primary: ColorTheme
                                                              .lightblue,
                                                          onPrimary:
                                                              Colors.white,
                                                          onSurface:
                                                              Colors.blueAccent,
                                                        ),
                                                        textButtonTheme:
                                                            TextButtonThemeData(
                                                          style: TextButton.styleFrom(
                                                              foregroundColor:
                                                                  ColorTheme
                                                                      .lightblue),
                                                        ),
                                                      ),
                                                      child: child!,
                                                    );
                                                  },
                                                  context: context,
                                                  initialDate: DateTime.now(),
                                                  firstDate: DateTime(2000),
                                                  lastDate: DateTime(3000));

                                          if (pickedDate != null) {
                                            String formattedDate =
                                                DateFormat('dd-MM-yyyy')
                                                    .format(pickedDate);

                                            controller.deliverydate.value =
                                                formattedDate;
                                          } else {
                                            print("Date is not selected");
                                          }
                                        },
                                        child: controller.deliverydate != ""
                                            ? Obx(() => Text(
                                                  controller.deliverydate.value,
                                                  style: ThemeText.datestyle,
                                                ))
                                            : Text(
                                                controller.curDate(),
                                                style: ThemeText.datestyle,
                                              ),
                                      ),
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 20.h,
                        ),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text("Party Name",
                              style: ThemeText.textBoldStyle),
                        ),
                        SizedBox(
                          height: 5.h,
                        ),
                        TextFormField(
                          controller: controller.txtname,
                          textInputAction: TextInputAction.next,
                          cursorColor: ColorTheme.lightblue,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(6.sp)),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: ColorTheme.lightblue, width: 2.0),
                              ),
                              hintText: 'Enter Party Name',
                              hintStyle: ThemeText.textHintStyle),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Required*';
                            }
                            return null;
                          },
                        ),
                        SizedBox(
                          height: 15.h,
                        ),
                        Center(
                          child: InkWell(
                            onTap: pickImage,
                            child: Container(
                              height: 410.h,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: widget.id != null
                                      ? image == null
                                          ? NetworkImage(
                                                  controller.imageUrl.value)
                                              as ImageProvider
                                          : FileImage(
                                              File(image!.path),
                                            )
                                      : image == null
                                          ? NetworkImage(
                                                  "https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_1280.png")
                                              as ImageProvider
                                          : FileImage(
                                              File(image!.path),
                                            ),
                                ),
                              ),
                            ),
                          ),
                        ),

                        if (widget.id == null)
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: 30.h,
                              ),
                              Obx(
                                () => Row(
                                  children: [
                                    Expanded(
                                      child: Container(
                                        decoration: BoxDecoration(
                                            color: ColorTheme.bluechatCard,
                                            border: Border.all(
                                                width: 1, color: Colors.black),
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(5.sp))),
                                        child: DropdownButton(
                                            onTap: null,
                                            padding: EdgeInsets.only(
                                                left: 10, right: 10),
                                            underline: SizedBox(),
                                            icon:
                                                Icon(Icons.keyboard_arrow_down),
                                            isExpanded: true,
                                            autofocus: true,
                                            focusColor: ColorTheme.bluechatCard,
                                            iconSize: 24,
                                            elevation: 16,
                                            value: controller
                                                .orderItemStatus.value,
                                            borderRadius:
                                                BorderRadius.circular(5),
                                            items: controller.orderItem.entries
                                                .map(
                                                  (item) => DropdownMenuItem(
                                                    value: item.key,
                                                    child: Text(item.value),
                                                  ),
                                                )
                                                .toList(),
                                            onChanged: (value) {
                                              print("-----$value");
                                              controller.orderItemStatus.value =
                                                  value ?? "Cotation";
                                            }),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        SizedBox(
                          height: 20.h,
                        ),
                        //channel latter
                        if (controller.orderItemStatus == "Channel Latter")
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Channel Letter",
                                style: ThemeText.textBold17Black,
                              ),
                              SizedBox(
                                height: 10.h,
                              ),
                              Column(
                                children: [
                                  SizedBox(
                                    height: 10.h,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 10.0, right: 10),
                                    child: Row(
                                      children: [
                                        SizedBox(
                                          width: 110.w,
                                          child: Text("Side Wall Color",
                                              style: ThemeText.textBoldBlack),
                                        ),
                                        SizedBox(
                                          width: 20.w,
                                        ),
                                        Expanded(
                                          child: AutoCompleteField
                                              .autoCompleteField(
                                                  "Color",
                                                  controller.txtsidewallColor,
                                                  controller.sidewallcolor),
                                        )
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 10.0, right: 10),
                                    child: Row(
                                      children: [
                                        SizedBox(
                                          width: 110.w,
                                          child: Text("Acrylic Color",
                                              style: ThemeText.textBoldBlack),
                                        ),
                                        SizedBox(
                                          width: 20.w,
                                        ),
                                        Expanded(
                                          child: AutoCompleteField
                                              .autoCompleteField(
                                                  "Color",
                                                  controller.txtacrylicColor,
                                                  controller.acreyliccolor),
                                        )
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10.h,
                                  ),
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text("Strey Detail",
                                        style: ThemeText.textBoldStyle),
                                  ),
                                  SizedBox(
                                    height: 5.h,
                                  ),
                                  AutoCompleteField.autoCompleteField(
                                      "Enter Strey Detail",
                                      controller.txtstrey,
                                      controller.streydetaillist),
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text("Other Detail",
                                        style: ThemeText.textBoldStyle),
                                  ),
                                  SizedBox(
                                    height: 5.h,
                                  ),
                                  CustomField.customField(
                                      controller.txtchennelotherDetail,
                                      "Enter Other Detail"),
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text("Inch",
                                        style: ThemeText.textBoldStyle),
                                  ),
                                  SizedBox(
                                    height: 5.h,
                                  ),
                                  AutoCompleteField.autoCompleteField(
                                      "Enter Inch",
                                      controller.txtchennelinch,
                                      controller.channelinchlist,
                                      type: TextInputType.number),
                                ],
                              ),
                              SizedBox(
                                height: 8.h,
                              ),
                            ],
                          ),

                        //ss latter
                        if (controller.orderItemStatus == "SS Latter")
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "SS Latter",
                                style: TextStyle(
                                    fontSize: 20.sp,
                                    fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                height: 10.h,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 10.0, right: 10),
                                child: Row(
                                  children: [
                                    Text("SS Color",
                                        style: ThemeText.textBoldBlack),
                                    SizedBox(
                                      width: 30.w,
                                    ),
                                    Expanded(
                                      child:
                                          AutoCompleteField.autoCompleteField(
                                              "Color",
                                              controller.txtsscolor,
                                              controller.sscolorlist),
                                    )
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 10.h,
                              ),
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Text("Other Detail",
                                    style: ThemeText.textBoldStyle),
                              ),
                              SizedBox(
                                height: 5.h,
                              ),
                              CustomField.customField(
                                  controller.txtssotherDetail,
                                  "Enter Other Detail"),
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Text("Inch",
                                    style: ThemeText.textBoldStyle),
                              ),
                              SizedBox(
                                height: 5.h,
                              ),
                              AutoCompleteField.autoCompleteField("Enter Inch",
                                  controller.txtssinch, controller.ssinchlist,
                                  type: TextInputType.number),
                              SizedBox(
                                height: 8.h,
                              ),
                            ],
                          ),
                        //only cutting
                        if (controller.orderItemStatus == "Only Cutting")
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // widget.id == null
                              //     ?
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Only Cutting",
                                    style: TextStyle(
                                        fontSize: 20.sp,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(
                                    height: 10.h,
                                  ),
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text("Cutting Type",
                                        style: ThemeText.textBoldStyle),
                                  ),
                                  SizedBox(
                                    height: 5.h,
                                  ),
                                  Row(
                                    children: [
                                      Expanded(
                                        child:
                                            AutoCompleteField.autoCompleteField(
                                                "Enter Cutting Type",
                                                controller.txtcuttingtype,
                                                controller.cuttingtypelist),
                                      ),
                                      SizedBox(
                                        width: 20.w,
                                      ),
                                      Obx(
                                        () => DropdownButton(
                                            underline: SizedBox(),
                                            icon:
                                                Icon(Icons.keyboard_arrow_down),
                                            iconSize: 24,
                                            elevation: 16,
                                            value:
                                                controller.cuttingStatus.value,
                                            borderRadius:
                                                BorderRadius.circular(15),
                                            focusColor: Colors.black54,
                                            items: controller
                                                .dropdownCuttingItem.entries
                                                .map(
                                                  (item) => DropdownMenuItem(
                                                    value: item.key,
                                                    child: Text(item.value),
                                                  ),
                                                )
                                                .toList(),
                                            onChanged: (value) {
                                              print("-----$value");

                                              controller.cuttingStatus.value =
                                                  value ?? 1.0;

                                              controller.resultChange();
                                            }),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 8.h,
                                  ),
                                  Obx(
                                    () => Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        SizedBox(
                                          width: 80.w,
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                bottom: 8.0),
                                            child: TextFormField(
                                              controller: controller.txtno1,
                                              cursorColor: ColorTheme.lightblue,
                                              keyboardType:
                                                  TextInputType.number,
                                              textInputAction:
                                                  TextInputAction.next,
                                              onChanged: (val) {
                                                controller.sum1 = double.parse(
                                                    controller
                                                            .txtno1.text.isEmpty
                                                        ? "0"
                                                        : controller
                                                            .txtno1.text);
                                                controller.resultChange();
                                              },
                                              validator: (value) {
                                                if (value!.isEmpty) {
                                                  return 'Required*';
                                                }
                                                return null;
                                              },
                                              decoration: InputDecoration(
                                                  border: OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              6.sp)),
                                                  focusedBorder:
                                                      OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                        color: ColorTheme
                                                            .lightblue,
                                                        width: 2.0),
                                                  ),
                                                  hintText: "XX",
                                                  hintStyle:
                                                      ThemeText.textHintStyle),
                                            ),
                                          ),
                                        ),
                                        Text(
                                          "*",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 28.sp),
                                        ),
                                        SizedBox(
                                          width: 80.w,
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                bottom: 8.0),
                                            child: TextFormField(
                                              controller: controller.txtno2,
                                              cursorColor: ColorTheme.lightblue,
                                              keyboardType:
                                                  TextInputType.number,
                                              textInputAction:
                                                  TextInputAction.next,
                                              validator: (value) {
                                                if (value!.isEmpty) {
                                                  return 'Required*';
                                                }
                                                return null;
                                              },
                                              onChanged: (val) {
                                                controller.sum2 = double.parse(
                                                    controller
                                                            .txtno2.text.isEmpty
                                                        ? "0"
                                                        : controller
                                                            .txtno2.text);
                                                controller.resultChange();
                                              },
                                              decoration: InputDecoration(
                                                  border: OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              6.sp)),
                                                  focusedBorder:
                                                      OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                        color: ColorTheme
                                                            .lightblue,
                                                        width: 2.0),
                                                  ),
                                                  hintText: "XX",
                                                  hintStyle:
                                                      ThemeText.textHintStyle),
                                            ),
                                          ),
                                        ),
                                        Text(
                                          "=",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 28.sp),
                                        ),
                                        SizedBox(
                                          width: 80.w,
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                bottom: 8.0),
                                            child: TextFormField(
                                              cursorColor: ColorTheme.lightblue,
                                              controller: controller.txtanswer,
                                              readOnly: true,
                                              textInputAction:
                                                  TextInputAction.next,
                                              decoration: InputDecoration(
                                                  border: OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            6.sp),
                                                  ),
                                                  focusedBorder:
                                                      OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                        color: ColorTheme
                                                            .lightblue,
                                                        width: 2.0),
                                                  ),
                                                  hintText:
                                                      controller.result.value,
                                                  hintStyle:
                                                      ThemeText.textBoldBlack),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              //update
                              // : Column(
                              //     crossAxisAlignment:
                              //         CrossAxisAlignment.start,
                              //     children: [
                              //       Text(
                              //         "Only Cutting",
                              //         style: TextStyle(
                              //             fontSize: 20.sp,
                              //             fontWeight: FontWeight.bold),
                              //       ),
                              //       SizedBox(
                              //         height: 10.h,
                              //       ),
                              //       Align(
                              //         alignment: Alignment.centerLeft,
                              //         child: Text("Cutting Type",
                              //             style: ThemeText.textBoldStyle),
                              //       ),
                              //       SizedBox(
                              //         height: 5.h,
                              //       ),
                              //       Row(
                              //         children: [
                              //           Expanded(
                              //             child: AutoCompleteField
                              //                 .autoCompleteField(
                              //                     "Enter Cutting Type",
                              //                     controller.txtcuttingtype,
                              //                     controller
                              //                         .cuttingtypelist),
                              //           ),
                              //         ],
                              //       ),
                              //       SizedBox(
                              //         height: 8.h,
                              //       ),
                              //       Obx(
                              //         () => Row(
                              //           children: [
                              //             Text(
                              //               "Total   =    ",
                              //               style: TextStyle(
                              //                   fontWeight: FontWeight.w600,
                              //                   fontSize: 18.sp),
                              //             ),
                              //             SizedBox(
                              //               width: 80.w,
                              //               child: Padding(
                              //                 padding:
                              //                     const EdgeInsets.only(
                              //                         bottom: 8.0),
                              //                 child: TextFormField(
                              //                   cursorColor:
                              //                       ColorTheme.lightblue,
                              //                   controller:
                              //                       controller.txtanswer,
                              //                   readOnly: true,
                              //                   textInputAction:
                              //                       TextInputAction.next,
                              //                   decoration: InputDecoration(
                              //                       border:
                              //                           OutlineInputBorder(
                              //                         borderRadius:
                              //                             BorderRadius
                              //                                 .circular(
                              //                                     6.sp),
                              //                       ),
                              //                       focusedBorder:
                              //                           OutlineInputBorder(
                              //                         borderSide: BorderSide(
                              //                             color: ColorTheme
                              //                                 .lightblue,
                              //                             width: 2.0),
                              //                       ),
                              //                       hintText: controller
                              //                           .result.value,
                              //                       hintStyle: ThemeText
                              //                           .textBoldBlack),
                              //                 ),
                              //               ),
                              //             ),
                              //           ],
                              //         ),
                              //       ),
                              //       SizedBox(
                              //         height: 10.h,
                              //       ),
                              //     ],
                              //   ),
                            ],
                          ),
                        Text(
                          "Status",
                          style: TextStyle(
                              fontSize: 20.sp, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        Obx(
                          () => Row(
                            children: [
                              Expanded(
                                child: Container(
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          width: 1,
                                          color: ColorTheme.greyColor),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(5.sp))),
                                  child: DropdownButton(
                                      padding:
                                          EdgeInsets.only(left: 10, right: 10),
                                      underline: SizedBox(),
                                      icon: Icon(Icons.keyboard_arrow_down),
                                      isExpanded: true,
                                      iconSize: 24,
                                      elevation: 16,
                                      value: controller.orderStatus.value,
                                      borderRadius: BorderRadius.circular(5),
                                      items:
                                          controller.dropdownOrderItem.entries
                                              .map(
                                                (item) => DropdownMenuItem(
                                                  value: item.key,
                                                  child: Text(item.value),
                                                ),
                                              )
                                              .toList(),
                                      onChanged: (value) {
                                        print("-----$value");
                                        controller.orderStatus.value =
                                            value ?? "Cotation";
                                      }),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 20.h,
                        ),
                        Text(
                          "Payment Status",
                          style: TextStyle(
                              fontSize: 20.sp, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        Obx(
                          () => Row(
                            children: [
                              Expanded(
                                child: Container(
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          width: 1,
                                          color: ColorTheme.greyColor),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(5.sp))),
                                  child: DropdownButton(
                                      padding:
                                          EdgeInsets.only(left: 10, right: 10),
                                      underline: SizedBox(),
                                      icon: Icon(Icons.keyboard_arrow_down),
                                      isExpanded: true,
                                      iconSize: 24,
                                      elevation: 16,
                                      value: controller.paymentStatus.value,
                                      borderRadius: BorderRadius.circular(5),
                                      items:
                                          controller.dropdownPaymentItem.entries
                                              .map(
                                                (item) => DropdownMenuItem(
                                                  value: item.key,
                                                  child: Text(item.value),
                                                ),
                                              )
                                              .toList(),
                                      onChanged: (value) {
                                        print("-----$value");
                                        controller.paymentStatus.value =
                                            value ?? "Cotation";
                                      }),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 20.h,
                        ),
                        if (widget.id != null)
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Group Chat",
                                style: TextStyle(
                                    fontSize: 20.sp,
                                    fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                height: 10.h,
                              ),
                              StreamBuilder(
                                  stream: Firestore.instance
                                      .collection('Order')
                                      .document("${controller.uniqueid.value}")
                                      .stream,
                                  builder: (context, snapshot) {
                                    if (snapshot.hasError) {
                                      print("Error: --- ${snapshot.error}");
                                    } else if (snapshot.hasData) {
                                      var docList = snapshot.data!.map;

                                      controller.groupList.value =
                                          NewOrderModel.fromJson(docList)
                                                  .groupChat ??
                                              [];
                                      return Container(
                                        height: 300.h,
                                        width: double.infinity,
                                        decoration: BoxDecoration(
                                            border:
                                                Border.all(color: Colors.black),
                                            borderRadius:
                                                BorderRadius.circular(12)),
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Column(
                                            children: [
                                              Expanded(
                                                child: ListView.builder(
                                                    controller:
                                                        scrollController,
                                                    itemCount: controller
                                                        .groupList.length,
                                                    reverse: true,
                                                    itemBuilder:
                                                        (context, index) {
                                                      bool isSender = box.read(
                                                              GetString
                                                                  .email) ==
                                                          controller
                                                              .groupList[(controller
                                                                          .groupList
                                                                          .length -
                                                                      1) -
                                                                  index]
                                                              .email;

                                                      DateTime timestamp = controller
                                                          .groupList[(controller
                                                                      .groupList
                                                                      .length -
                                                                  1) -
                                                              index]
                                                          .timeStamp;
                                                      String formattedDate =
                                                          DateFormat(
                                                                  'dd-MM-yyyy – kk:mm')
                                                              .format(
                                                                  timestamp);
                                                      return Row(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        mainAxisAlignment:
                                                            isSender == true
                                                                ? MainAxisAlignment
                                                                    .end
                                                                : MainAxisAlignment
                                                                    .start,
                                                        children: [
                                                          if (isSender == false)
                                                            Container(
                                                              height: 35,
                                                              width: 35,
                                                              decoration: BoxDecoration(
                                                                  shape: BoxShape
                                                                      .circle,
                                                                  color: Colors
                                                                      .grey),
                                                              child: Center(
                                                                child: Text(
                                                                  "${controller.groupList[(controller.groupList.length - 1) - index].email!.substring(0, 2)}",
                                                                  style: TextStyle(
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold),
                                                                ),
                                                              ),
                                                            ),
                                                          SizedBox(
                                                            width: 5,
                                                          ),
                                                          Column(
                                                            crossAxisAlignment:
                                                                isSender == true
                                                                    ? CrossAxisAlignment
                                                                        .end
                                                                    : CrossAxisAlignment
                                                                        .start,
                                                            children: [
                                                              Padding(
                                                                padding: isSender ==
                                                                        true
                                                                    ? EdgeInsets
                                                                        .only(
                                                                            right:
                                                                                5)
                                                                    : EdgeInsets
                                                                        .only(
                                                                            left:
                                                                                0.0),
                                                                child: Text(
                                                                  "${controller.groupList[(controller.groupList.length - 1) - index].email!.split("@")[0]}",
                                                                  style: TextStyle(
                                                                      fontFamily:
                                                                          "Helvetica",
                                                                      fontSize:
                                                                          12.sp),
                                                                ),
                                                              ),
                                                              Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                            .only(
                                                                        right:
                                                                            5,
                                                                        bottom:
                                                                            8,
                                                                        top: 5),
                                                                child: Align(
                                                                  alignment: isSender ==
                                                                          true
                                                                      ? Alignment
                                                                          .centerRight
                                                                      : Alignment
                                                                          .centerLeft,
                                                                  child:
                                                                      Container(
                                                                    decoration:
                                                                        BoxDecoration(
                                                                      color: ColorTheme
                                                                          .bluechatCard,
                                                                      border: Border.all(
                                                                          color:
                                                                              Colors.black),
                                                                      borderRadius: isSender ==
                                                                              true
                                                                          ? BorderRadius
                                                                              .only(
                                                                              bottomRight: Radius.circular(10),
                                                                              bottomLeft: Radius.circular(10),
                                                                              topLeft: Radius.circular(10),
                                                                            )
                                                                          : BorderRadius
                                                                              .only(
                                                                              bottomRight: Radius.circular(10),
                                                                              bottomLeft: Radius.circular(10),
                                                                              topRight: Radius.circular(10),
                                                                            ),
                                                                    ),
                                                                    child:
                                                                        Column(
                                                                      crossAxisAlignment: isSender ==
                                                                              true
                                                                          ? CrossAxisAlignment
                                                                              .end
                                                                          : CrossAxisAlignment
                                                                              .start,
                                                                      children: [
                                                                        Padding(
                                                                          padding:
                                                                              const EdgeInsets.all(8.0),
                                                                          child:
                                                                              Text(
                                                                            "${controller.groupList[(controller.groupList.length - 1) - index].textMsg}",
                                                                            style: TextStyle(
                                                                                fontFamily: "Helvetica",
                                                                                fontSize: 15.sp,
                                                                                fontWeight: FontWeight.w600),
                                                                          ),
                                                                        ),
                                                                        Padding(
                                                                          padding: const EdgeInsets.only(
                                                                              left: 8.0,
                                                                              right: 8,
                                                                              bottom: 8),
                                                                          child:
                                                                              Text(
                                                                            formattedDate,
                                                                            style: TextStyle(
                                                                                fontFamily: "Helvetica",
                                                                                fontSize: 12.sp,
                                                                                color: Colors.grey),
                                                                          ),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ),
                                                                ),
                                                              )
                                                            ],
                                                          ),
                                                          if (isSender == true)
                                                            Container(
                                                              height: 35,
                                                              width: 35,
                                                              decoration:
                                                                  BoxDecoration(
                                                                shape: BoxShape
                                                                    .circle,
                                                                color:
                                                                    Colors.grey,
                                                              ),
                                                              child: Center(
                                                                  child: Text(
                                                                "${controller.groupList[(controller.groupList.length - 1) - index].email!.substring(0, 2)}",
                                                                style: TextStyle(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold),
                                                              )),
                                                            ),
                                                        ],
                                                      );
                                                    }),
                                              ),
                                              SizedBox(
                                                height: 10.h,
                                              ),
                                              Stack(
                                                children: [
                                                  Row(
                                                    children: [
                                                      Expanded(
                                                        child: TextFormField(
                                                          controller: controller
                                                              .txtsendmsg,
                                                          cursorColor:
                                                              ColorTheme
                                                                  .lightblue,
                                                          decoration:
                                                              InputDecoration(
                                                                  border: OutlineInputBorder(
                                                                      borderRadius:
                                                                          BorderRadius.circular(6
                                                                              .sp)),
                                                                  focusedBorder:
                                                                      OutlineInputBorder(
                                                                    borderSide: BorderSide(
                                                                        color: ColorTheme
                                                                            .lightblue,
                                                                        width:
                                                                            2.0),
                                                                  ),
                                                                  hintText:
                                                                      "Type Here..",
                                                                  hintStyle:
                                                                      ThemeText
                                                                          .textHintStyle),
                                                        ),
                                                      ),
                                                      IconButton(
                                                          onPressed: () {
                                                            if (controller
                                                                    .txtsendmsg
                                                                    .text !=
                                                                "") {
                                                              controller
                                                                  .groupList
                                                                  .add(
                                                                GroupChat(
                                                                  email: box.read(
                                                                      GetString
                                                                          .email),
                                                                  textMsg:
                                                                      controller
                                                                          .txtsendmsg
                                                                          .text,
                                                                  timeStamp:
                                                                      DateTime
                                                                          .timestamp(),
                                                                ),
                                                              );
                                                              controller
                                                                  .txtsendmsg
                                                                  .clear();
                                                              firebase.insertChat(
                                                                  widget.id!,
                                                                  controller
                                                                      .groupList);
                                                            } else {
                                                              print(
                                                                  "Something Went Wrong");
                                                            }
                                                          },
                                                          icon:
                                                              Icon(Icons.send))
                                                    ],
                                                  )
                                                ],
                                              )
                                            ],
                                          ),
                                        ),
                                      );
                                    }
                                    return Center(
                                        child: CircularProgressIndicator());

                                    // } else {
                                    //   return CircularProgressIndicator();
                                    // }
                                  }),
                            ],
                          ),
                        SizedBox(
                          height: 20.h,
                        ),
                        Center(
                          child: MaterialButton(
                            onPressed: () async {
                              controller.addColorList();
                              final isValid =
                                  controller.formKey.currentState!.validate();
                              if (isValid) {
                                if (widget.id == null) {
                                  print("------------>>>> Insert Data");
                                  if (controller.job.value !=
                                      controller.curJob.value) {
                                    print("----->> : Job ID Updated");
                                    // SnackBars.successSnackBar(
                                    //     content: "Job ID Updated");
                                  }
                                  if (image != null) {
                                    Get.back();
                                    await uploadImage();

                                    firebase.insertOrderData(
                                        context,
                                        box.read(GetString.email),
                                        controller.job.value,
                                        controller.orderdate.value != ""
                                            ? controller.orderdate.value
                                            : controller.curDate(),
                                        controller.deliverydate.value != ""
                                            ? controller.deliverydate.value
                                            : controller.curDate(),
                                        controller.txtname.text,
                                        controller.paymentStatus.value,
                                        controller.orderItemStatus.value,
                                        controller.getImage(
                                            controller.imageName.value,
                                            controller.imageToken.value),
                                        controller.txtsidewallColor.text,
                                        controller.txtacrylicColor.text,
                                        controller.txtstrey.text,
                                        controller.txtchennelotherDetail.text,
                                        controller.txtchennelinch.text,
                                        controller.txtsscolor.text,
                                        controller.txtssotherDetail.text,
                                        controller.txtssinch.text,
                                        controller.txtcuttingtype.text,
                                        controller.cuttingType(
                                            controller.cuttingStatus.value),
                                        controller.txtno1.text,
                                        controller.txtno2.text,
                                        "${controller.result.value}  ${controller.cuttingType(controller.cuttingStatus.value)}",
                                        controller.orderStatus.value);
                                  } else {
                                    SnackBars.errorSnackBar(
                                        content: "Image Is Required!");
                                  }
                                } else {
                                  print("------------>>>> Update Data");
                                  await uploadImage();

                                  firebase.updateOrderData(
                                      context,
                                      widget.id!,
                                      box.read(GetString.email),
                                      controller.job.value,
                                      controller.orderdate.value != ""
                                          ? controller.orderdate.value
                                          : controller.curDate(),
                                      controller.deliverydate.value != ""
                                          ? controller.deliverydate.value
                                          : controller.curDate(),
                                      controller.txtname.text,
                                      controller.paymentStatus.value,
                                      controller.orderItemStatus.value,
                                      controller.imageName == ""
                                          ? controller.imageUrl.value
                                          : controller.getImage(
                                              controller.imageName.value,
                                              controller.imageToken.value),
                                      controller.txtsidewallColor.text,
                                      controller.txtacrylicColor.text,
                                      controller.txtstrey.text,
                                      controller.txtchennelotherDetail.text,
                                      controller.txtchennelinch.text,
                                      controller.txtsscolor.text,
                                      controller.txtssotherDetail.text,
                                      controller.txtssinch.text,
                                      controller.txtcuttingtype.text,
                                      controller.cuttingType(
                                          controller.cuttingStatus.value),
                                      controller.txtno1.text,
                                      controller.txtno2.text,
                                      controller.result.value,
                                      controller.orderStatus.value);
                                }

                                controller.formKey.currentState?.save();
                              } else {
                                return;
                              }
                            },
                            minWidth: 120.w,
                            height: 45.h,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(14.sp),
                            ),
                            color: ColorTheme.lightblue,
                            child: Text(
                              "Submit",
                              style: TextStyle(
                                  fontSize: 18.sp, color: Colors.white),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                      ],
                    ),
                  ),
                ),
        ),
      ),
    );
  }

  pickImage() async {
    final XFile? pickedImage =
        await picker.pickImage(source: ImageSource.gallery);

    if (pickedImage != null) {
      setState(() {
        image = File(pickedImage.path);
      });
    }
  }

  uploadImage() async {
    if (image != null) {
      try {
        String uniqueFileName =
            DateTime.now().millisecondsSinceEpoch.toString();

        var headers = {'Content-Type': 'image/png'};
        var request = http.MultipartRequest(
            'POST',
            Uri.parse(
                'https://firebasestorage.googleapis.com/v0/b/joblatter-36cbb.appspot.com/o/images%2F$uniqueFileName'));
        request.files
            .add(await http.MultipartFile.fromPath('data', image!.path));
        request.headers.addAll(headers);

        http.StreamedResponse response = await request.send();

        if (response.statusCode == 200) {
          var imageData = await response.stream.bytesToString();
          ImageModel imageModel = ImageModel.fromJson(json.decode(imageData));

          controller.imageName.value = imageModel.name!.split("/")[1];
          controller.imageToken.value = imageModel.downloadTokens!;
          print("---------->> : Photo Upload Successfully");
          // SnackBars.successSnackBar(content: "Photo Upload Successfully");
        } else {
          print(response.reasonPhrase);
        }
      } catch (e) {
        print("---------->> : Photo Not Upload");

        // SnackBars.errorSnackBar(content: "Photo Not Upload");
      }
    } else {
      print("---------->> : Photo Not Upload");

      // SnackBars.errorSnackBar(content: "Photo Not Upload");
    }
  }
}
