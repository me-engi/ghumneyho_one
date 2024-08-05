import 'package:dio/dio.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:get_storage/get_storage.dart';
import 'package:toursandtravels/comment/comment_model.dart';
import 'package:toursandtravels/constants/const_colors.dart';
import 'package:toursandtravels/constants/global.dart';
import 'package:toursandtravels/repo/api.dart';

class CommentRepo{

  API api = API();
  GetStorage box = GetStorage();

  Future getcommnetsTour() async {
    try {
      Response response = await api.sendRequest.get(
        Global.getcomments,
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

Future postcommentTour({
  required String tourId,
  // required int id,
  required String user,
  required int userId,
  required String tourName,
  int? rating,
  String? comment
}) async {
  String accessToken = box.read('token');
  Map<String, dynamic> commentData = {
    // "id": id,
    "user": user,
    "user_id": userId,
    "tour_id": int.parse(tourId),
    "tour_name": tourName,
    "rating": rating,
    "comment": comment,
  };

  try {
    Response response = await api.sendRequest.post(
      '${Global.postcomments}$tourId/',
      data: commentData,
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
    if (e.response != null && e.response!.statusCode! >= 400 && e.response!.statusCode! <= 500) {
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

