import 'package:budget_buddie/Data/Api/api_constants.dart';
import 'package:budget_buddie/Data/Api/api_manager.dart';
import 'package:budget_buddie/Data/Models/common_msg_model.dart';

class AddCashAccountRepository {
  ApiManager apiManager = ApiManager();

  // Asset

  Future<CommonMsgModel> addCashAccount(Map<String, String> parameters) async {
    try {
      var response = await apiManager.post(APIConstants.addCashAccount, parameters,isLoaderShow: false);
      var responseMap = CommonMsgModel.fromJson(response);
      return responseMap;
    } catch (e) {
      rethrow;
    }
  }

  Future<CommonMsgModel> updateCashAccount(Map<String, String> parameters) async {
    try {
      var response = await apiManager.put(APIConstants.updateCashAccount, parameters,isLoaderShow: false);
      var responseMap = CommonMsgModel.fromJson(response);
      return responseMap;
    } catch (e) {
      rethrow;
    }
  }

  Future<CommonMsgModel> deleteCashAccount(String id) async {
    try {
      var response = await apiManager.delete(APIConstants.deleteCashAccount + id,isLoaderShow: false);
      var responseMap = CommonMsgModel.fromJson(response);
      return responseMap;
    } catch (e) {
      rethrow;
    }
  }

}