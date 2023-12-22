// ignore_for_file: use_build_context_synchronously

import 'package:budget_buddie/Routes/routes.dart';
import 'package:budget_buddie/Screens/MainScreens/MenuScreens/AccountScreen/AddCashAccount/add_cash_account_repository.dart';
import 'package:budget_buddie/Screens/MainScreens/MenuScreens/AccountScreen/account_controller.dart';
import 'package:budget_buddie/Utils/constant.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class AddCashAccountController extends GetxController {
  RxBool isLoading = false.obs;
  RxString imageName = ''.obs;
  RxString imagePath = ''.obs;

  AccountController accountController = Get.put(AccountController());
  TextEditingController addNameController = TextEditingController();
  TextEditingController addValueController = TextEditingController();
  // TextEditingController addImageController = TextEditingController();

  final GlobalKey<FormState> addCashAccountFormKey = GlobalKey<FormState>();

  AddCashAccountRepository addCashAccountRepository =
      AddCashAccountRepository();

  addCashAccount(BuildContext context) async {
    if (addCashAccountFormKey.currentState!.validate() && !isLoading.value) {
      try {
        isLoading.value = true;
        var userInfo = GetStorage().read(GetStorageKey.USER_INFO) as Map;
        debugPrint('USER INFO :: $userInfo');

        var response = await addCashAccountRepository.addCashAccount({
          "userUuid": userInfo["userUuid"].toString(),
          "accountName": addNameController.text,
          "value": addValueController.text,
          "avatar": imageName.value,
        });

        if (response.code == 1) {
    await    accountController.getAccountList(isLoaderShow: false);
          Navigator.pop(context);
          // SnackBars.successSnackBar(content: response.message!);
        }
      } catch (e) {
        debugPrint("::::::::::$e::::::::::");
        // rethrow;
      } finally {
        isLoading.value = false;
      }
    }
  }

  updateCashAccount(BuildContext context, String id, String routesName) async {
    if (addCashAccountFormKey.currentState!.validate() && !isLoading.value) {
      // TODO: INCOME ADD
      try {
        isLoading.value = true;
        var userInfo = GetStorage().read(GetStorageKey.USER_INFO) as Map;
        debugPrint('USER INFO :: $userInfo');

        var response = await addCashAccountRepository.updateCashAccount({
          "userUuid": userInfo["userUuid"].toString(),
          "accountUuid": id,
          "accountName": addNameController.text,
          "value": addValueController.text,
          "avatar": imageName.value,
        });
        if (response.code == 1) {
       await accountController.getAccountList(isLoaderShow: false);
          Navigator.of(context).popUntil((route) {
            return route.settings.name == routesName;
          });
          // Navigator.pop(context);
          // SnackBars.successSnackBar(content: response.message!);
        }
      } catch (e) {
        debugPrint("::::::::::$e::::::::::");
        // rethrow;
      } finally {
        isLoading.value = false;
      }
    }
  }

  Future<void> deleteCashAccount(BuildContext context, String id) async {
    if (!isLoading.value) {
      try {
        isLoading.value = true;
        var userInfo = GetStorage().read(GetStorageKey.USER_INFO) as Map;
        debugPrint('USER INFO :: $userInfo');

        var response = await addCashAccountRepository
            .deleteCashAccount('${userInfo["userUuid"].toString()}/$id');
        if (response.code == 1) {
        await accountController.getAccountList(isLoaderShow: false);
          Navigator.of(context).popUntil((route) {
            return route.settings.name == Routes.accountScreen;
          });
          // SnackBars.successSnackBar(content: response.message!);
        }
      } catch (e) {
        debugPrint("::::::::::$e::::::::::");

        // rethrow;
      } finally {
        isLoading.value = false;
      }
    }
  }

  clearCashAccountFields() {
    addNameController.clear();
    addValueController.clear();
    imageName.value = "";
  }
}
