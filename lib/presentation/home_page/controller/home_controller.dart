import 'dart:developer';

import 'package:carousel_slider/carousel_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:omni_datetime_picker/omni_datetime_picker.dart';
import 'package:toursandtravels/presentation/home_page/Model/get_trainding_model.dart';
import 'package:toursandtravels/presentation/home_page/home_repo/home_Repo.dart';

import '../Model/get_popular_model.dart';

class HomeController extends GetxController {
  Rx<TextEditingController> searchText = TextEditingController().obs;
  Rx<TextEditingController> myController3 = TextEditingController().obs;
  Rx<TextEditingController> count = TextEditingController().obs;

  RxBool isLoading = false.obs;
  RxBool isLoadingFav = false.obs;
  RxBool isLoading1 = false.obs;
  var number = 0.obs;
  HomeRepo homeRepo = HomeRepo();
  List? popularList;
  List? traindingModel;
  List favListTours = [];
  List? toursList;
  List searchlist = [];
  List<DateTime>? datepick = [];

  void add_count_to_item() {
    number += 1;
  }

  void minus_count_to_item() {
    if (number > 0) {
      number -= 1;
    }
  }

  getFavData() async {
    isLoadingFav.value = true;
    try {
      favListTours = await homeRepo.getLikedTours();
      log('image url is this ${favListTours}');
    } on Exception catch (e) {
      rethrow;
      // TODO
    } finally {
      isLoadingFav.value = false;
    }
  }

  getFavDataRecall() async {
    try {
      favListTours = await homeRepo.getLikedTours();
      log('image url is this ${favListTours}');
    } on Exception catch (e) {
      rethrow;
    }
  }

  date(BuildContext context) async {
    datepick = await showOmniDateTimeRangePicker(
      context: context,
      startInitialDate: DateTime.now(),
      startFirstDate: DateTime(1600).subtract(const Duration(days: 3652)),
      startLastDate: DateTime.now().add(
        const Duration(days: 3652),
      ),
      endInitialDate: DateTime.now(),
      endFirstDate: DateTime(1600).subtract(const Duration(days: 3652)),
      endLastDate: DateTime.now().add(
        const Duration(days: 3652),
      ),
      is24HourMode: false,
      isShowSeconds: false,
      minutesInterval: 1,
      secondsInterval: 1,
      borderRadius: const BorderRadius.all(Radius.circular(16)),
      constraints: const BoxConstraints(
        maxWidth: 350,
        maxHeight: 650,
      ),
      transitionBuilder: (context, anim1, anim2, child) {
        return FadeTransition(
          opacity: anim1.drive(
            Tween(
              begin: 0,
              end: 1,
            ),
          ),
          child: child,
        );
      },
      transitionDuration: const Duration(milliseconds: 200),
      barrierDismissible: true,
      endSelectableDayPredicate: (dateTime) {
        // Disable 25th Feb 2023
        if (dateTime == DateTime(2023, 2, 25)) {
          return false;
        } else {
          return true;
        }
      },
    );
    log("datepickdatepickdatepickdatepick $datepick");
    return datepick;
  }
  // getPopularApiCall() async {
  //   isLoading.value = true;
  //   try {
  //     popularList = await homeRepo.getPopular();
  //   } catch (e) {
  //     isLoading.value = false;
  //     print('error');
  //   } finally {
  //     isLoading.value = false;
  //     print('error1');
  //   }
  // }

  getTrendingApiCall() async {
    isLoading1.value = true;
    try {
      popularList = await homeRepo.getPopular();
      traindingModel = await homeRepo.getTrainding();
    } catch (e) {
      isLoading1.value = false;
      print('error $e');
    } finally {
      isLoading1.value = false;
      print('done');
    }
  }

  getToursApiCall() async {
    try {
      toursList = await homeRepo.getTours();
      for (int i = 0; i < toursList!.length; i++) {
        log("testList?[i][name] ${toursList?[i]["name"]}");
        searchlist.add(
            "${toursList?[i]["name"]}, ${toursList?[i]["country"]} .${toursList?[i]["id"]}");
        log("listttttt $searchlist");
      }
    } catch (e) {
      print('error $e');
    }
  }

  getintialapicall() async {
    await getTrendingApiCall();
    await getToursApiCall();
  }

  // mocking a future that returns List of Objects
  Future<List?> fetchComplexData() async {
    await Future.delayed(const Duration(milliseconds: 1000));

    // create a list from the text input of three items
    // to mock a list of items from an http call where
    // the label is what is seen in the textfield and something like an
    // ID is the selected value
    searchlist?.add(toursList?[0]["name"]);

    return searchlist;
  }

  @override
  void onInit() {
    getintialapicall();
    super.onInit();
  }

  @override
  void onReady() {
    getFavData();
    super.onReady();
  }

  @override
  void onClose() {
    myController3.close();
    super.onClose();
  }
}