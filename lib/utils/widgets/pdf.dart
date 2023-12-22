// ignore_for_file: prefer_const_constructors, deprecated_member_use, unnecessary_null_comparison

import 'dart:io';

import 'package:file_selector/file_selector.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:job_letter/main.dart';
import 'package:job_letter/utils/string.dart';
import 'package:job_letter/view/addOrderScreen/addOrderController.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:http/http.dart' as http;
import 'package:pdf/widgets.dart' as pw;
import 'package:share_plus/share_plus.dart';

AddOrderController addOrderController = Get.put(AddOrderController());

writeOnPdf() async {
  final pdf = pw.Document();

  final response = await http.get(Uri.parse(addOrderController.imageUrl.value));

  // print("----- imagefile  : ${response.bodyBytes}");
  final Uint8List bytes = response.bodyBytes;

  //  final ByteData imageData = await NetworkAssetBundle(Uri.parse(addOrderController.imageUrl.value)).load(addOrderController.imageUrl.value);
  // final Uint8List bytes = imageData.buffer.asUint8List();

  final profileImage = pw.MemoryImage(bytes);
  final font = await rootBundle.load("assets/fonts/Helvetica.ttf");
  final ttf = pw.Font.ttf(font);

  pdf.addPage(pw.MultiPage(
    pageFormat: PdfPageFormat.a4,
    margin: pw.EdgeInsets.all(32),
    build: (pw.Context context) {
      return <pw.Widget>[
        pw.Header(
          level: 0,
          child: pw.Row(
            mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
            children: <pw.Widget>[
              pw.Text('Order Form',
                  textScaleFactor: 2, style: pw.TextStyle(font: ttf)),
            ],
          ),
        ),
        pw.Padding(
          padding: const pw.EdgeInsets.all(8.0),
          child: pw.Column(
            mainAxisSize: pw.MainAxisSize.min,
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.end,
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  pw.Text("Job No. : ${addOrderController.job.value}",
                      style: pw.TextStyle(font: ttf)),
                  pw.Spacer(),
                  pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.end,
                    children: [
                      pw.Text(
                          "Order Date :  ${addOrderController.orderdate.value}",
                          style: pw.TextStyle(font: ttf)),
                      pw.SizedBox(
                        height: 5,
                      ),
                      pw.Text(
                          "Delivery Date :  ${addOrderController.deliverydate.value}",
                          style: pw.TextStyle(
                            font: ttf,
                          )),
                    ],
                  ),
                ],
              ),
              pw.SizedBox(
                height: 20,
              ),
              pw.Align(
                alignment: pw.Alignment.centerLeft,
                child: pw.Text(
                    "Party Name : ${addOrderController.txtname.text}",
                    style: pw.TextStyle(font: ttf)),
              ),
              pw.SizedBox(
                height: 15,
              ),
              pw.Center(
                child: pw.Container(
                  height: 450,
                  color: PdfColors.grey,
                  child: pw.Image(profileImage),
                ),
              ),
              if(addOrderController.orderItemStatus.value == "Channel Latter")
              pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  pw.SizedBox(
                    height: 20,
                  ),
                  pw.Header(
                      level: 1,
                      text: 'Channel Latter',
                      textStyle: pw.TextStyle(font: ttf)),
                  pw.SizedBox(
                    height: 10,
                  ),
                  pw.Text(
                      "Side Wall Color : ${addOrderController.txtsidewallColor.text}",
                      style: pw.TextStyle(font: ttf)),
                  pw.SizedBox(
                    height: 10,
                  ),
                  pw.Text(
                      "Acrylic Color : ${addOrderController.txtacrylicColor.text}",
                      style: pw.TextStyle(font: ttf)),
                  pw.SizedBox(
                    height: 10,
                  ),
                  pw.Text("Strey Detail : ${addOrderController.txtstrey.text}",
                      style: pw.TextStyle(font: ttf)),
                  pw.SizedBox(
                    height: 10,
                  ),
                  pw.Text(
                      "Other Detail : ${addOrderController.txtchennelotherDetail.text}",
                      style: pw.TextStyle(font: ttf)),
                  pw.SizedBox(
                    height: 10,
                  ),
                  pw.Text("Inch : ${addOrderController.txtchennelinch.text}",
                      style: pw.TextStyle(font: ttf)),
                ]
              ),
              if(addOrderController.orderItemStatus.value == "SS Latter")

                pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  pw.SizedBox(
                    height: 15,
                  ),
                  pw.Header(
                      level: 1,
                      text: 'SS Latter',
                      textStyle: pw.TextStyle(font: ttf)),
                  pw.SizedBox(
                    height: 10,
                  ),
                  pw.Text("SS Color : ${addOrderController.txtsscolor.text}",
                      style: pw.TextStyle(font: ttf)),
                  pw.SizedBox(
                    height: 10,
                  ),
                  pw.Text(
                      "Other Detail : ${addOrderController.txtssotherDetail.text}",
                      style: pw.TextStyle(font: ttf)),
                  pw.SizedBox(
                    height: 10,
                  ),
                  pw.Text("Inch : ${addOrderController.txtssinch.text}",
                      style: pw.TextStyle(font: ttf)),
                ]
              ),
              pw.SizedBox(
                height: 15,
              ),
              if(addOrderController.orderItemStatus.value == "Only Cutting")

                pw.Column(
               crossAxisAlignment: pw.CrossAxisAlignment.start,
                 children: [ pw.Header(
                 level: 1,
                 text: 'Only Cutting',
                 textStyle: pw.TextStyle(font: ttf)),
               pw.SizedBox(
                 height: 10,
               ),
               pw.Text(
                   "Cutting Type : ${addOrderController.txtcuttingtype.text}",
                   style: pw.TextStyle(font: ttf)),
               pw.SizedBox(
                 height: 10,
               ),
               pw.Text("Total  =  ${addOrderController.result.value}",
                   style: pw.TextStyle(font: ttf)),
               pw.SizedBox(
                 height: 10,
               ),]),
            ],
          ),
        ),
      ];
    },
  ));

  Directory documentDirectory = await getTemporaryDirectory();
  String documentPath = documentDirectory.path;

  String uniqueFileName = DateTime.now().millisecondsSinceEpoch.toString();

  File file = File("$documentPath\\$uniqueFileName.pdf");
  file.writeAsBytesSync(await pdf.save());

  print("----<<  PATH : ${file.path}");
  if (Platform.isWindows) {
    if (box.read(GetString.storagepath) == null) {
      final String? directoryPath = await getDirectoryPath();
      await file.copy("$directoryPath\\$uniqueFileName.pdf");
      box.write(GetString.storagepath, directoryPath);
    } else {
      await file
          .copy("${box.read(GetString.storagepath)}\\$uniqueFileName.pdf");
    }
  } else {
    Share.shareXFiles([XFile(file.path)]);
  }
}
