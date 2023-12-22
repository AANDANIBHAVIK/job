import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:job_letter/utils/color.dart';
import 'package:job_letter/utils/style.dart';

class CustomField
{
  static customField(TextEditingController controller, String texthint,
      {TextInputType? type}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: TextFormField(
        controller: controller,
        cursorColor: ColorTheme.lightblue,
        keyboardType: type,

        textInputAction: TextInputAction.next,
        validator: (value) {
          if (value!.isEmpty )
          {
            return 'Required*';
          }
          return null;
        },
        decoration: InputDecoration(
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(6.sp)),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: ColorTheme.lightblue, width: 2.0),
            ),
            hintText: texthint,
            hintStyle: ThemeText.textHintStyle),
      ),
    );
  }
}