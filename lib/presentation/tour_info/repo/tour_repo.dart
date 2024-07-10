import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get_storage/get_storage.dart';
import 'package:toursandtravels/presentation/tour_info/models/datetimemodel.dart';
import '../../../constants/const_colors.dart';
import '../../../constants/global.dart';
import '../../../repo/api.dart';
import '../tour_model/tour_by_id_mode.dart';

class GetToursByIdRepo {
  API api = API();
  GetStorage box = GetStorage();
  //getCourseApi Call
  Future<ToursById> getToursByIdInfo(String tourID) async {
    try {
      Response response = await api.sendRequest.get(
        "${Global.toursById}$tourID",
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            // 'Authorization': "Bearer $authtoken",
          },
        ),
        // queryParameters: {'course_id': courseId}
      );

      return ToursById.fromJson(response.data);
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

  Future<List<DateTimeModel>> getToursAvalibility(String tourID) async {
    try {
      Response response = await api.sendRequest.get(
        "${Global.searchApi}$tourID${Global.tourAvalability}",
        options: Options(
          headers: {
            'Content-Type': 'application/json',
          },
        ),
      );
      List<dynamic> data = response.data;
      List<DateTimeModel> model =
          data.map((e) => DateTimeModel.fromJson(e)).toList();
      log("1st availibity data is this $data");
      return model;
    } on DioException catch (e, stackTrace) {
      if (e.response!.statusCode! >= 400 && e.response!.statusCode! <= 500) {
        Fluttertoast.showToast(
            msg: "Something went wrong",
            backgroundColor: ConstColors.primaryColor,
            toastLength: Toast.LENGTH_LONG);
        rethrow;
      }
      log("1st availibity data is this error $stackTrace");
      rethrow;
    }
  }

  Future<String> bookingTourDetails(
      int totalPassenger, int userId, int tourId, int tourAvalabilityid) async {
    try {
      Response response = await api.sendRequest.post(Global.bookingTour, data: {
        "total_travelers": totalPassenger,
        "user": userId,
        "tour": tourId,
        "tour_availability": tourAvalabilityid,
      });
      if (response.statusCode == 201 || response.statusCode == 200) {
        box.write("bookingid", response.data["id"]);
        return "true";
      }
      return "false";
    } on DioException catch (e) {
      // TODO
      if (e.response!.statusCode! >= 400 && e.response!.statusCode! <= 500) {
        Fluttertoast.showToast(
            msg: "somthing went wrong",
            backgroundColor: ConstColors.primaryColor,
            toastLength: Toast.LENGTH_LONG);
        return "false";
      }
      return "false";
    }
  }
}
