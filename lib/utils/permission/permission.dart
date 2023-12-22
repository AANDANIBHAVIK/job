import 'package:permission_handler/permission_handler.dart';

void permissiondata() async {


  var status = await Permission.storage.status;

  if (!status.isGranted) {
    await Permission.storage.request();
    print("Storage permission is denied.");
  }
}