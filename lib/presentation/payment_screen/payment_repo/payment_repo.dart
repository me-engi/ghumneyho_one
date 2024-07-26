import 'package:dio/dio.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get_storage/get_storage.dart';
import 'package:toursandtravels/constants/const_colors.dart';
import 'package:toursandtravels/presentation/payment_screen/payment_model.dart';
import 'package:toursandtravels/repo/api.dart';

class PaymentRepo {
  final API _api = API();
  final GetStorage _box = GetStorage();

  Future getBookingPersonDetails() async {
    var bookingId = await _box.read('bookingid');
    try {
      Response response = await _api.sendRequest.get(
        "bookings/$bookingId/persons/",
        options: Options(
          headers: {
            'Content-Type': 'application/json',
          },
        ),
      );
      return response.data;
    } on DioException catch (e) {
      _handleError(e);
      rethrow;
    }
  }

  Future getAdditionalCharges() async {
    try {
      Response response = await _api.sendRequest.get(
        "additional-charges/",
        options: Options(
          headers: {
            'Content-Type': 'application/json',
          },
        ),
      );
      return response.data;
    } on DioException catch (e) {
      _handleError(e);
      rethrow;
    }
  }

  Future getCouponsById(String tourId) async {
    try {
      Response response = await _api.sendRequest.get(
        "tour/$tourId/apply-coupon/",
        options: Options(
          headers: {
            'Content-Type': 'application/json',
          },
        ),
      );
      return response.data;
    } on DioException catch (e) {
      _handleError(e);
      rethrow;
    }
  }

  Future<Finalpayment> getFinalPrice(String tourId, {String? coupon}) async {
    try {
      String endpoint = "calculate-final-price/$tourId/";
      if (coupon != null && coupon.isNotEmpty) {
        endpoint += "?coupon_code=$coupon";
      }

      final response = await _api.sendRequest.get(
        endpoint,
        options: Options(
          headers: {
            'Content-Type': 'application/json',
          },
        ),
      );

      return Finalpayment.fromJson(response.data);
    } on DioException catch (e) {
      _handleError(e);
      rethrow;
    }
  }

  void _handleError(DioException e) {
    if (e.response != null && e.response!.statusCode != null && e.response!.statusCode! >= 400 && e.response!.statusCode! <= 500) {
      Fluttertoast.showToast(
        msg: "Something went wrong",
        backgroundColor: ConstColors.primaryColor,
        toastLength: Toast.LENGTH_SHORT,
      );
    }
  }
}
