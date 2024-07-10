import 'package:dio/dio.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get_storage/get_storage.dart';
import 'package:toursandtravels/repo/api.dart';

import '../../../constants/const_colors.dart';
import '../../../constants/global.dart';

class PaymentRepo {
  API api = API();
  GetStorage box = GetStorage();
  Future getBookingPersonDetails() async {
    var bookingId = await box.read('bookingid');
    try {
      Response response = await api.sendRequest.get(
        "bookings/$bookingId/persons/",
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
            toastLength: Toast.LENGTH_SHORT);
        rethrow;
      }
      rethrow;
    }
  }

  Future getAdditionalCharges() async {
    try {
      Response response = await api.sendRequest.get(
        "additional-charges/",
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
            toastLength: Toast.LENGTH_SHORT);
        rethrow;
      }
      rethrow;
    }
  }

  Future getCouponsById(String tourId) async {
    try {
      Response response = await api.sendRequest.get(
        "tour/$tourId/apply-coupon/",
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
            toastLength: Toast.LENGTH_SHORT);
        rethrow;
      }
      rethrow;
    }
  }

  Future getFinalPrice(String tourId, String coupon) async {
    //?coupon_code=sunshine
    try {
      Response response = await api.sendRequest.get(
        "calculate-final-price/$tourId/$coupon",
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
            toastLength: Toast.LENGTH_SHORT);
        rethrow;
      }
      rethrow;
    }
  }
}
