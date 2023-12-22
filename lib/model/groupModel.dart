// class GroupModel {
//   List<GroupChat>? groupChat;
//
//   GroupModel({this.groupChat});
//
//   GroupModel.fromJson(Map<String, dynamic> json) {
//     if (json['groupChat'] != null) {
//       groupChat = <GroupChat>[];
//       json['groupChat'].forEach((v) {
//         groupChat!.add(new GroupChat.fromJson(v));
//       });
//     }
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     if (this.groupChat != null) {
//       data['groupChat'] = this.groupChat!.map((v) => v.toJson()).toList();
//     }
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