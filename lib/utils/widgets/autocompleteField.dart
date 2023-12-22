import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:job_letter/utils/color.dart';
import 'package:job_letter/utils/style.dart';

class AutoCompleteField
{
  static
  autoCompleteField(
      String hinttext, TextEditingController controller, List<String> listdata,
      {TextInputType? type}) {
    return Autocomplete(
      fieldViewBuilder: (BuildContext context,
          TextEditingController textEditingController,
          FocusNode focusNode,
          VoidCallback onFieldSubmitted) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 8.0),
          child: TextFormField(
            controller: textEditingController,
            cursorColor: ColorTheme.lightblue,
            focusNode: focusNode,
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
                border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(6.sp)),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: ColorTheme.lightblue, width: 2.0),
                ),
                hintText: hinttext,
                hintStyle: ThemeText.textHintStyle),
          ),
        );
      },
      initialValue: controller.value,
      onSelected: (String item) {},
      optionsBuilder: (TextEditingValue value) {
        controller.text = value.text;
        if (value.text == "") {
          return Iterable<String>.empty();
        }
        return listdata.where((String item) {
          return item.contains(value.text.toLowerCase());
        });
      },
    );
  }
}