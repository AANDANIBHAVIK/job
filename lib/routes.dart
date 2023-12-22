import 'package:get/get.dart';
import 'package:job_letter/view/addOrderScreen/addOrderScreen.dart';
import 'package:job_letter/view/addUserScreen/addUserScreen.dart';
import 'package:job_letter/view/loginScreen/loginScreen.dart';
import 'package:job_letter/view/allOrderScreen/allOrderScreen.dart';
import 'package:job_letter/view/settingScreen/settingScreen.dart';
import 'package:job_letter/view/splashScreen/splashScreen.dart';

class AppPages{
  AppPages._();

  static String splash = '/';
  static String login = '/login';
  static String allorder = '/allorder';
  static String adduser = '/adduser';
  static String addorder = '/addorder';
  static String setting = '/setting';

  static final routes = [
    GetPage(name: splash, page: () => const SplashScreen(),),
    GetPage(name: login, page: () => const LoginScreen(),),
    GetPage(name: allorder, page: () => const AllOrderScreen(),),
    GetPage(name: addorder, page: () => const AddOrderScreen(id: 14),),
    GetPage(name: adduser, page: () => const AddUserScreen(),),
    GetPage(name: setting, page: () => const SettingScreen(),),
  ];
}