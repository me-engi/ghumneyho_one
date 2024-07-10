import 'package:dio/dio.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get_storage/get_storage.dart';
import 'package:toursandtravels/presentation/home_page/Model/get_popular_model.dart';

import '../../../constants/const_colors.dart';
import '../../../constants/global.dart';
import '../../../repo/api.dart';
import '../Model/get_trainding_model.dart';

class HomeRepo {
  API api = API();
  GetStorage box = GetStorage();

  //getPopularApi Call
  Future getPopular() async {
    try {
      Response response = await api.sendRequest.get(
        Global.popularTours,
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

  Future getTrainding() async {
    try {
      Response response = await api.sendRequest.get(
        Global.trendingTours,
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

  Future getTours() async {
    try {
      Response response = await api.sendRequest.get(
        Global.searchApi,
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

  Future getLikedTours() async {
    String accessToken = box.read('token');
    try {
      Response response = await api.sendRequest.get(
        Global.getFavTours,
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $accessToken'
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

  Future likeTour(String tourId) async {
    String accessToken = box.read('token');
    try {
      Response response = await api.sendRequest.post(
        '${Global.likeTour}$tourId/',
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $accessToken'
          },
        ),
      );
      Fluttertoast.showToast(
          msg: response.data['message'],
          backgroundColor: ConstColors.primaryColor,
          toastLength: Toast.LENGTH_LONG);

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

  Future dislikeTour(String tourId) async {
    String accessToken = box.read('token');
    try {
      Response response = await api.sendRequest.delete(
        '${Global.dislikeTour}$tourId/',
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $accessToken'
          },
        ),
      );
      Fluttertoast.showToast(
          msg: response.data['message'],
          backgroundColor: ConstColors.primaryColor,
          toastLength: Toast.LENGTH_LONG);

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
