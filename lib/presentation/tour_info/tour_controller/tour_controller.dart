import 'dart:developer';
import 'dart:io';

import 'package:currency_converter/currency.dart';
import 'package:currency_converter/currency_converter.dart';
import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';
import 'package:get_storage/get_storage.dart';
import 'package:toursandtravels/presentation/tour_info/tour_model/tour_by_id_mode.dart';

import '../models/datetimemodel.dart';
import '../repo/tour_repo.dart';

class TourController extends GetxController {
  GetStorage box = GetStorage();
  RxBool isLoading = false.obs;
  RxBool isbookingLoading = false.obs;
  RxBool ispersonbookingLoading = false.obs;

  RxInt imageIndex = 0.obs;
  RxString prePrice = ''.obs;
  RxString price = ''.obs;
  RxInt passengerCount = 1.obs;
  GetToursByIdRepo apicall = GetToursByIdRepo();
  late ToursById toursById;
  RxInt currentStepperCount = 1.obs;
  final nameControllers = <TextEditingController>[].obs;
  final surnameControllers = <TextEditingController>[].obs;
  final emailControllers = <TextEditingController>[].obs;
  final contactControllers = <TextEditingController>[].obs;
  final ageControllers = <TextEditingController>[].obs;
  RxList<RxString> genderList = <RxString>[].obs;
  RxList<RxString> idType = <RxString>[].obs;
  List<GlobalKey<FormState>> formkeys = <GlobalKey<FormState>>[];
  late List<DateTimeModel> toursAvabilitydata;
  List<DateTime>? highlighteddatetimedata;
  Rx<DateTime> selectedDate = DateTime(2000, 07, 06).obs;
  RxInt selectDateId = 0.obs;
  RxList<Rx<File>> idTypesFiles = <Rx<File>>[].obs;
  RxList<Rx<File>> photoFiles = <Rx<File>>[].obs;
  RxList<RxString> idFileName = <RxString>[].obs;
  RxList<RxString> photoFileName = <RxString>[].obs;

  initialAddOn() {
    nameControllers.add(TextEditingController());
    surnameControllers.add(TextEditingController());
    emailControllers.add(TextEditingController());
    contactControllers.add(TextEditingController());
    ageControllers.add(TextEditingController());
    genderList.add("Male".obs);
    idType.add("Citizenship".obs);
    idTypesFiles.add(File("").obs);
    photoFiles.add(File("").obs);
    idFileName.add("".obs);
    photoFileName.add("".obs);
    formkeys.add(GlobalKey<FormState>());
  }

  clearAllList() {
    nameControllers.clear();
    surnameControllers.clear();
    emailControllers.clear();
    contactControllers.clear();
    ageControllers.clear();
    genderList.clear();
    idType.clear();
    formkeys.clear();
    idTypesFiles.clear();
    photoFiles.clear();
    idFileName.clear();
    photoFileName.clear();
  }

  removeLastDetails() {
    nameControllers.removeLast();
    surnameControllers.removeLast();
    emailControllers.removeLast();
    contactControllers.removeLast();
    ageControllers.removeLast();
    genderList.removeLast();
    idType.removeLast();
    formkeys.removeLast();
    idTypesFiles.removeLast();
    photoFiles.removeLast();
    idFileName.removeLast();
    photoFileName.removeLast();
  }

  passengerCountIncrement() {
    passengerCount.value++;
    initialAddOn();
  }

  passengerCountDecrement() {
    if (passengerCount.value != 1) {
      passengerCount.value--;
      removeLastDetails();
    }
  }

  toursbyIdApiCall(String tourID) async {
    isLoading.value = true;
    try {
      toursById = await apicall.getToursByIdInfo(tourID);
      price.value = toursById.price ?? "";
      prePrice.value = toursById.prePrice ?? "";
      var selectedvalue = await box.read('currency') ?? '₹ INR';
      initialCurrency(selectedvalue);
    } catch (e) {
      isLoading.value = false;
    } finally {
      isLoading.value = false;
    }
  }

  getToursAvalibilityData(String tourID) async {
    try {
      toursAvabilitydata = await apicall.getToursAvalibility(tourID);
      log("avaialibity data is this ${toursAvabilitydata.first.unavailableDate}");
      highlighteddatetimedata =
          toursAvabilitydata.map((item) => item.unavailableDate).toList();
    } catch (e) {
      rethrow;
    }
  }

  void initialCurrency(String choice) async {
    if (choice == "€ EUR") {
      print(choice);
      // Currency myCurrency = await CurrencyConverter.getMyCurrency();
      var usdConvert = await CurrencyConverter.convert(
        from: Currency.inr,
        to: Currency.eur,
        amount: double.parse(toursById.price!),
      );
      price.value = usdConvert.toString();
      box.write('currency', '€ EUR');
      var usdConvertpreprice = await CurrencyConverter.convert(
        from: Currency.inr,
        to: Currency.eur,
        amount: double.parse(toursById.prePrice!),
      );
      prePrice.value = usdConvertpreprice.toString();
      print("${usdConvert} ${usdConvertpreprice}");
    } else if (choice == "\$ AUD") {
      print(choice);
      var usdConvert = await CurrencyConverter.convert(
        from: Currency.inr,
        to: Currency.aud,
        amount: double.parse(toursById.price!),
      );
      price.value = usdConvert.toString();
      box.write('currency', '\$ AUD');
      var usdConvertpreprice = await CurrencyConverter.convert(
        from: Currency.inr,
        to: Currency.aud,
        amount: double.parse(toursById.prePrice!),
      );
      prePrice.value = usdConvertpreprice.toString();
      print("${usdConvert} ${usdConvertpreprice}");
    } else if (choice == "R\$ BRL") {
      print(choice);
      var usdConvert = await CurrencyConverter.convert(
        from: Currency.inr,
        to: Currency.brl,
        amount: double.parse(toursById.price!),
      );
      price.value = usdConvert.toString();
      box.write('currency', 'R\$ BRL');
      var usdConvertpreprice = await CurrencyConverter.convert(
        from: Currency.inr,
        to: Currency.brl,
        amount: double.parse(toursById.prePrice!),
      );
      prePrice.value = usdConvertpreprice.toString();
      print("${usdConvert} ${usdConvertpreprice}");
    } else if (choice == "\$ CAD") {
      print(choice);
      var usdConvert = await CurrencyConverter.convert(
        from: Currency.inr,
        to: Currency.cad,
        amount: double.parse(toursById.price!),
      );
      price.value = usdConvert.toString();
      box.write('currency', '\$ CAD');
      var usdConvertpreprice = await CurrencyConverter.convert(
        from: Currency.inr,
        to: Currency.cad,
        amount: double.parse(toursById.prePrice!),
      );
      prePrice.value = usdConvertpreprice.toString();
      print("${usdConvert} ${usdConvertpreprice}");
    } else if (choice == "¥ CNY") {
      print(choice);
      var usdConvert = await CurrencyConverter.convert(
        from: Currency.inr,
        to: Currency.cny,
        amount: double.parse(toursById.price!),
      );
      price.value = usdConvert.toString();
      box.write('currency', '¥ CNY');
      var usdConvertpreprice = await CurrencyConverter.convert(
        from: Currency.inr,
        to: Currency.cny,
        amount: double.parse(toursById.prePrice!),
      );
      prePrice.value = usdConvertpreprice.toString();
      print("${usdConvert} ${usdConvertpreprice}");
    } else if (choice == "Kr. DKK") {
      print(choice);
      var usdConvert = await CurrencyConverter.convert(
        from: Currency.inr,
        to: Currency.dkk,
        amount: double.parse(toursById.price!),
      );
      price.value = usdConvert.toString();
      box.write('currency', 'Kr. DKK');
      var usdConvertpreprice = await CurrencyConverter.convert(
        from: Currency.inr,
        to: Currency.dkk,
        amount: double.parse(toursById.prePrice!),
      );
      prePrice.value = usdConvertpreprice.toString();
      print("${usdConvert} ${usdConvertpreprice}");
    } else if (choice == "₹ INR") {
      print(choice);
      var usdConvert = await CurrencyConverter.convert(
        from: Currency.inr,
        to: Currency.inr,
        amount: double.parse(toursById.price!),
      );
      price.value = usdConvert.toString();
      box.write('currency', '₹ INR');
      var usdConvertpreprice = await CurrencyConverter.convert(
        from: Currency.inr,
        to: Currency.inr,
        amount: double.parse(toursById.prePrice!),
      );
      prePrice.value = usdConvertpreprice.toString();
      print("${usdConvert} ${usdConvertpreprice}");
    } else if (choice == "¥ JPY") {
      print(choice);
      var usdConvert = await CurrencyConverter.convert(
        from: Currency.inr,
        to: Currency.jpy,
        amount: double.parse(toursById.price!),
      );
      price.value = usdConvert.toString();
      box.write('currency', '\¥ JPY');
      var usdConvertpreprice = await CurrencyConverter.convert(
        from: Currency.inr,
        to: Currency.jpy,
        amount: double.parse(toursById.prePrice!),
      );
      prePrice.value = usdConvertpreprice.toString();
      print("${usdConvert} ${usdConvertpreprice}");
    } else if (choice == "₣ CHF") {
      print(choice);
      var usdConvert = await CurrencyConverter.convert(
        from: Currency.inr,
        to: Currency.chf,
        amount: double.parse(toursById.price!),
      );
      price.value = usdConvert.toString();
      box.write('currency', '₣ CHF');
      var usdConvertpreprice = await CurrencyConverter.convert(
        from: Currency.inr,
        to: Currency.chf,
        amount: double.parse(toursById.prePrice!),
      );
      prePrice.value = usdConvertpreprice.toString();
      print("${usdConvert} ${usdConvertpreprice}");
    } else if (choice == "R ZAR") {
      print(choice);
      var usdConvert = await CurrencyConverter.convert(
        from: Currency.inr,
        to: Currency.zar,
        amount: double.parse(toursById.price!),
      );
      price.value = usdConvert.toString();
      box.write('currency', 'R ZAR');
      var usdConvertpreprice = await CurrencyConverter.convert(
        from: Currency.inr,
        to: Currency.zar,
        amount: double.parse(toursById.prePrice!),
      );
      prePrice.value = usdConvertpreprice.toString();
      print("${usdConvert} ${usdConvertpreprice}");
    } else if (choice == "£ GBP") {
      print(choice);
      var usdConvert = await CurrencyConverter.convert(
        from: Currency.inr,
        to: Currency.gbp,
        amount: double.parse(toursById.price!),
      );
      price.value = usdConvert.toString();
      box.write('currency', '£ GBP');
      var usdConvertpreprice = await CurrencyConverter.convert(
        from: Currency.inr,
        to: Currency.gbp,
        amount: double.parse(toursById.prePrice!),
      );
      prePrice.value = usdConvertpreprice.toString();
      print("${usdConvert} ${usdConvertpreprice}");
    } else if (choice == "\$ USD") {
      print(choice);
      var usdConvert = await CurrencyConverter.convert(
        from: Currency.inr,
        to: Currency.usd,
        amount: double.parse(toursById.price!),
      );
      price.value = usdConvert.toString();
      box.write('currency', '\$ USD');
      var usdConvertpreprice = await CurrencyConverter.convert(
        from: Currency.inr,
        to: Currency.usd,
        amount: double.parse(toursById.prePrice!),
      );
      prePrice.value = usdConvertpreprice.toString();
      print("${usdConvert} ${usdConvertpreprice}");
    }
  }

  @override
  void onInit() {
    super.onInit();
    initialAddOn();
  }

  @override
  void onClose() {
    clearAllList();
    super.onClose();
  }
}
