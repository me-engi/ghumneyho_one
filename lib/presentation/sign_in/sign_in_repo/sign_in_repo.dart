import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get_storage/get_storage.dart';
import 'package:toursandtravels/constants/global.dart';

import '../../../constants/const_colors.dart';
import '../../../repo/api.dart';

class SignInRepo {
  API api = API();
  GetStorage box = GetStorage();

  Future<String> signInCall(String userName, String password) async {
    try {
      Response response = await api.sendRequest.post(Global.login,
          data: {"username": userName, "password": password});
      if (response.statusCode == 200) {
        box.write('token', response.data["access"]);

        await box.write('userId', response.data['user_id']);
        log("access token is this ${response.data["access"]} ${response.data['user_id']}");
        return "true";
      }
      return "false";
    } on DioException catch (e) {
      // TODO
      if (e.response!.statusCode! >= 400 && e.response!.statusCode! <= 500) {
        Fluttertoast.showToast(
            msg: e.response!.data.toString(),
            backgroundColor: ConstColors.primaryColor,
            toastLength: Toast.LENGTH_LONG);
        return "false";
      }
      return "false";
    }
  }
}
