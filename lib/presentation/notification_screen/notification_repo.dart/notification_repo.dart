import 'package:dio/dio.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:toursandtravels/repo/api.dart';

import '../../../constants/const_colors.dart';
import '../../../constants/global.dart';

class NotificationRepo {
  API api = API();

  Future getNotification() async {
    try {
      Response response = await api.sendRequest.get(
        Global.notification,
        options: Options(
          headers: {
            'Content-Type': 'application/json',
          },
        ),
      );

      return response.data;
    } on DioException catch (e) {
      if (e.response!.statusCode! >= 400 && e.response!.statusCode! <= 500) {
        Fluttertoast.showToast(
            msg: "Something went wrong",
            backgroundColor: ConstColors.primaryColor,
            toastLength: Toast.LENGTH_LONG);
        rethrow;
      }
      rethrow;
    }
  }
}
