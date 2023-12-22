// ignore_for_file: prefer_const_constructors, file_names


import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:job_letter/view/addUserScreen/addUserController.dart';

import 'package:job_letter/utils/color.dart';
import 'package:job_letter/utils/style.dart';

class AddUserScreen extends StatefulWidget {
  const AddUserScreen({super.key});

  @override
  State<AddUserScreen> createState() => _AddUserScreenState();
}

class _AddUserScreenState extends State<AddUserScreen> {
  AddUserController controller = Get.put(AddUserController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Add New User"),
      ),
      body:Padding(
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
                controller: controller.addEmail,
                textInputAction: TextInputAction.next,
                cursorColor: ColorTheme.lightblue,
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(6.sp)),
                    focusedBorder: OutlineInputBorder(
                      borderSide:
                      BorderSide(color: ColorTheme.lightblue, width: 2.0),
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
                controller: controller.addPassword,
                textInputAction: TextInputAction.next,
                obscureText: true,
                cursorColor: ColorTheme.lightblue,
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(6.sp)),
                    focusedBorder: OutlineInputBorder(
                      borderSide:
                      BorderSide(color: ColorTheme.lightblue, width: 2.0),
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
                height: 10.h,
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Text("Type", style: ThemeText.textBoldStyle),
              ),
              SizedBox(
                height: 5.h,
              ),
              Obx(
                    () => Row(
                  children: [
                    Expanded(
                      child: Container(
                        height: 55.h,
                        decoration: BoxDecoration(
                            border: Border.all(
                                width: controller.type.value == "admin"
                                    ? 2
                                    : 1,
                                color: controller.type.value == "admin"
                                    ? ColorTheme.lightblue
                                    : ColorTheme.greyColor),
                            borderRadius:
                            BorderRadius.all(Radius.circular(5.sp))),
                        child: Center(
                          child: RadioListTile(

                            title: Text(
                              "Admin",
                              style: TextStyle(
                                  color: controller.type.value == "admin"
                                      ? ColorTheme.lightblue
                                      :  ColorTheme.greyColor,
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w400),
                            ),
                            activeColor: ColorTheme.lightblue,
                            value: "admin",
                            groupValue: controller.type.value,
                            onChanged: (value) {
                              controller.type.value = value.toString();
                            },
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 10.w,
                    ),
                    Expanded(
                      child: Container(
                        height: 55.h,
                        decoration: BoxDecoration(
                            border: Border.all(
                                width: controller.type.value == "user"
                                    ? 2
                                    : 1,
                                color: controller.type.value == "user"
                                    ? ColorTheme.lightblue
                                    : ColorTheme.greyColor),
                            borderRadius:
                            BorderRadius.all(Radius.circular(5.sp))),
                        child: Center(
                          child: RadioListTile(
                            title: Text(
                              "User",
                              style: TextStyle(
                                  color: controller.type.value == "user"
                                      ? ColorTheme.lightblue
                                      :ColorTheme.greyColor,
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w400),
                            ),
                            activeColor: ColorTheme.lightblue,
                            value: "user",
                            groupValue: controller.type.value,
                            onChanged: (value) {
                              controller.type.value = value.toString();
                            },
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 30.h,
              ),
              MaterialButton(
                onPressed: () {
                  controller.checkUser(context);


                },
                minWidth: 120.w,
                height: 45.h,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14.sp),
                ),
                color: ColorTheme.lightblue,
                child: Text(
                  "Add",
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
