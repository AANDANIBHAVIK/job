// class New {
//   ChannelLatter? channelLatter;
//   String? deliveryDate;
//   String? email;
//   List<GroupChat>? groupChat;
//   String? image;
//   String? itemTypeValue;
//   int? jobNo;
//   OnlyCutting? onlyCutting;
//   String? orderDate;
//   String? partyName;
//   String? paymentStatus;
//   SsLatter? ssLatter;
//   Status? status;
//
//   New(
//       {this.channelLatter,
//         this.deliveryDate,
//         this.email,
//         this.groupChat,
//         this.image,
//         this.itemTypeValue,
//         this.jobNo,
//         this.onlyCutting,
//         this.orderDate,
//         this.partyName,
//         this.paymentStatus,
//         this.ssLatter,
//         this.status});
//
//   New.fromJson(Map<String, dynamic> json) {
//     channelLatter = json['channelLatter'] != null
//         ? new ChannelLatter.fromJson(json['channelLatter'])
//         : null;
//     deliveryDate = json['deliveryDate'];
//     email = json['email'];
//     if (json['groupChat'] != null) {
//       groupChat = <GroupChat>[];
//       json['groupChat'].forEach((v) {
//         groupChat!.add(new GroupChat.fromJson(v));
//       });
//     }
//     image = json['image'];
//     itemTypeValue = json['itemTypeValue'];
//     jobNo = json['jobNo'];
//     onlyCutting = json['onlyCutting'] != null
//         ? new OnlyCutting.fromJson(json['onlyCutting'])
//         : null;
//     orderDate = json['orderDate'];
//     partyName = json['partyName'];
//     paymentStatus = json['paymentStatus'];
//     ssLatter = json['ssLatter'] != null
//         ? new SsLatter.fromJson(json['ssLatter'])
//         : null;
//     status =
//     json['status'] != null ? new Status.fromJson(json['status']) : null;
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     if (this.channelLatter != null) {
//       data['channelLatter'] = this.channelLatter!.toJson();
//     }
//     data['deliveryDate'] = this.deliveryDate;
//     data['email'] = this.email;
//     if (this.groupChat != null) {
//       data['groupChat'] = this.groupChat!.map((v) => v.toJson()).toList();
//     }
//     data['image'] = this.image;
//     data['itemTypeValue'] = this.itemTypeValue;
//     data['jobNo'] = this.jobNo;
//     if (this.onlyCutting != null) {
//       data['onlyCutting'] = this.onlyCutting!.toJson();
//     }
//     data['orderDate'] = this.orderDate;
//     data['partyName'] = this.partyName;
//     data['paymentStatus'] = this.paymentStatus;
//     if (this.ssLatter != null) {
//       data['ssLatter'] = this.ssLatter!.toJson();
//     }
//     if (this.status != null) {
//       data['status'] = this.status!.toJson();
//     }
//     return data;
//   }
// }
//
// class ChannelLatter {
//   String? channelInch;
//   String? channelOtherdetail;
//   String? colorSideWall;
//   String? coloracreyLic;
//   String? streyDetail;
//
//   ChannelLatter(
//       {this.channelInch,
//         this.channelOtherdetail,
//         this.colorSideWall,
//         this.coloracreyLic,
//         this.streyDetail});
//
//   ChannelLatter.fromJson(Map<String, dynamic> json) {
//     channelInch = json['channelInch'];
//     channelOtherdetail = json['channelOtherdetail'];
//     colorSideWall = json['colorSideWall'];
//     coloracreyLic = json['coloracreyLic'];
//     streyDetail = json['streyDetail'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['channelInch'] = this.channelInch;
//     data['channelOtherdetail'] = this.channelOtherdetail;
//     data['colorSideWall'] = this.colorSideWall;
//     data['coloracreyLic'] = this.coloracreyLic;
//     data['streyDetail'] = this.streyDetail;
//     return data;
//   }
// }
//
// class GroupChat {
//   String? email;
//   String? textMsg;
//   String? timeStamp;
//
//   GroupChat({this.email, this.textMsg, this.timeStamp});
//
//   GroupChat.fromJson(Map<String, dynamic> json) {
//     email = json['email'];
//     textMsg = json['textMsg'];
//     timeStamp = json['timeStamp'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['email'] = this.email;
//     data['textMsg'] = this.textMsg;
//     data['timeStamp'] = this.timeStamp;
//     return data;
//   }
// }
//
// class OnlyCutting {
//   String? cuttingType;
//   String? cuttingTypeName;
//   String? total;
//   String? typeNumOne;
//   String? typeNumTwo;
//
//   OnlyCutting(
//       {this.cuttingType,
//         this.cuttingTypeName,
//         this.total,
//         this.typeNumOne,
//         this.typeNumTwo});
//
//   OnlyCutting.fromJson(Map<String, dynamic> json) {
//     cuttingType = json['cuttingType'];
//     cuttingTypeName = json['cuttingTypeName'];
//     total = json['total'];
//     typeNumOne = json['typeNumOne'];
//     typeNumTwo = json['typeNumTwo'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['cuttingType'] = this.cuttingType;
//     data['cuttingTypeName'] = this.cuttingTypeName;
//     data['total'] = this.total;
//     data['typeNumOne'] = this.typeNumOne;
//     data['typeNumTwo'] = this.typeNumTwo;
//     return data;
//   }
// }
//
// class SsLatter {
//   String? colorSS;
//   String? ssInch;
//   String? ssOtherDetail;
//
//   SsLatter({this.colorSS, this.ssInch, this.ssOtherDetail});
//
//   SsLatter.fromJson(Map<String, dynamic> json) {
//     colorSS = json['colorSS'];
//     ssInch = json['ssInch'];
//     ssOtherDetail = json['ssOtherDetail'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['colorSS'] = this.colorSS;
//     data['ssInch'] = this.ssInch;
//     data['ssOtherDetail'] = this.ssOtherDetail;
//     return data;
//   }
// }
//
// class Status {
//   String? oldStatus;
//   String? orderStatus;
//
//   Status({this.oldStatus, this.orderStatus});
//
//   Status.fromJson(Map<String, dynamic> json) {
//     oldStatus = json['oldStatus'];
//     orderStatus = json['orderStatus'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['oldStatus'] = this.oldStatus;
//     data['orderStatus'] = this.orderStatus;
//     return data;
//   }
// }
