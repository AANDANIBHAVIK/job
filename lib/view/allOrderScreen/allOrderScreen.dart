// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:quick_notify/quick_notify.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:job_letter/firebase/firebase.dart';
import 'package:job_letter/main.dart';
import 'package:job_letter/model/newOrderModel.dart';
import 'package:job_letter/utils/string.dart';
import 'package:job_letter/utils/style.dart';
import 'package:job_letter/utils/widgets/customFooter.dart';
import 'package:job_letter/view/addOrderScreen/addOrderController.dart';
import 'package:job_letter/view/addOrderScreen/addOrderScreen.dart';
import 'package:job_letter/view/allOrderScreen/allOrderController.dart';
import 'package:job_letter/routes.dart';
import 'package:pluto_grid/pluto_grid.dart';

import '../../utils/widgets/customSnackbar.dart';

class AllOrderScreen extends StatefulWidget {
  const AllOrderScreen({super.key});

  @override
  State<AllOrderScreen> createState() => _AllOrderScreenState();
}

class _AllOrderScreenState extends State<AllOrderScreen> {
  AllOrderController controller = Get.put(AllOrderController());
  AddOrderController addOrderController = Get.put(AddOrderController());

  @override
  void initState() {
    super.initState();

    FirebaseMessaging.instance
        .getInitialMessage()
        .then((RemoteMessage? message) async {
      RemoteNotification? notification = message?.notification!;

      print(notification != null ? notification.title : '');
    });

    FirebaseMessaging.onMessage.listen((message) async {
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;

      if (notification != null && android != null && !kIsWeb) {
        String action = jsonEncode(message.data);

        flutterLocalNotificationsPlugin!.show(
            notification.hashCode,
            notification.title,
            notification.body,
            NotificationDetails(
              android: AndroidNotificationDetails(
                channel!.id,
                channel!.name,
                priority: Priority.high,
                importance: Importance.max,
                setAsGroupSummary: true,
                styleInformation: DefaultStyleInformation(true, true),
                largeIcon: DrawableResourceAndroidBitmap('@drawable/icon'),
                channelShowBadge: true,
                autoCancel: true,
              ),
            ),
            payload: action);
      }
      print('A new event was published!');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text("${box.read(GetString.email)}"),
        actions: [
          Center(
            child: OutlinedButton(
              style: OutlinedButton.styleFrom(
                side: BorderSide(color: Colors.white),
              ),
              onPressed: () {
                Get.to(AddOrderScreen());
              },
              child: Text(
                "Add Order",
                style: TextStyle(fontFamily: 'Helvetica', color: Colors.white),
              ),
            ),
          ),
          PopupMenuButton<int>(
            onSelected: (value) {
              if (value == 1) {
                Get.toNamed(AppPages.adduser);
              } else if (value == 2) {
                Get.toNamed(AppPages.setting);
              } else if (value == 3) {
                Get.offAllNamed(AppPages.login);
                box.remove(GetString.email);
                box.remove(GetString.type);
                box.remove(GetString.storagepath);
              }
            },
            itemBuilder: (context) => [
              if (box.read(GetString.type) == true)
                PopupMenuItem(
                  value: 1,
                  child: Row(
                    children: [
                      Icon(
                        Icons.add,
                        color: Colors.black,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text("Add User")
                    ],
                  ),
                ),
              if (Platform.isWindows)
                PopupMenuItem(
                  value: 2,
                  child: Row(
                    children: [
                      Icon(
                        Icons.settings,
                        color: Colors.black,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        "Setting",
                      )
                    ],
                  ),
                ),
              PopupMenuItem(
                value: 3,
                child: Row(
                  children: [
                    Icon(
                      Icons.logout,
                      color: Colors.red,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      "LogOut",
                      style: TextStyle(
                          color: Colors.red, fontWeight: FontWeight.w600),
                    )
                  ],
                ),
              ),
            ],
            offset: Offset(0, 50),
            elevation: 2,
          ),
        ],
      ),
      body: Column(
        children: [
          // Container(
          //   height: 70.h,
          //   decoration: BoxDecoration(
          //     color: ColorTheme.lightblue,
          //
          //     borderRadius: BorderRadius.only(
          //
          //       bottomLeft: Radius.circular(25),
          //       bottomRight: Radius.circular(25),
          //     ),
          //   ),
          //   child: Padding(
          //     padding: const EdgeInsets.all(10.0),
          //     child: Column(
          //       crossAxisAlignment: CrossAxisAlignment.start,
          //       mainAxisAlignment: MainAxisAlignment.center,
          //       children: [
          //         Row(
          //           children: [
          //             Text(
          //               "${box.read(GetString.email)}",
          //               style: ThemeText.textBold18White,
          //             ),
          //           ],
          //         )
          //       ],
          //     ),
          //   ),
          // ),
          Expanded(
            child: StreamBuilder(
              stream: firebase.readOrderdata(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  Text("Error : ${snapshot.error}");
                } else if (snapshot.hasData) {
                  var docList = snapshot.data ?? [];
                  controller.modelDataList.clear();
                  List<NewOrderModel> orderModelList = [];

                  for (var i in docList) {
                    orderModelList.add(NewOrderModel.fromJson(i.map));
                  }
                  orderModelList.sort(
                    (a, b) {
                      return b.jobNo!.compareTo(a.jobNo!);
                    },
                  );
                  controller.modelDataList.addAll(orderModelList);
                  if (controller.stateManager != null) {
                    controller.orderRowData.value = [];
                    controller.stateManager!.removeAllRows();
                    for (var i in controller.modelDataList) {
                      if (i.status?.oldStatus != i.status?.orderStatus) {
                        if (Platform.isWindows) {
                          QuickNotify.notify(
                            title: 'Order : ${i.jobNo}',
                            content:
                                'Status : ${i.status!.oldStatus} To ${i.status!.orderStatus}',
                          );
                        } else if (Platform.isAndroid) {
                          Timer(Duration(milliseconds: 1500), () {
                            SnackBars.successSnackBar(
                                content:
                                    "Order : ${i.jobNo} is Going to ${i.status!.oldStatus} ==> ${i.status!.orderStatus}");
                          });
                        }
                      }
                      controller.orderRowData.add(
                        PlutoRow(
                          cells: {
                            'id': PlutoCell(value: i.jobNo),
                            'name': PlutoCell(value: i.partyName),
                            'order Date': PlutoCell(value: i.orderDate),
                            'delivery Date': PlutoCell(value: i.deliveryDate),
                            'status': PlutoCell(value: i.status!.orderStatus),
                            'export': PlutoCell(value: ""),
                          },
                        ),
                      );
                    }
                    controller.stateManager!
                        .insertRows(0, controller.orderRowData);
                  } else {
                    for (var i in controller.modelDataList) {
                      controller.orderData.add(
                        PlutoRow(
                          cells: {
                            'id': PlutoCell(value: i.jobNo),
                            'name': PlutoCell(value: i.partyName),
                            'order Date': PlutoCell(value: i.orderDate),
                            'delivery Date': PlutoCell(value: i.deliveryDate),
                            'status': PlutoCell(value: i.status!.orderStatus),
                            'export': PlutoCell(value: ""),
                          },
                        ),
                      );
                    }
                  }

                  controller.orders = controller.modelDataList;

                  // orderDataSource =
                  //     OrderDataSource(orderModelData: orders, cells: {});
                  return controller.modelDataList.isEmpty
                      ? Center(
                          child: Text(
                          "No Order Found!",
                          style: ThemeText.textBold17Black,
                        ))
                      : Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: PlutoGrid(
                            columns: controller.columns,
                            rows: controller.orderData,
                            createFooter: (event) {
                              event.setPageSize(10, notify: true);
                              event.addListener(() {
                                controller.curIndex.value = event.page;
                              });
                              return CustomPlutoPagination(
                                event,
                                pageSizeToMove: 1,
                              );
                            },
                            onLoaded: (PlutoGridOnLoadedEvent event) {
                              controller.stateManager = event.stateManager;
                              event.stateManager.setShowColumnFilter(true);
                            },
                            onChanged: (PlutoGridOnChangedEvent event) {
                              firebase.updateStatus(
                                  context,
                                  event.row.cells.values.first.value,
                                  event.value,
                                  event.oldValue);

                              Timer(Duration(seconds: 3), () {
                                firebase.updateStatus(
                                    context,
                                    event.row.cells.values.first.value,
                                    event.value,
                                    event.value);
                                print("@<--->@");
                              });
                            },
                            configuration: PlutoGridConfiguration(
                              columnSize: PlutoGridColumnSizeConfig(
                                autoSizeMode: PlutoAutoSizeMode.scale,
                              ),
                              columnFilter: PlutoGridColumnFilterConfig(),
                              style: PlutoGridStyleConfig(
                                  oddRowColor: Color(0xffe9f5fe),
                                  gridBorderRadius: BorderRadius.circular(10),
                                  gridBorderColor: Colors.transparent),
                            ),
                          ),
                        );
                }
                return Center(child: CircularProgressIndicator());
              },
            ),
          ),
        ],
      ),
    );
  }
}

// class OrderDataSource extends PlutoRow {
//   List<PlutoRow> orderData = [];
//
//   OrderDataSource(
//       {required List<OrderModel> orderModelData, required super.cells}) {
//     orderData = orderModelData
//         .map<PlutoRow>(
//           (item) => PlutoRow(
//             cells: {
//               'id': PlutoCell(value: item.jobNo),
//               'name': PlutoCell(value: item.partyName),
//               'order Date': PlutoCell(value: item.orderdate),
//               'delivery Date': PlutoCell(value: item.delhiverydate),
//               'status': PlutoCell(value: item.jobNo),
//             },
//           ),
//         )
//         .toList();
//   }
// }
