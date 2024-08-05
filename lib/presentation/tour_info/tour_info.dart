import 'dart:developer';
import 'dart:ui';

import 'package:currency_converter/currency.dart';
import 'package:currency_converter/currency_converter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:toursandtravels/constants/const_colors.dart';
import 'package:toursandtravels/constants/custom_textstyle.dart';
import 'package:toursandtravels/widgets/customDottedlines.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import '../booking_screen/booking_screen.dart';
import '../home_page/registration_dialog.dart';
import 'body/tour_shimmer.dart';
import 'models/datetimemodel.dart';
import 'repo/tour_repo.dart';
import 'tour_controller/tour_controller.dart';

class TourInfo extends StatefulWidget {
  const TourInfo({super.key, required this.id, required this.name});
  final String id;
  final String name;

  @override
  State<TourInfo> createState() => _TourInfoState();
}

class _TourInfoState extends State<TourInfo> {
  var toursControlleradd = Get.put(TourController());
  GetStorage box = GetStorage();
  final textToImageMapping = {
    '€ EUR': 'assets/share.png',
    '\$ AUD': 'assets/rename.png',
    'R\$ BRL': 'assets/delete_red.png',
    '\$ CAD': 'assets/share.png',
    '¥ CNY': 'assets/rename.png',
    'Kr. DKK': 'assets/delete_red.png',
    '₹ INR': 'assets/share.png',
    '¥ JPY': 'assets/rename.png',
    '₣ CHF': 'assets/delete_red.png',
    'R ZAR': 'assets/share.png',
    '£ GBP': 'assets/rename.png',
    '\$ USD': 'assets/delete_red.png',
  };
  RxString selectedValue = ''.obs;

  @override
  void initState() {
    initialCallAPI();
    selectedValue.value = box.read('currency') ?? '₹ INR';

    super.initState();
  }

  Future initialCallAPI() async {
    await toursControlleradd.toursbyIdApiCall(widget.id.toString());
    await toursControlleradd.getToursAvalibilityData(widget.id.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          double availableWidth = constraints.maxWidth;
          double availableHeight = constraints.maxHeight;
          if (availableWidth < 800) {
            return Scaffold(
              extendBody: true,
              bottomNavigationBar: Obx(
                () => toursControlleradd.isLoading.value
                    ? const SizedBox.shrink()
                    : Container(
                        height: 82,
                        color: const Color.fromARGB(255, 241, 235, 235),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  toursControlleradd.prePrice.value,
                                  style: const TextStyle(
                                      color: ConstColors.textColor,
                                      fontWeight: FontWeight.normal,
                                      decoration: TextDecoration.lineThrough),
                                ),
                                Text.rich(TextSpan(children: [
                                  TextSpan(
                                      text:
                                          '${toursControlleradd.price.value} /',
                                      style: getTextTheme().headlineMedium),
                                  TextSpan(
                                      text: ' per person',
                                      style: getTextTheme().headlineMedium)
                                ]))
                              ],
                            ),
                            InkWell(
                              onTap: () {
                                // highlightedDates = toursControlleradd
                                //     .toursAvabilitydata
                                //     .map((item) {
                                //   return DateFormat('yyyy-MM-dd')
                                //       .parse(item['unavailable_date']);
                                // }).toList();
                                addPassenger(context);
                              },
                              child: Container(
                                height: 180.sp,
                                width: 742.sp,
                                decoration: BoxDecoration(
                                  // color:
                                  //     user ? ConstColors.backgroundColor : ConstColors.lightpurple,
                                  borderRadius: BorderRadius.circular(10),

                                  gradient: const LinearGradient(
                                    colors: [
                                      Color(0xFFFF8B28),
                                      Color(0xFFFF0000),
                                    ],
                                    //transform: GradientRotation(3.14 / 4),
                                    begin: Alignment.centerLeft,
                                    end: Alignment.centerRight,
                                  ),
                                ),
                                child: Center(
                                  child: Text(
                                    'Book Now',
                                    style: getTextTheme().titleLarge,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                        .animate()
                        .fadeIn(duration: 600.ms)
                        .then(delay: 100.ms) // baseline=800ms
                        .slide(
                            begin: const Offset(0, 1), end: const Offset(0, 0)),
              ),
              appBar: AppBar(
                leading: IconButton(
                  icon: const Icon(
                    Icons.arrow_back_ios_new_rounded,
                    color: ConstColors.textColor,
                  ),
                  onPressed: () => Get.back(),
                ),
                title: Text(
                  widget.name,
                  style: getTextTheme().headlineLarge,
                ),
                centerTitle: true,
                actions: [
                  Obx(
                    () => toursControlleradd.isLoading.value
                        ? const SizedBox.shrink()
                        : SizedBox(
                            width: 100,
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton2<String>(
                                isExpanded: true,
                                isDense: true,
                                hint: Text(
                                  'Select Currency',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Theme.of(context).hintColor,
                                  ),
                                ),
                                items: textToImageMapping.keys
                                    .map((item) => DropdownMenuItem<String>(
                                          value: item,
                                          child: Text(
                                            item,
                                            style: const TextStyle(
                                              fontSize: 14,
                                            ),
                                          ),
                                        ))
                                    .toList(),
                                value: selectedValue.value,
                                onChanged: (String? choice) async {
                                  selectedValue.value = choice!;
                                  if (choice == "€ EUR") {
                                    log("choicechoicechoice $choice");
                                    // Currency myCurrency = await CurrencyConverter.getMyCurrency();
                                    var usdConvert =
                                        await CurrencyConverter.convert(
                                      from: Currency.inr,
                                      to: Currency.eur,
                                      amount: double.parse(
                                          toursControlleradd.toursById.price),
                                    );
                                    toursControlleradd.price.value =
                                        usdConvert.toString();
                                    box.write('currency', '€ EUR');
                                    var usdConvertpreprice =
                                        await CurrencyConverter.convert(
                                      from: Currency.inr,
                                      to: Currency.eur,
                                      amount: double.parse(toursControlleradd
                                          .toursById.prePrice),
                                    );
                                    toursControlleradd.prePrice.value =
                                        usdConvertpreprice.toString();
                                    log("usdConvert $usdConvert usdConvertpreprice $usdConvertpreprice");
                                  } else if (choice == "\$ AUD") {
                                    log("choicechoicechoicechoice $choice");
                                    var usdConvert =
                                        await CurrencyConverter.convert(
                                      from: Currency.inr,
                                      to: Currency.aud,
                                      amount: double.parse(
                                          toursControlleradd.toursById.price),
                                    );
                                    toursControlleradd.price.value =
                                        usdConvert.toString();
                                    box.write('currency', '\$ AUD');
                                    var usdConvertpreprice =
                                        await CurrencyConverter.convert(
                                      from: Currency.inr,
                                      to: Currency.aud,
                                      amount: double.parse(toursControlleradd
                                          .toursById.prePrice),
                                    );
                                    toursControlleradd.prePrice.value =
                                        usdConvertpreprice.toString();
                                    log("usdConvert $usdConvert usdConvertpreprice $usdConvertpreprice");
                                  } else if (choice == "R\$ BRL") {
                                    log("choicechoicechoice $choice");
                                    var usdConvert =
                                        await CurrencyConverter.convert(
                                      from: Currency.inr,
                                      to: Currency.brl,
                                      amount: double.parse(
                                          toursControlleradd.toursById.price),
                                    );
                                    toursControlleradd.price.value =
                                        usdConvert.toString();
                                    box.write('currency', 'R\$ BRL');
                                    var usdConvertpreprice =
                                        await CurrencyConverter.convert(
                                      from: Currency.inr,
                                      to: Currency.brl,
                                      amount: double.parse(toursControlleradd
                                          .toursById.prePrice),
                                    );
                                    toursControlleradd.prePrice.value =
                                        usdConvertpreprice.toString();
                                    log("usdConvert $usdConvert usdConvertpreprice $usdConvertpreprice");
                                  } else if (choice == "\$ CAD") {
                                    log("choicechoice $choice");
                                    var usdConvert =
                                        await CurrencyConverter.convert(
                                      from: Currency.inr,
                                      to: Currency.cad,
                                      amount: double.parse(
                                          toursControlleradd.toursById.price),
                                    );
                                    toursControlleradd.price.value =
                                        usdConvert.toString();
                                    box.write('currency', '\$ CAD');
                                    var usdConvertpreprice =
                                        await CurrencyConverter.convert(
                                      from: Currency.inr,
                                      to: Currency.cad,
                                      amount: double.parse(toursControlleradd
                                          .toursById.prePrice),
                                    );
                                    toursControlleradd.prePrice.value =
                                        usdConvertpreprice.toString();
                                    print(
                                        "usdConvert $usdConvert usdConvertpreprice $usdConvertpreprice");
                                  } else if (choice == "¥ CNY") {
                                    log("choicechoicechoicechoice $choice");
                                    var usdConvert =
                                        await CurrencyConverter.convert(
                                      from: Currency.inr,
                                      to: Currency.cny,
                                      amount: double.parse(
                                          toursControlleradd.toursById.price),
                                    );
                                    toursControlleradd.price.value =
                                        usdConvert.toString();
                                    box.write('currency', '¥ CNY');
                                    var usdConvertpreprice =
                                        await CurrencyConverter.convert(
                                      from: Currency.inr,
                                      to: Currency.cny,
                                      amount: double.parse(toursControlleradd
                                          .toursById.prePrice),
                                    );
                                    toursControlleradd.prePrice.value =
                                        usdConvertpreprice.toString();
                                    log("usdConvert $usdConvert usdConvertpreprice $usdConvertpreprice");
                                  } else if (choice == "Kr. DKK") {
                                    log("choicechoicechoice$choice");
                                    var usdConvert =
                                        await CurrencyConverter.convert(
                                      from: Currency.inr,
                                      to: Currency.dkk,
                                      amount: double.parse(
                                          toursControlleradd.toursById.price),
                                    );
                                    toursControlleradd.price.value =
                                        usdConvert.toString();
                                    box.write('currency', 'Kr. DKK');
                                    var usdConvertpreprice =
                                        await CurrencyConverter.convert(
                                      from: Currency.inr,
                                      to: Currency.dkk,
                                      amount: double.parse(toursControlleradd
                                          .toursById.prePrice),
                                    );
                                    toursControlleradd.prePrice.value =
                                        usdConvertpreprice.toString();
                                    log("usdConvert $usdConvert usdConvertpreprice $usdConvertpreprice");
                                  } else if (choice == "₹ INR") {
                                    log("choicechoicechoicechoice $choice");
                                    var usdConvert =
                                        await CurrencyConverter.convert(
                                      from: Currency.inr,
                                      to: Currency.inr,
                                      amount: double.parse(
                                          toursControlleradd.toursById.price),
                                    );
                                    toursControlleradd.price.value =
                                        usdConvert.toString();
                                    box.write('currency', '₹ INR');
                                    var usdConvertpreprice =
                                        await CurrencyConverter.convert(
                                      from: Currency.inr,
                                      to: Currency.inr,
                                      amount: double.parse(toursControlleradd
                                          .toursById.prePrice),
                                    );
                                    toursControlleradd.prePrice.value =
                                        usdConvertpreprice.toString();
                                    log("usdConvert $usdConvert usdConvertpreprice $usdConvertpreprice");
                                  } else if (choice == "¥ JPY") {
                                    log("choicechoicechoicechoice $choice");
                                    var usdConvert =
                                        await CurrencyConverter.convert(
                                      from: Currency.inr,
                                      to: Currency.jpy,
                                      amount: double.parse(
                                          toursControlleradd.toursById.price),
                                    );
                                    toursControlleradd.price.value =
                                        usdConvert.toString();
                                    box.write('currency', '\¥ JPY');
                                    var usdConvertpreprice =
                                        await CurrencyConverter.convert(
                                      from: Currency.inr,
                                      to: Currency.jpy,
                                      amount: double.parse(toursControlleradd
                                          .toursById.prePrice),
                                    );
                                    toursControlleradd.prePrice.value =
                                        usdConvertpreprice.toString();
                                    log("usdConvert $usdConvert usdConvertpreprice $usdConvertpreprice");
                                  } else if (choice == "₣ CHF") {
                                    log("choicechoicechoicechoice $choice");
                                    var usdConvert =
                                        await CurrencyConverter.convert(
                                      from: Currency.inr,
                                      to: Currency.chf,
                                      amount: double.parse(
                                          toursControlleradd.toursById.price),
                                    );
                                    toursControlleradd.price.value =
                                        usdConvert.toString();
                                    box.write('currency', '₣ CHF');
                                    var usdConvertpreprice =
                                        await CurrencyConverter.convert(
                                      from: Currency.inr,
                                      to: Currency.chf,
                                      amount: double.parse(toursControlleradd
                                          .toursById.prePrice),
                                    );
                                    toursControlleradd.prePrice.value =
                                        usdConvertpreprice.toString();
                                    log("usdConvert $usdConvert usdConvertpreprice $usdConvertpreprice");
                                  } else if (choice == "R ZAR") {
                                    log("choicechoicechoicechoice $choice");
                                    var usdConvert =
                                        await CurrencyConverter.convert(
                                      from: Currency.inr,
                                      to: Currency.zar,
                                      amount: double.parse(
                                          toursControlleradd.toursById.price),
                                    );
                                    toursControlleradd.price.value =
                                        usdConvert.toString();
                                    box.write('currency', 'R ZAR');
                                    var usdConvertpreprice =
                                        await CurrencyConverter.convert(
                                      from: Currency.inr,
                                      to: Currency.zar,
                                      amount: double.parse(toursControlleradd
                                          .toursById.prePrice),
                                    );
                                    toursControlleradd.prePrice.value =
                                        usdConvertpreprice.toString();
                                    log("usdConvert $usdConvert usdConvertpreprice $usdConvertpreprice");
                                  } else if (choice == "£ GBP") {
                                    log("choicechoicechoicechoice $choice");
                                    var usdConvert =
                                        await CurrencyConverter.convert(
                                      from: Currency.inr,
                                      to: Currency.gbp,
                                      amount: double.parse(
                                          toursControlleradd.toursById.price),
                                    );
                                    toursControlleradd.price.value =
                                        usdConvert.toString();
                                    box.write('currency', '£ GBP');
                                    var usdConvertpreprice =
                                        await CurrencyConverter.convert(
                                      from: Currency.inr,
                                      to: Currency.gbp,
                                      amount: double.parse(toursControlleradd
                                          .toursById.prePrice),
                                    );
                                    toursControlleradd.prePrice.value =
                                        usdConvertpreprice.toString();
                                    log("usdConvert $usdConvert usdConvertpreprice $usdConvertpreprice");
                                  } else if (choice == "\$ USD") {
                                    log("choicechoicechoicechoice $choice");
                                    var usdConvert =
                                        await CurrencyConverter.convert(
                                      from: Currency.inr,
                                      to: Currency.usd,
                                      amount: double.parse(
                                          toursControlleradd.toursById.price),
                                    );
                                    toursControlleradd.price.value =
                                        usdConvert.toString();
                                    box.write('currency', '\$ USD');
                                    var usdConvertpreprice =
                                        await CurrencyConverter.convert(
                                      from: Currency.inr,
                                      to: Currency.usd,
                                      amount: double.parse(toursControlleradd
                                          .toursById.prePrice),
                                    );
                                    toursControlleradd.prePrice.value =
                                        usdConvertpreprice.toString();
                                    log("usdConvert $usdConvert usdConvertpreprice $usdConvertpreprice");
                                  }
                                },
                                buttonStyleData: const ButtonStyleData(
                                  padding: EdgeInsets.symmetric(horizontal: 16),
                                  height: 40,
                                  width: 140,
                                ),
                                menuItemStyleData: const MenuItemStyleData(
                                  height: 40,
                                ),
                              ),
                            ),
                          ),
                  ),
                ],
              ),
              body: SafeArea(
                  child: SizedBox(
                width: 1920.w,
                child: SingleChildScrollView(
                  child: Obx(
                    () => Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        if (toursControlleradd.isLoading.value) ...[
                          const TourShimmer()
                        ] else ...[
                          Container(
                            margin: EdgeInsets.symmetric(
                                vertical: 11.h, horizontal: 80.w),
                            width: 1920.w,
                            height: 240.h,
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: NetworkImage(toursControlleradd
                                            .toursById.tourImages.isEmpty
                                        ? "https://cdn-icons-png.freepik.com/512/15114/15114626.png"
                                        : toursControlleradd
                                            .toursById
                                            .tourImages[toursControlleradd
                                                .imageIndex.value]
                                            .image)),
                                borderRadius: BorderRadius.circular(30),
                                color: Colors.grey),
                          ),
                          toursControlleradd.toursById.tourImages.isEmpty
                              ? SizedBox()
                              : Padding(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 11.h, horizontal: 80.w),
                                  child: Row(
                                    children: [
                                      Text(
                                        'More Images',
                                        style: getTextTheme().headlineMedium,
                                      ),
                                    ],
                                  ),
                                ),
                          toursControlleradd.toursById.tourImages.isEmpty
                              ? SizedBox()
                              : SizedBox(
                                  width: 1920.w,
                                  height: 400.sp,
                                  child: Padding(
                                    padding: EdgeInsets.only(left: 60.w),
                                    child: ListView.builder(
                                        itemCount: toursControlleradd
                                            .toursById.tourImages.length,
                                        physics: const BouncingScrollPhysics(),
                                        scrollDirection: Axis.horizontal,
                                        itemBuilder: (context, index) {
                                          return GestureDetector(
                                            onTap: () {
                                              toursControlleradd
                                                  .imageIndex.value = index;
                                            },
                                            child: Container(
                                              margin: EdgeInsets.symmetric(
                                                  horizontal: 35.w,
                                                  vertical: 6),
                                              height: 350.sp,
                                              width: 350.sp,
                                              decoration: BoxDecoration(
                                                  boxShadow: toursControlleradd
                                                              .imageIndex
                                                              .value ==
                                                          index
                                                      ? [
                                                          const BoxShadow(
                                                              color: ConstColors
                                                                  .primaryColor,
                                                              blurRadius: 4,
                                                              spreadRadius: 1)
                                                        ]
                                                      : [],
                                                  image: DecorationImage(
                                                      fit: BoxFit.cover,
                                                      image: NetworkImage(
                                                          toursControlleradd
                                                              .toursById
                                                              .tourImages[index]
                                                              .image)),
                                                  borderRadius:
                                                      BorderRadius.circular(20),
                                                  color: Colors.grey),
                                            ),
                                          );
                                        }),
                                  ),
                                ),
                                Gap(10),
            Row(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 0.h, horizontal: 80.w),
                  child: Text(
                    'Description',
                    style: getTextTheme().headlineMedium,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 0.h, horizontal: 80.w),
                  child: Text(
                    'Ratings',
                    style: getTextTheme().headlineMedium,
                  ),
                ),


              ],
              
            ),
            SizedBox(height: 20.h),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 11.h, horizontal: 80.w),
              child: Text(
                toursControlleradd.toursById.description,
                style: getTextTheme().headlineSmall,
              ),
            ),
  
        

                          
                          Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: 0.h, horizontal: 80.w),
                            child: Row(
                              children: [
                                Text(
                                  'Itinerary',
                                  style: getTextTheme().headlineMedium,
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: 11.h, horizontal: 80.w),
                            child: ListView.builder(
                                physics: const NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: toursControlleradd
                                    .toursById.itinerary.length,
                                itemBuilder: (context, index) {
                                  return index % 2 == 0
                                      ? Container(
                                          width: 1920.w,
                                          height: index ==
                                                  (toursControlleradd.toursById
                                                          .itinerary.length -
                                                      1)
                                              ? 100
                                              : 180,
                                          child: Stack(
                                            children: [
                                              Positioned(
                                                top: 0,
                                                right: 0,
                                                child: SizedBox(
                                                  width: 1378.w,
                                                  height: 118,
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        toursControlleradd
                                                            .toursById
                                                            .itinerary[index]
                                                            .title,
                                                        maxLines: 1,
                                                        style: getTextTheme()
                                                            .bodyMedium,
                                                      ),
                                                      Text.rich(
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          maxLines: 3,
                                                          TextSpan(children: [
                                                            TextSpan(
                                                                style: getTextTheme()
                                                                    .bodyLarge,
                                                                text: toursControlleradd
                                                                    .toursById
                                                                    .itinerary[
                                                                        index]
                                                                    .description),
                                                          ])),
                                                      GestureDetector(
                                                        onTap: () {
                                                          CustomSignInDialog(
                                                              toursControlleradd
                                                                  .toursById
                                                                  .itinerary[
                                                                      index]
                                                                  .title,
                                                              toursControlleradd
                                                                  .toursById
                                                                  .itinerary[
                                                                      index]
                                                                  .description,
                                                              context,
                                                              onClosed:
                                                                  (value) {});
                                                        },
                                                        child: Text(
                                                          'show more',
                                                          maxLines: 1,
                                                          style: GoogleFonts.montserrat(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400,
                                                              color: ConstColors
                                                                  .blue,
                                                              fontSize: 38.sp,
                                                              decoration:
                                                                  TextDecoration
                                                                      .underline,
                                                              decorationColor:
                                                                  ConstColors
                                                                      .blue),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              Positioned(
                                                  bottom: -104,
                                                  right: 132.w,
                                                  child: index ==
                                                          (toursControlleradd
                                                                  .toursById
                                                                  .itinerary
                                                                  .length -
                                                              1)
                                                      ? const SizedBox()
                                                      : const LefttoRightCurve(
                                                          color: Colors.black)),
                                              Positioned(
                                                top: 0,
                                                left: 53.w,
                                                child: Container(
                                                  height: 180.sp,
                                                  width: 180.sp,
                                                  decoration: BoxDecoration(
                                                    // color:
                                                    //     user ? ConstColors.backgroundColor : ConstColors.lightpurple,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            50),

                                                    gradient:
                                                        const LinearGradient(
                                                      colors: [
                                                        Color(0xFFFF0000),
                                                        Color(0xFFFF8B28),
                                                      ],
                                                      transform:
                                                          GradientRotation(
                                                              3.14 / 4),
                                                      begin:
                                                          Alignment(-1.0, -1),
                                                      end: Alignment(-1.0, 1),
                                                    ),
                                                  ),
                                                  child: Center(
                                                    child: Text(
                                                      'DAY ${index + 1}',
                                                      style: GoogleFonts
                                                          .montserrat(
                                                        fontWeight:
                                                            FontWeight.w700,
                                                        color: ConstColors
                                                            .backgroundColor,
                                                        fontSize: 38.sp,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        )
                                      : Container(
                                          width: 1920.w,
                                          height: index ==
                                                  (toursControlleradd.toursById
                                                          .itinerary.length -
                                                      1)
                                              ? 100
                                              : 180,
                                          //   color: Colors.green,
                                          child: Stack(
                                            children: [
                                              Positioned(
                                                top: 0,
                                                left: 0,
                                                child: SizedBox(
                                                  width: 1378.w,
                                                  height: 100,
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        toursControlleradd
                                                            .toursById
                                                            .itinerary[index]
                                                            .title,
                                                        maxLines: 1,
                                                        style: getTextTheme()
                                                            .bodyMedium,
                                                      ),
                                                      Text.rich(
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          maxLines: 3,
                                                          TextSpan(children: [
                                                            TextSpan(
                                                                style: getTextTheme()
                                                                    .bodyLarge,
                                                                text: toursControlleradd
                                                                    .toursById
                                                                    .itinerary[
                                                                        index]
                                                                    .description)
                                                          ])),
                                                      GestureDetector(
                                                        onTap: () {
                                                          CustomSignInDialog(
                                                              toursControlleradd
                                                                  .toursById
                                                                  .itinerary[
                                                                      index]
                                                                  .title,
                                                              toursControlleradd
                                                                  .toursById
                                                                  .itinerary[
                                                                      index]
                                                                  .description,
                                                              context,
                                                              onClosed:
                                                                  (value) {});
                                                        },
                                                        child: Text(
                                                          'show more',
                                                          maxLines: 1,
                                                          style: GoogleFonts.montserrat(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400,
                                                              color: ConstColors
                                                                  .blue,
                                                              fontSize: 38.sp,
                                                              decoration:
                                                                  TextDecoration
                                                                      .underline,
                                                              decorationColor:
                                                                  ConstColors
                                                                      .blue),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              Positioned(
                                                  bottom: -104,
                                                  left: 140.w,
                                                  child: index ==
                                                          (toursControlleradd
                                                                  .toursById
                                                                  .itinerary
                                                                  .length -
                                                              1)
                                                      ? const SizedBox.shrink()
                                                      : const RightToLeftCurve(
                                                          color: Colors.black)),
                                              Positioned(
                                                top: 2,
                                                right: 53.w,
                                                child: Container(
                                                  height: 180.sp,
                                                  width: 180.sp,
                                                  decoration: BoxDecoration(
                                                    // color:
                                                    //     user ? ConstColors.backgroundColor : ConstColors.lightpurple,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            50),
                                                    // boxShadow: const [
                                                    //   BoxShadow(
                                                    //     color: ConstColors.shadowColor,
                                                    //     spreadRadius: 4,
                                                    //     blurRadius: 4,
                                                    //   )
                                                    // ],
                                                    gradient:
                                                        const LinearGradient(
                                                      colors: [
                                                        Color(0xFFFF0000),
                                                        Color(0xFFFF8B28),
                                                      ],
                                                      transform:
                                                          GradientRotation(
                                                              3.14 / 4),
                                                      begin:
                                                          Alignment(-1.0, -1),
                                                      end: Alignment(-1.0, 1),
                                                    ),
                                                  ),
                                                  child: Center(
                                                    child: Text(
                                                      'DAY ${index + 1}',
                                                      style: GoogleFonts
                                                          .montserrat(
                                                        fontWeight:
                                                            FontWeight.w700,
                                                        color: ConstColors
                                                            .backgroundColor,
                                                        fontSize: 38.sp,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        );
                                }),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: 6.h, horizontal: 80.w),
                            child: Row(
                              children: [
                                Text(
                                  'Included',
                                  style: getTextTheme().headlineMedium,
                                ),
                              ],
                            ),
                          ),
                          Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: 0.h, horizontal: 80.w),
                              child: ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: toursControlleradd
                                      .toursById.included
                                      .split('\n')
                                      .length,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemBuilder: (context, index) {
                                    return Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(top: 2),
                                          child: Icon(
                                            Icons.brightness_1,
                                            color: ConstColors.green,
                                            size: 38.sp,
                                          ),
                                        ),
                                        SizedBox(width: 27.w),
                                        SizedBox(
                                          width: 1643.w,
                                          child: Text(
                                              style: getTextTheme().bodySmall,
                                              toursControlleradd
                                                  .toursById.included
                                                  .split('\n')[index]),
                                        )
                                      ],
                                    );
                                  })),
                          SizedBox(
                            height: 11.h,
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: 6.h, horizontal: 80.w),
                            child: Row(
                              children: [
                                Text(
                                  'Excluded',
                                  style: getTextTheme().headlineMedium,
                                ),
                              ],
                            ),
                          ),
                          Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: 0.h, horizontal: 80.w),
                              child: ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: toursControlleradd
                                      .toursById.excluded
                                      .split('\n')
                                      .length,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemBuilder: (context, index) {
                                    return Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(top: 2),
                                          child: Icon(
                                            Icons.brightness_1,
                                            color: ConstColors.red,
                                            size: 38.sp,
                                          ),
                                        ),
                                        SizedBox(width: 27.w),
                                        SizedBox(
                                          width: 1643.w,
                                          child: Text(
                                              style: getTextTheme().bodySmall,
                                              toursControlleradd
                                                  .toursById.excluded
                                                  .split('\n')[index]),
                                        )
                                      ],
                                    );
                                  })),
                          const SizedBox(
                            height: 70,
                          ),
                        ]
                      ],
                    ),
                  ),
                ),
              )),
            );
          } else {
            return SafeArea(
              child: SizedBox(
                width: 1920.w,
                child: SingleChildScrollView(
                  child: Obx(
                    () => Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        if (toursControlleradd.isLoading.value) ...[
                          const TourShimmer()
                        ] else ...[
                          Text(
                            widget.name,
                            style: GoogleFonts.judson(
                              fontWeight: FontWeight.w700,
                              color: ConstColors.textColor,
                              fontSize: 44,
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.symmetric(
                                vertical: 11.h, horizontal: 80.w),
                            width: 1920.w,
                            height: 600,
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: NetworkImage(toursControlleradd
                                        .toursById
                                        .tourImages[
                                            toursControlleradd.imageIndex.value]
                                        .image)),
                                borderRadius: BorderRadius.circular(30),
                                color: Colors.grey),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: 11.h, horizontal: 150.w),
                            child: Row(
                              children: [
                                Text(
                                  'More Images',
                                  style: GoogleFonts.montserrat(
                                    fontWeight: FontWeight.w600,
                                    color: ConstColors.textColor,
                                    fontSize: 24,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Row(
                            children: [
                              SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Padding(
                                  padding: EdgeInsets.only(left: 105.w),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: List.generate(
                                        toursControlleradd.toursById.tourImages
                                            .length, (index) {
                                      return GestureDetector(
                                        onTap: () {
                                          toursControlleradd.imageIndex.value =
                                              index;
                                        },
                                        child: Container(
                                          margin: EdgeInsets.symmetric(
                                              horizontal: 35.w, vertical: 6),
                                          height: 200.sp,
                                          width: 200.sp,
                                          decoration: BoxDecoration(
                                              boxShadow: toursControlleradd
                                                          .imageIndex.value ==
                                                      index
                                                  ? [
                                                      const BoxShadow(
                                                          color: ConstColors
                                                              .primaryColor,
                                                          blurRadius: 4,
                                                          spreadRadius: 1)
                                                    ]
                                                  : [],
                                              image: DecorationImage(
                                                  fit: BoxFit.cover,
                                                  image: NetworkImage(
                                                      toursControlleradd
                                                          .toursById
                                                          .tourImages[index]
                                                          .image)),
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                              color: Colors.grey),
                                        ),
                                      );
                                    }),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: 11.h, horizontal: 150.w),
                            child: Text(
                              toursControlleradd.toursById.description,
                              style: GoogleFonts.montserrat(
                                fontWeight: FontWeight.w400,
                                color: ConstColors.textColor,
                                fontSize: 18,
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: 0.h, horizontal: 80.w),
                            child: Row(
                              children: [
                                Text(
                                  'Itinerary',
                                  style: GoogleFonts.montserrat(
                                    fontWeight: FontWeight.w600,
                                    color: ConstColors.textColor,
                                    fontSize: 24,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: 11.h, horizontal: 80.w),
                            child: ListView.builder(
                                physics: const NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: toursControlleradd
                                    .toursById.itinerary.length,
                                itemBuilder: (context, index) {
                                  return index % 2 == 0
                                      ? Container(
                                          width: 1700.w,
                                          height: index ==
                                                  (toursControlleradd.toursById
                                                          .itinerary.length -
                                                      1)
                                              ? 300
                                              : 380,
                                          child: Stack(
                                            children: [
                                              Positioned(
                                                top: 0,
                                                right: 0,
                                                child: SizedBox(
                                                  width: 1378.w,
                                                  height: 200,
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        toursControlleradd
                                                            .toursById
                                                            .itinerary[index]
                                                            .title,
                                                        maxLines: 1,
                                                        style: GoogleFonts
                                                            .montserrat(
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          color: ConstColors
                                                              .textColor,
                                                          fontSize: 24,
                                                        ),
                                                      ),
                                                      Text.rich(
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          maxLines: 5,
                                                          TextSpan(children: [
                                                            TextSpan(
                                                                style: GoogleFonts
                                                                    .montserrat(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w400,
                                                                  color: ConstColors
                                                                      .textColor,
                                                                  fontSize: 16,
                                                                ),
                                                                text: toursControlleradd
                                                                    .toursById
                                                                    .itinerary[
                                                                        index]
                                                                    .description),
                                                          ])),
                                                      InkWell(
                                                        onTap: () {
                                                          CustomSignInDialog(
                                                              toursControlleradd
                                                                  .toursById
                                                                  .itinerary[
                                                                      index]
                                                                  .title,
                                                              toursControlleradd
                                                                  .toursById
                                                                  .itinerary[
                                                                      index]
                                                                  .description,
                                                              context,
                                                              onClosed:
                                                                  (value) {});
                                                        },
                                                        child: Text(
                                                          'show more',
                                                          maxLines: 1,
                                                          style: GoogleFonts.montserrat(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400,
                                                              color: ConstColors
                                                                  .blue,
                                                              fontSize: 18,
                                                              decoration:
                                                                  TextDecoration
                                                                      .underline,
                                                              decorationColor:
                                                                  ConstColors
                                                                      .blue),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              Positioned(
                                                  bottom: -174,
                                                  right: 132.w,
                                                  child: index ==
                                                          (toursControlleradd
                                                                  .toursById
                                                                  .itinerary
                                                                  .length -
                                                              1)
                                                      ? const SizedBox()
                                                      : const LefttoRightCurve(
                                                          color: Colors.black)),
                                              Positioned(
                                                top: 0,
                                                left: 53.w,
                                                child: Container(
                                                  height: 100.sp,
                                                  width: 100.sp,
                                                  decoration: BoxDecoration(
                                                    // color:
                                                    //     user ? ConstColors.backgroundColor : ConstColors.lightpurple,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            100),

                                                    gradient:
                                                        const LinearGradient(
                                                      colors: [
                                                        Color(0xFFFF0000),
                                                        Color(0xFFFF8B28),
                                                      ],
                                                      transform:
                                                          GradientRotation(
                                                              3.14 / 4),
                                                      begin:
                                                          Alignment(-1.0, -1),
                                                      end: Alignment(-1.0, 1),
                                                    ),
                                                  ),
                                                  child: Center(
                                                    child: Text(
                                                      'DAY ${index + 1}',
                                                      style: GoogleFonts
                                                          .montserrat(
                                                        fontWeight:
                                                            FontWeight.w700,
                                                        color: ConstColors
                                                            .backgroundColor,
                                                        fontSize: 14.sp,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        )
                                      : Container(
                                          width: 1920.w,
                                          height: index ==
                                                  (toursControlleradd.toursById
                                                          .itinerary.length -
                                                      1)
                                              ? 300
                                              : 380,
                                          //   color: Colors.green,
                                          child: Stack(
                                            children: [
                                              Positioned(
                                                top: 0,
                                                left: 0,
                                                child: SizedBox(
                                                  width: 1378.w,
                                                  height: 200,
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        toursControlleradd
                                                            .toursById
                                                            .itinerary[index]
                                                            .title,
                                                        maxLines: 1,
                                                        style: GoogleFonts
                                                            .montserrat(
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          color: ConstColors
                                                              .textColor,
                                                          fontSize: 24,
                                                        ),
                                                      ),
                                                      Text.rich(
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          maxLines: 5,
                                                          TextSpan(children: [
                                                            TextSpan(
                                                                style: GoogleFonts
                                                                    .montserrat(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w400,
                                                                  color: ConstColors
                                                                      .textColor,
                                                                  fontSize: 16,
                                                                ),
                                                                text: toursControlleradd
                                                                    .toursById
                                                                    .itinerary[
                                                                        index]
                                                                    .description)
                                                          ])),
                                                      InkWell(
                                                        onTap: () {
                                                          CustomSignInDialog(
                                                              toursControlleradd
                                                                  .toursById
                                                                  .itinerary[
                                                                      index]
                                                                  .title,
                                                              toursControlleradd
                                                                  .toursById
                                                                  .itinerary[
                                                                      index]
                                                                  .description,
                                                              context,
                                                              onClosed:
                                                                  (value) {});
                                                        },
                                                        child: Text(
                                                          'show more',
                                                          maxLines: 1,
                                                          style: GoogleFonts.montserrat(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400,
                                                              color: ConstColors
                                                                  .blue,
                                                              fontSize: 18,
                                                              decoration:
                                                                  TextDecoration
                                                                      .underline,
                                                              decorationColor:
                                                                  ConstColors
                                                                      .blue),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              Positioned(
                                                  bottom: -184,
                                                  left: 140.w,
                                                  child: index ==
                                                          (toursControlleradd
                                                                  .toursById
                                                                  .itinerary
                                                                  .length -
                                                              1)
                                                      ? const SizedBox.shrink()
                                                      : const RightToLeftCurve(
                                                          color: Colors.black)),
                                              Positioned(
                                                top: 2,
                                                right: 53.w,
                                                child: Container(
                                                  height: 100.sp,
                                                  width: 100.sp,
                                                  decoration: BoxDecoration(
                                                    // color:
                                                    //     user ? ConstColors.backgroundColor : ConstColors.lightpurple,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            100),
                                                    // boxShadow: const [
                                                    //   BoxShadow(
                                                    //     color: ConstColors.shadowColor,
                                                    //     spreadRadius: 4,
                                                    //     blurRadius: 4,
                                                    //   )
                                                    // ],
                                                    gradient:
                                                        const LinearGradient(
                                                      colors: [
                                                        Color(0xFFFF0000),
                                                        Color(0xFFFF8B28),
                                                      ],
                                                      transform:
                                                          GradientRotation(
                                                              3.14 / 4),
                                                      begin:
                                                          Alignment(-1.0, -1),
                                                      end: Alignment(-1.0, 1),
                                                    ),
                                                  ),
                                                  child: Center(
                                                    child: Text(
                                                      'DAY ${index + 1}',
                                                      style: GoogleFonts
                                                          .montserrat(
                                                        fontWeight:
                                                            FontWeight.w700,
                                                        color: ConstColors
                                                            .backgroundColor,
                                                        fontSize: 14.sp,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        );
                                }),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: 6.h, horizontal: 80.w),
                            child: Row(
                              children: [
                                Text(
                                  'Included',
                                  style: GoogleFonts.montserrat(
                                    fontWeight: FontWeight.w600,
                                    color: ConstColors.textColor,
                                    fontSize: 24,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: 0.h, horizontal: 80.w),
                              child: ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: toursControlleradd
                                      .toursById.included
                                      .split('\n')
                                      .length,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemBuilder: (context, index) {
                                    return Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(top: 5),
                                          child: Icon(
                                            Icons.brightness_1,
                                            color: ConstColors.green,
                                            size: 10,
                                          ),
                                        ),
                                        SizedBox(width: 27.w),
                                        SizedBox(
                                          width: 1643.w,
                                          child: Text(
                                              style: GoogleFonts.montserrat(
                                                fontWeight: FontWeight.w400,
                                                color: ConstColors.textColor,
                                                fontSize: 18,
                                              ),
                                              toursControlleradd
                                                  .toursById.included
                                                  .split('\n')[index]),
                                        )
                                      ],
                                    );
                                  })),
                          SizedBox(
                            height: 11.h,
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: 30.h, horizontal: 80.w),
                            child: Row(
                              children: [
                                Text(
                                  'Excluded',
                                  style: GoogleFonts.montserrat(
                                    fontWeight: FontWeight.w600,
                                    color: ConstColors.textColor,
                                    fontSize: 24,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: 0.h, horizontal: 80.w),
                              child: ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: toursControlleradd
                                      .toursById.excluded
                                      .split('\n')
                                      .length,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemBuilder: (context, index) {
                                    return Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(top: 5),
                                          child: Icon(
                                            Icons.brightness_1,
                                            color: ConstColors.red,
                                            size: 10,
                                          ),
                                        ),
                                        SizedBox(width: 27.w),
                                        SizedBox(
                                          width: 1643.w,
                                          child: Text(
                                              style: GoogleFonts.montserrat(
                                                fontWeight: FontWeight.w400,
                                                color: ConstColors.textColor,
                                                fontSize: 18,
                                              ),
                                              toursControlleradd
                                                  .toursById.excluded
                                                  .split('\n')[index]),
                                        )
                                      ],
                                    );
                                  })),
                          const SizedBox(
                            height: 70,
                          ),
                          Obx(() => toursControlleradd.isLoading.value
                                  ? const SizedBox.shrink()
                                  : Container(
                                      height: 82,
                                      color: const Color.fromARGB(
                                          255, 241, 235, 235),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                toursControlleradd
                                                    .prePrice.value,
                                                style: const TextStyle(
                                                    color:
                                                        ConstColors.textColor,
                                                    fontWeight:
                                                        FontWeight.normal,
                                                    decoration: TextDecoration
                                                        .lineThrough),
                                              ),
                                              Text.rich(TextSpan(children: [
                                                TextSpan(
                                                    text:
                                                        '${toursControlleradd.price.value} /',
                                                    style:
                                                        GoogleFonts.montserrat(
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      color:
                                                          ConstColors.textColor,
                                                      fontSize: 24,
                                                    )),
                                                TextSpan(
                                                    text: ' per person',
                                                    style:
                                                        GoogleFonts.montserrat(
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      color:
                                                          ConstColors.textColor,
                                                      fontSize: 24,
                                                    ))
                                              ]))
                                            ],
                                          ),
                                          Container(
                                            height: 60,
                                            width: 300,
                                            decoration: BoxDecoration(
                                              // color:
                                              //     user ? ConstColors.backgroundColor : ConstColors.lightpurple,
                                              borderRadius:
                                                  BorderRadius.circular(10),

                                              gradient: const LinearGradient(
                                                colors: [
                                                  Color(0xFFFF0000),
                                                  Color(0xFFFF8B28),
                                                ],
                                                transform:
                                                    GradientRotation(3.14 / 4),
                                                begin: Alignment(-1.0, -1),
                                                end: Alignment(-1.0, 1),
                                              ),
                                            ),
                                            child: Center(
                                              child: Text(
                                                'Book Now',
                                                style: GoogleFonts.montserrat(
                                                  fontWeight: FontWeight.w700,
                                                  color: ConstColors
                                                      .backgroundColor,
                                                  fontSize: 24,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    )
                              // .animate()
                              // .fadeIn(duration: 600.ms)
                              // .then(delay: 100.ms) // baseline=800ms
                              // .slide(
                              //     begin: const Offset(0, 1), end: const Offset(0, 0)),
                              ),
                        ]
                      ],
                    ),
                  ),
                ),
              ),
            );
          }
        },
      ),
    );
  }

  // final List<DateTime> highlightedDates = [
  //   DateTime(2024, 6, 25),
  //   DateTime(2024, 6, 29),
  //   DateTime(2024, 7, 2),
  // ];

  void showCustomDatePicker(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        title: Text(
          'Select a highlighted Date',
          style: getTextTheme().headlineLarge,
        ),
        content: SizedBox(
          height: 400,
          width: 400,
          child: SfDateRangePicker(
            view: DateRangePickerView.month,
            backgroundColor: Colors.white,
            monthCellStyle: DateRangePickerMonthCellStyle(
              specialDatesDecoration: BoxDecoration(
                color: ConstColors.primaryColor,
                border: Border.all(color: ConstColors.primaryColor, width: 2),
                shape: BoxShape.circle,
              ),
              specialDatesTextStyle: getTextTheme().titleMedium,
            ),
            monthViewSettings: DateRangePickerMonthViewSettings(
                specialDates: toursControlleradd.highlighteddatetimedata),
            selectionMode: DateRangePickerSelectionMode.single,
            onSelectionChanged: (DateRangePickerSelectionChangedArgs args) {
              DateTime selectedDate = args.value;
              if (toursControlleradd.highlighteddatetimedata!
                  .contains(selectedDate)) {
                DateTime now = DateTime.now();
                if (selectedDate.isAfter(now) ||
                    selectedDate.isAtSameMomentAs(now)) {
                  toursControlleradd.selectedDate.value = selectedDate;
                  toursControlleradd.selectDateId.value =
                      toursControlleradd.toursAvabilitydata
                          .firstWhere(
                            (element) =>
                                element.unavailableDate == selectedDate,
                            orElse: () => DateTimeModel(
                                id: -1,
                                tour: -1,
                                unavailableDate: DateTime.now()),
                          )
                          .id;
                  print(
                      "selected date id is this ${toursControlleradd.selectDateId.value}");
                  Navigator.pop(context); // Close the dialog
                } else {
                  Fluttertoast.showToast(msg: 'Please select valid date');
                }
              } else {
                Fluttertoast.showToast(
                    msg: 'Please select a highlighted date.');
              }
            },
          ),
        ),
      ),
    );
  }

  Future<dynamic> addPassenger(BuildContext context) {
    return showDialog(
        barrierDismissible: true,
        barrierColor: Colors.black.withOpacity(0.1),
        context: context,
        builder: (context1) => BackdropFilter(
              filter: ImageFilter.blur(
                sigmaX: 2,
                sigmaY: 2,
              ),
              child: AlertDialog(
                  insetPadding: EdgeInsets.zero,
                  backgroundColor: ConstColors.backgroundColor,
                  surfaceTintColor: ConstColors.backgroundColor,
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20.0))),
                  title: SizedBox(),
                  content: SizedBox(
                    width: 1500.w,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Select Date",
                          style: getTextTheme().headlineMedium,
                        ),
                        Container(
                          width: 1500.w,
                          height: 80,
                          margin: EdgeInsets.symmetric(vertical: 10),
                          decoration: BoxDecoration(
                            color: ConstColors.backgroundColor,
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: [
                              BoxShadow(
                                blurRadius: 20,
                                color: Colors.black.withOpacity(.1),
                              )
                            ],
                          ),
                          child: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 20.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Obx(() => Text(
                                      toursControlleradd.selectedDate.value
                                                      .year ==
                                                  2000 &&
                                              toursControlleradd.selectedDate
                                                      .value.month ==
                                                  7 &&
                                              toursControlleradd
                                                      .selectedDate.value.day ==
                                                  6
                                          ? ""
                                          : "${DateFormat('dd-MM-yyyy').format(toursControlleradd.selectedDate.value)}",
                                      style: getTextTheme().headlineMedium,
                                    )),
                                IconButton(
                                    onPressed: () =>
                                        showCustomDatePicker(context),
                                    icon: Icon(
                                      Icons.calendar_month,
                                      color: ConstColors.primaryColor,
                                      size: 140.sp,
                                    ))
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Text(
                          "Total Passengers",
                          style: getTextTheme().headlineMedium,
                        ),
                        Container(
                          width: 1500.w,
                          height: 80,
                          margin: EdgeInsets.symmetric(vertical: 10),
                          decoration: BoxDecoration(
                            color: ConstColors.backgroundColor,
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: [
                              BoxShadow(
                                blurRadius: 20,
                                color: Colors.black.withOpacity(.1),
                              )
                            ],
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              IconButton(
                                  onPressed: () {
                                    toursControlleradd
                                        .passengerCountDecrement();
                                  },
                                  icon: const Icon(
                                    Icons.remove,
                                    color: ConstColors.primaryColor,
                                    size: 40,
                                  )),
                              Obx(() => Text(
                                    toursControlleradd.passengerCount.value
                                        .toString(),
                                    style: getTextTheme().headlineMedium,
                                  )),
                              IconButton(
                                  onPressed: () {
                                    toursControlleradd
                                        .passengerCountIncrement();
                                  },
                                  icon: const Icon(
                                    Icons.add,
                                    color: ConstColors.primaryColor,
                                    size: 40,
                                  ))
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  actions: <Widget>[
                    InkWell(
                      onTap: () async {
                        if (toursControlleradd.selectedDate.value.year ==
                                2000 &&
                            toursControlleradd.selectedDate.value.month == 7 &&
                            toursControlleradd.selectedDate.value.day == 6) {
                          Fluttertoast.showToast(
                              msg: 'Please select a booking date.');
                        } else {
                          GetToursByIdRepo api = GetToursByIdRepo();
                          int userId = await box.read('userId');
                          print(
                              "total travel - ${toursControlleradd.passengerCount}\nuserId - $userId\ntour ID - ${widget.id}\nselected date id - ${toursControlleradd.selectDateId.value}");
                          toursControlleradd.isbookingLoading.value = true;
                          await api
                              .bookingTourDetails(
                                  toursControlleradd.passengerCount.value,
                                  userId,
                                  int.parse(widget.id),
                                  toursControlleradd.selectDateId.value)
                              .then((value) => {
                                    if (value == "true")
                                      {
                                        Navigator.of(context).pop(),
                                        Get.to(() => BookingForm(
                                              tourId: widget.id.toString(),
                                              tourName: toursControlleradd
                                                  .toursById.name,
                                              tourImage: toursControlleradd
                                                  .toursById
                                                  .tourImages
                                                  .first
                                                  .image
                                                  .toString(),
                                              tourLocation: toursControlleradd
                                                  .toursById.country
                                                  .toString(),
                                            )),
                                      }
                                  });
                          toursControlleradd.isbookingLoading.value = false;
                        }
                      },
                      child: Container(
                        height: 50,
                        width: 1500.w,
                        decoration: BoxDecoration(
                          // color:
                          //     user ? ConstColors.backgroundColor : ConstColors.lightpurple,
                          borderRadius: BorderRadius.circular(10),

                          gradient: const LinearGradient(
                            colors: [
                              Color(0xFFFF8B28),
                              Color(0xFFFF0000),
                            ],
                            //transform: GradientRotation(3.14 / 4),
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                          ),
                        ),
                        child: Obx(() => Center(
                              child: toursControlleradd.isbookingLoading.value
                                  ? CircularProgressIndicator(
                                      color: Colors.white,
                                    )
                                  : Text(
                                      'Proceed',
                                      style: getTextTheme().titleLarge,
                                    ),
                            )),
                      ),
                    ),
                  ]),
            ));
  }
}
