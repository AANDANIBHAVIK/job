// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:job_letter/firebase/firebase.dart';
import 'package:job_letter/utils/color.dart';
import 'package:job_letter/utils/permission/permission.dart';
import 'package:job_letter/utils/widgets/customSnackbar.dart';
import 'package:job_letter/utils/widgets/pdf.dart';
import 'package:job_letter/view/addOrderScreen/addOrderController.dart';
import 'package:job_letter/view/addOrderScreen/addOrderScreen.dart';
import 'package:pluto_grid/pluto_grid.dart';

import '../../model/newOrderModel.dart';

class AllOrderController extends GetxController {
  List<NewOrderModel> modelDataList = <NewOrderModel>[];
  List<NewOrderModel> newOrderModel = [];

  List<NewOrderModel> orders = <NewOrderModel>[];
  PlutoGridStateManager? stateManager;
  RxInt curIndex = 1.obs;

  // RxString job = "".obs;

  List<PlutoRow> orderData = [];
  RxList<PlutoRow> orderRowData = <PlutoRow>[].obs;

  final List<PlutoColumn> columns = <PlutoColumn>[
    PlutoColumn(
      title: 'Id',
      field: 'id',
      readOnly: true,
      enableColumnDrag: false,
      enableEditingMode: false,
      backgroundColor: ColorTheme.blueGridColumn,
      type: PlutoColumnType.number(),
    ),
    PlutoColumn(
      title: 'Name',
      field: 'name',
      readOnly: true,
      enableEditingMode: false,
      enableColumnDrag: false,
      backgroundColor: ColorTheme.blueGridColumn,
      type: PlutoColumnType.text(),
    ),
    PlutoColumn(
      title: 'Order Date',
      field: 'order Date',
      enableColumnDrag: false,
      backgroundColor: ColorTheme.blueGridColumn,
      readOnly: true,
      enableEditingMode: false,
      type: PlutoColumnType.date(
          format: 'dd-MM-yyyy',
          headerFormat: 'dd-MM-yyyy',
          applyFormatOnInit: false),
    ),
    PlutoColumn(
      title: 'Delivery Date',
      field: 'delivery Date',
      enableColumnDrag: false,
      backgroundColor: ColorTheme.blueGridColumn,
      readOnly: true,
      enableEditingMode: false,
      type: PlutoColumnType.date(
          format: 'dd-MM-yyyy',
          headerFormat: 'dd-MM-yyyy',
          applyFormatOnInit: false),
    ),
    PlutoColumn(
      title: 'Status',
      field: 'status',
      enableColumnDrag: false,
      backgroundColor: ColorTheme.blueGridColumn,
      type: PlutoColumnType.select(
        <String>[
          "Cotation",
          "Order Confirm",
          "Cutting",
          "Banding",
          "Color",
          "Packing",
          "Delivery",
        ],
      ),
    ),
    PlutoColumn(
      title: 'Action',
      field: 'export',
      enableColumnDrag: false,
      backgroundColor: ColorTheme.blueGridColumn,
      minWidth: 165,
      width: 165,
      type: PlutoColumnType.text(),
      readOnly: true,
      enableEditingMode: false,
      renderer: (rendererContext) {
        return Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            IconButton(
                onPressed: () {
                  Get.to(
                    AddOrderScreen(
                        id: rendererContext.row.cells.values.first.value),
                  );
                },
                icon: Icon(Icons.edit),
                color: Colors.blue),
            IconButton(
                onPressed: () async {
                  AddOrderController addOrderController =
                      Get.put(AddOrderController());

                  print(
                      "---->> value  :  ${rendererContext.row.cells.values.first.value} ");
                  await addOrderController.getOrderdata(
                      rendererContext.row.cells.values.first.value);
                  await writeOnPdf();
                  SnackBars.successSnackBar(content: "PDF Created");
                },
                icon: Icon(Icons.picture_as_pdf),
                color: Colors.green),
            IconButton(
                onPressed: () {
                  Get.dialog(
                    AlertDialog(
                      title: Text('Delete Order!!'),
                      contentPadding: EdgeInsets.only(
                          left: 25, right: 40, bottom: 50, top: 20),
                      titleTextStyle: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                          fontSize: 18.sp),
                      content: Text(
                        '●  Are You Sure To Want To Delete Order?',
                        style: TextStyle(color: Colors.red),
                      ),
                      actions: [
                        OutlinedButton(
                          style: OutlinedButton.styleFrom(
                              side: BorderSide(color: Colors.blue),
                              padding: EdgeInsets.symmetric(
                                  vertical: 15, horizontal: 10)),
                          onPressed: () {
                            Get.back();
                          },
                          child: Text('CANCEL'),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        OutlinedButton(
                          style: OutlinedButton.styleFrom(
                              foregroundColor: Colors.red,
                              side: BorderSide(color: Colors.red),
                              padding: EdgeInsets.symmetric(
                                  vertical: 15, horizontal: 10)),
                          onPressed: () async{
                            Get.back();

                            await firebase.deleteOrderData(
                                rendererContext.row.cells.values.first.value);

                          },
                          child: Text(
                            'CONFIRM',
                            style: TextStyle(color: Colors.red),
                          ),
                        ),
                      ],
                    ),
                  );
                },
                icon: Icon(Icons.delete),
                color: Colors.red),
          ],
        );
      },
    ),
  ];

  @override
  void onInit() {
    permissiondata();
    super.onInit();
  }
}
