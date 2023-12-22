// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:file_selector/file_selector.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:job_letter/main.dart';
import 'package:job_letter/utils/color.dart';
import 'package:job_letter/utils/string.dart';
import 'package:job_letter/utils/style.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  RxString path = "".obs;

  @override
  void initState() {
    path.value = box.read(GetString.storagepath) ?? "Choose Your Download Path";
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        // automaticallyImplyLeading: false,
        title: Text("Setting"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Card(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Obx(
                  () => Row(
                    children: [
                      Text(
                        "Saved File Path : ",
                        style: ThemeText.textBold17Black,
                      ),
                      Container(
                        width: 100.w,
                        child: Text(
                          path.value,
                          style: ThemeText.textBoldStyle,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                        ),
                      ),
                      Spacer(),
                      Center(
                        child: OutlinedButton(
                          style: OutlinedButton.styleFrom(
                            side: BorderSide(color: ColorTheme.lightblue),
                          ),
                          onPressed: () async {
                            final String? directoryPath =
                                await getDirectoryPath();
                            if (directoryPath != null) {
                              box.write(GetString.storagepath, directoryPath);
                              path.value = directoryPath;
                            }
                          },
                          child: Text(
                            "Choose Path",
                            style: TextStyle(
                              fontFamily: 'Helvetica',
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
