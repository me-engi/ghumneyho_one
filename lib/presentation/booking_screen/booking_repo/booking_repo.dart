import 'dart:io';

import 'package:dio/dio.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get_storage/get_storage.dart';

import '../../../constants/const_colors.dart';
import '../../../constants/global.dart';
import '../../../repo/api.dart';

class BookingRepo {
  API api = API();
  GetStorage box = GetStorage();
  Future bookingPersonDetails(
      String tourID,
      String passengerNumber,
      String name,
      String phone,
      String email,
      String idProofType,
      File idProofFile,
      File photoFile,
      String age,
      String gender) async {
    String bookingId = box.read('bookingid').toString();
    FormData formData = FormData();

    if (await photoFile.exists()) {
      formData.files.add(MapEntry(
        'photo',
        await MultipartFile.fromFile(photoFile.path,
            filename: photoFile.path.split('/').last),
      ));
    }

    if (await idProofFile.exists()) {
      formData.files.add(MapEntry(
        'id_proof_upload',
        await MultipartFile.fromFile(idProofFile.path,
            filename: idProofFile.path.split('/').last),
      ));
    }
    print("id prrof path is this ${idProofFile.path}");

    formData.fields.addAll([
      MapEntry("traveler_name", name),
      MapEntry("phone_number", phone),
      MapEntry("email", email),
      MapEntry("id_proof_type", idProofType.toLowerCase()),
      MapEntry("age", age),
      MapEntry("gender", gender),
      const MapEntry("address", "India"),
    ]);

    try {
      Response response = await api.sendRequest.post(
        "${Global.bookingTour}$bookingId${Global.bookingPerson}$passengerNumber/",
        data: formData, // Pass the formData directly
        options: Options(
          headers: {
            'Content-Type': "multipart/form-data",
          },
        ),
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        final dynamic responseData = response.data;
        Fluttertoast.showToast(
            msg: "Passenger $passengerNumber details uploaded successfully",
            backgroundColor: ConstColors.primaryColor,
            toastLength: Toast.LENGTH_LONG);

        return responseData;
      }
    } on DioException catch (e) {
      if (e.response!.statusCode! >= 400 || e.response!.statusCode! <= 500) {
        Fluttertoast.showToast(
            msg: e.response!.data,
            backgroundColor: ConstColors.primaryColor,
            toastLength: Toast.LENGTH_SHORT);
        return -1;
      }
      return 0;
    }
  }
}
