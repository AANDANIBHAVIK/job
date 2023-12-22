// // ignore_for_file: prefer_const_constructors
//
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:get/get.dart';
// import 'package:job_letter/utils/color.dart';
// import 'package:job_letter/utils/style.dart';
// import 'package:job_letter/utils/widgets/widget.dart';
// import 'package:job_letter/view/orderDetailScreen/orderDetailController.dart';
//
// class OrderDetailScreen extends StatefulWidget {
//   const OrderDetailScreen({super.key});
//
//   @override
//   State<OrderDetailScreen> createState() => _OrderDetailScreenState();
// }
//
// class _OrderDetailScreenState extends State<OrderDetailScreen> {
//   OrderDetailController controller = Get.put(OrderDetailController());
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         centerTitle: true,
//         automaticallyImplyLeading: false,
//         title: Text("Order Details"),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(8.0),
//         child: SingleChildScrollView(
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.end,
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     "Job No. : 123",
//                     style: ThemeText.textBold17Black,
//                   ),
//                   Spacer(),
//                   Column(
//                     crossAxisAlignment: CrossAxisAlignment.end,
//                     children: [
//                       Row(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Text("Order Date :  ",
//                                 style: ThemeText.textnormalBlack),
//                             Text("${controller.today.day}-${controller.today.month}-${controller.today.year}",
//                                     style: ThemeText.datestyle,
//                                   )
//                           ],
//                         ),
//
//                       SizedBox(
//                         height: 5.h,
//                       ),
//                       Row(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Text("Delivery Date :  ",
//                               style: ThemeText.textnormalBlack),
//                           Text("${controller.today.day}-${controller.today.month}-${controller.today.year}",
//                             style: ThemeText.datestyle,
//                           )
//                         ],
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//               SizedBox(
//                 height: 20.h,
//               ),
//               Align(
//                 alignment: Alignment.centerLeft,
//                 child: Text("Party Name", style: ThemeText.textBoldStyle),
//               ),
//               SizedBox(
//                 height: 5.h,
//               ),
//               TextFormField(
//                 controller: controller.txtname,
//                 textInputAction: TextInputAction.next,
//                 cursorColor: ColorTheme.lightblue,
//                 decoration: InputDecoration(
//                     border: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(6.sp)),
//                     focusedBorder: OutlineInputBorder(
//                       borderSide: BorderSide(color: ColorTheme.lightblue, width: 2.0),
//                     ),
//                     hintText: 'Enter Party Name',
//                     hintStyle: ThemeText.textHintStyle),
//                 // validator: (value) {
//                 //   if (value!.isEmpty) {
//                 //     return 'Please Enter Party Name';
//                 //   }
//                 //   return null;
//                 // },
//               ),
//               SizedBox(
//                 height: 15.h,
//               ),
//               Center(
//                 child: Container(
//                   height: 410.h,
//                   decoration: BoxDecoration(
//                     image: DecorationImage(
//                       fit: BoxFit.cover,
//                       image:  NetworkImage(
//                                   "https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_1280.png")
//
//                     ),
//                   ),
//                 ),
//               ),
//               SizedBox(
//                 height: 20.h,
//               ),
//               Text(
//                 "Channel Letter",
//                 style: ThemeText.textBold17Black,
//               ),
//               SizedBox(
//                 height: 10.h,
//               ),
//               Column(
//                 children: [
//                   SizedBox(
//                     height: 10.h,
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.only(left: 10.0, right: 10),
//                     child: Row(
//                       children: [
//                         SizedBox(
//                           width: 110.w,
//                           child: Text("Side Wall Color",
//                               style: ThemeText.textBoldBlack),
//                         ),
//                         SizedBox(
//                           width: 20.w,
//                         ),
//                         Expanded(
//                             child: customField(
//                                 controller.txtsidewallColor, "Color"))
//                       ],
//                     ),
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.only(left: 10.0, right: 10),
//                     child: Row(
//                       children: [
//                         SizedBox(
//                           width: 110.w,
//                           child: Text("Acrylic Color",
//                               style: ThemeText.textBoldBlack),
//                         ),
//                         SizedBox(
//                           width: 20.w,
//                         ),
//                         Expanded(
//                             child: customField(
//                                 controller.txtacrylicColor, "Color"))
//                       ],
//                     ),
//                   ),
//                   SizedBox(
//                     height: 10.h,
//                   ),
//                   Align(
//                     alignment: Alignment.centerLeft,
//                     child: Text("Strey Detail", style: ThemeText.textBoldStyle),
//                   ),
//                   SizedBox(
//                     height: 5.h,
//                   ),
//                   customField(controller.txtstrey, "Enter Strey Detail"),
//                   Align(
//                     alignment: Alignment.centerLeft,
//                     child: Text("Other Detail", style: ThemeText.textBoldStyle),
//                   ),
//                   SizedBox(
//                     height: 5.h,
//                   ),
//                   customField(
//                       controller.txtchennelotherDetail, "Enter Other Detail"),
//                   Align(
//                     alignment: Alignment.centerLeft,
//                     child: Text("Inch", style: ThemeText.textBoldStyle),
//                   ),
//                   SizedBox(
//                     height: 5.h,
//                   ),
//                   customField(controller.txtchennelinch, "Enter Inch",
//                       type: TextInputType.number),
//                 ],
//               ),
//               SizedBox(
//                 height: 8.h,
//               ),
//               Text(
//                 "SS Latter",
//                 style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold),
//               ),
//               SizedBox(
//                 height: 10.h,
//               ),
//               Padding(
//                 padding: const EdgeInsets.only(left: 10.0, right: 10),
//                 child: Row(
//                   children: [
//                     Text("SS Color", style: ThemeText.textBoldBlack),
//                     SizedBox(
//                       width: 30.w,
//                     ),
//                     Expanded(
//                         child:
//                             customField(controller.txtsidewallColor, "Color"))
//                   ],
//                 ),
//               ),
//               SizedBox(
//                 height: 10.h,
//               ),
//               Align(
//                 alignment: Alignment.centerLeft,
//                 child: Text("Other Detail", style: ThemeText.textBoldStyle),
//               ),
//               SizedBox(
//                 height: 5.h,
//               ),
//               customField(controller.txtssotherDetail, "Enter Other Detail"),
//               Align(
//                 alignment: Alignment.centerLeft,
//                 child: Text("Inch", style: ThemeText.textBoldStyle),
//               ),
//               SizedBox(
//                 height: 5.h,
//               ),
//               customField(controller.txtssinch, "Enter Inch",
//                   type: TextInputType.number),
//               SizedBox(
//                 height: 8.h,
//               ),
//               Text(
//                 "Only Cutting",
//                 style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold),
//               ),
//               SizedBox(
//                 height: 10.h,
//               ),
//               Align(
//                 alignment: Alignment.centerLeft,
//                 child: Text("Cutting Type", style: ThemeText.textBoldStyle),
//               ),
//               SizedBox(
//                 height: 5.h,
//               ),
//               Row(
//                 children: [
//                   Expanded(
//                     child: customField(
//                         controller.txtcuttingtype, "Enter Cutting Type"),
//                   ),
//                   SizedBox(
//                     width: 20.w,
//                   ),
//                    DropdownButton(
//                         underline: SizedBox(),
//                         hint: Text("Select Type"),
//                         icon: Icon(Icons.keyboard_arrow_down),
//                         iconSize: 24,
//                         elevation: 16,
//                         value: "Feet",
//                         borderRadius: BorderRadius.circular(15),
//                         focusColor: Colors.black54,
//                         items: [],
//                         onChanged: (value) {
//                           // setState(() {
//                           //   controller.initialStatus = value;
//                           // });
//                         }),
//
//                 ],
//               ),
//               SizedBox(
//                 height: 8.h,
//               ),
//               Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceAround,
//                   children: [
//                     SizedBox(
//                       width: 80.w,
//                       child: Padding(
//                         padding: const EdgeInsets.only(bottom: 8.0),
//                         child: TextFormField(
//                           controller: controller.txtno1,
//                           cursorColor: ColorTheme.lightblue,
//                           keyboardType: TextInputType.number,
//                           textInputAction: TextInputAction.next,
//                           onChanged: (val){
//                             controller.sum1 = double.parse(controller.txtno1.text);
//                             var sumresult = controller.sum1 * controller.sum2;
//                             controller.result.value = sumresult.toString();
//                           },
//                           decoration: InputDecoration(
//                               border: OutlineInputBorder(
//                                   borderRadius: BorderRadius.circular(6.sp)),
//                               focusedBorder: OutlineInputBorder(
//                                 borderSide:
//                                 BorderSide(color: ColorTheme.lightblue, width: 2.0),
//                               ),
//                               hintText: "XX",
//                               hintStyle: ThemeText.textHintStyle),
//                         ),
//                       ),
//                     ),
//                     Text(
//                       "*",
//                       style:
//                       TextStyle(fontWeight: FontWeight.bold, fontSize: 28.sp),
//                     ),
//                     SizedBox(
//                       width: 80.w,
//                       child: Padding(
//                         padding: const EdgeInsets.only(bottom: 8.0),
//                         child: TextFormField(
//                           controller: controller.txtno2,
//                           cursorColor: ColorTheme.lightblue,
//                           keyboardType: TextInputType.number,
//                           textInputAction: TextInputAction.next,
//
//                           onChanged: (val){
//                             controller.sum2 =  double.parse(controller.txtno2.text);
//                             var sumresult = controller.sum2 * controller.sum1;
//                             controller.result.value = sumresult.toString();
//                           },
//                           decoration: InputDecoration(
//                               border: OutlineInputBorder(
//                                   borderRadius: BorderRadius.circular(6.sp)),
//                               focusedBorder: OutlineInputBorder(
//                                 borderSide:
//                                 BorderSide(color: ColorTheme.lightblue, width: 2.0),
//                               ),
//                               hintText: "XX",
//
//                               hintStyle: ThemeText.textHintStyle),
//                         ),
//                       ),
//                     ),
//                     Text(
//                       "=",
//                       style:
//                       TextStyle(fontWeight: FontWeight.bold, fontSize: 28.sp),
//                     ),
//                     SizedBox(
//                       width: 80.w,
//                       child: Padding(
//                         padding: const EdgeInsets.only(bottom: 8.0),
//                         child: TextFormField(
//                           cursorColor: ColorTheme.lightblue,
//                           controller: controller.txtanswer,
//                           readOnly: true,
//                           textInputAction: TextInputAction.next,
//                           decoration: InputDecoration(
//                               border: OutlineInputBorder(
//                                   borderRadius: BorderRadius.circular(6.sp)),
//                               focusedBorder: OutlineInputBorder(
//                                 borderSide:
//                                 BorderSide(color: ColorTheme.lightblue, width: 2.0),
//                               ),
//                               hintText: controller.result.value,
//                               hintStyle: ThemeText.textBoldBlack),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//
//               SizedBox(
//                 height: 20.h,
//               ),
//               Center(
//                 child: MaterialButton(
//                   onPressed: () {
//
//
//                   },
//                   minWidth: 120.w,
//                   height: 45.h,
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(14.sp),
//                   ),
//                   color: ColorTheme.lightblue,
//                   child: Text(
//                     "Submit",
//                     style: TextStyle(fontSize: 18.sp, color: Colors.white),
//                   ),
//                 ),
//               ),
//               SizedBox(
//                 height: 10.h,
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
