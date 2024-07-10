import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:toursandtravels/constants/custom_textstyle.dart';
import 'package:toursandtravels/presentation/payment_screen/payment_controller/payment_controller.dart';
import 'package:toursandtravels/presentation/tour_info/tour_controller/tour_controller.dart';
import 'package:toursandtravels/widgets/custom_textfield.dart';

import '../../constants/const_colors.dart';
import '../../widgets/custom_dialog.dart';

class PaymentScreen extends StatefulWidget {
  const PaymentScreen(
      {super.key,
      required this.tourId,
      required this.tourName,
      required this.tourImage,
      required this.tourLocation});
  final String tourId;
  final String tourName;
  final String tourImage;
  final String tourLocation;

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  var paymentController = Get.put(PaymentController());
  var tourinfoController = Get.put(TourController());
  final couponController = TextEditingController();
  final formkey = GlobalKey<FormState>();
  exitDialog() {
    return showDialog(
        barrierDismissible: true,
        barrierColor: ConstColors.textColor.withOpacity(0.1),
        context: context,
        builder: (context) => customDialogueWithCancel(
              backgroundColor: ConstColors.backgroundColor,
              content: "Are you sure you want cancel booking?",
              dismissBtnTitle: "Yes",
              onClick: () {
                // toursControlleradd.clearAllList();
                // toursControlleradd.initialAddOn();
                // toursControlleradd.passengerCount.value = 1;
                Get.back();
                Get.back();
              },
              dismissBtnTitleStyle: TextStyle(
                  color: ConstColors.textColor,
                  fontSize: 69.sp,
                  fontWeight: FontWeight.bold),
              cancelBtnStyle: TextStyle(
                  color: ConstColors.primaryColor,
                  fontSize: 69.sp,
                  fontWeight: FontWeight.bold),
              cancelBtn: 'No',
              onCancelClick: () => Navigator.pop(context),
              title: "Hold on!",
            ));
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        return exitDialog();
      },
      child: Scaffold(
          appBar: AppBar(
            leading: IconButton(
              icon: const Icon(
                Icons.arrow_back_ios_new_rounded,
                color: ConstColors.textColor,
              ),
              onPressed: () {
                exitDialog();
              },
            ),
            centerTitle: true,
            title: Text(
              "Payment",
              style: getTextTheme().headlineMedium,
            ),
          ),
          bottomNavigationBar: Obx(
            () => paymentController.isLoading.value
                ? SizedBox.shrink()
                : Container(
                    width: double.maxFinite,
                    color: ConstColors.backgroundColor,
                    padding: EdgeInsets.all(15),
                    child: Form(
                      key: formkey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            "Coupon Code",
                            style: getTextTheme().headlineMedium,
                          ),
                          Gap(20),
                          CustomTextFormField(
                            customText: "Have coupon code",
                            controller: couponController,
                            validator: (value) {
                              if (value == "") {
                                return "Please enter coupon";
                              }
                              return null;
                            },
                            inputFormatters: [],
                            onChanged: (value) {},
                            iconss: TextButton(
                              onPressed: () {
                                if (!formkey.currentState!.validate()) {}
                              },
                              child: Text(
                                'APPLY',
                                style: getTextTheme()
                                    .displaySmall!
                                    .copyWith(decoration: TextDecoration.none),
                              ),
                            ),
                          ),
                          Gap(20),
                          Container(
                            // height: 100,
                            width: double.maxFinite,
                            padding: EdgeInsets.all(15),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(color: Colors.grey)),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'SubTotal',
                                      style: getTextTheme()
                                          .headlineSmall!
                                          .copyWith(
                                              color: Color(0xFF5B5B5B),
                                              fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      '₹100',
                                      style: getTextTheme()
                                          .headlineSmall!
                                          .copyWith(
                                              color: Color(0xFF5B5B5B),
                                              fontWeight: FontWeight.normal),
                                    )
                                  ],
                                ),
                                Gap(10),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'GST',
                                      style: getTextTheme()
                                          .headlineSmall!
                                          .copyWith(
                                              color: Color(0xFF5B5B5B),
                                              fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      '₹100',
                                      style: getTextTheme()
                                          .headlineSmall!
                                          .copyWith(
                                              color: Color(0xFF5B5B5B),
                                              fontWeight: FontWeight.normal),
                                    )
                                  ],
                                ),
                                Gap(10),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Platform charges',
                                      style: getTextTheme()
                                          .headlineSmall!
                                          .copyWith(
                                              color: Color(0xFF5B5B5B),
                                              fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      '₹100',
                                      style: getTextTheme()
                                          .headlineSmall!
                                          .copyWith(
                                              color: Color(0xFF5B5B5B),
                                              fontWeight: FontWeight.normal),
                                    )
                                  ],
                                ),
                                Gap(10),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'You saved',
                                      style: getTextTheme()
                                          .headlineSmall!
                                          .copyWith(
                                              color: Color(0xFF5B5B5B),
                                              fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      '₹100',
                                      style: getTextTheme()
                                          .headlineSmall!
                                          .copyWith(
                                              color: Color(0xFF5B5B5B),
                                              fontWeight: FontWeight.normal),
                                    )
                                  ],
                                ),
                                Gap(10),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Total',
                                      style: getTextTheme()
                                          .headlineSmall!
                                          .copyWith(
                                              color: Color(0xFF5B5B5B),
                                              fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      '₹100',
                                      style: getTextTheme()
                                          .headlineSmall!
                                          .copyWith(
                                              color: Color(0xFF5B5B5B),
                                              fontWeight: FontWeight.normal),
                                    )
                                  ],
                                ),
                                Gap(20),
                                Container(
                                  height: 50,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    gradient: const LinearGradient(
                                      begin: Alignment.centerLeft,
                                      end: Alignment.centerRight,
                                      colors: [
                                        ConstColors.primaryColor,
                                        ConstColors.red
                                      ],
                                    ),
                                  ),
                                  child:
                                      // Obx(() => Center(
                                      //       child: false
                                      //           ? CircularProgressIndicator(
                                      //               color: Colors.white,
                                      //             )
                                      //           :
                                      Center(
                                    child: Text(
                                      "PAY ₹100",
                                      style: getTextTheme().titleMedium,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
          ),
          body: Obx(
            () => paymentController.isLoading.value
                ? Center(
                    child: CircularProgressIndicator(
                      color: ConstColors.primaryColor,
                    ),
                  )
                : Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          "Booking Summery",
                          style: getTextTheme().headlineMedium,
                        ),
                        Gap(20),
                        SizedBox(
                          height: 95,
                          child: Row(
                            children: [
                              Expanded(
                                child: Image.network(
                                  widget.tourImage,
                                  fit: BoxFit.fitHeight,
                                ),
                              ),
                              Gap(20),
                              Expanded(
                                  flex: 2,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        widget.tourName,
                                        style: getTextTheme().headlineMedium,
                                        maxLines: 1,
                                      ),
                                      Text(
                                        widget.tourLocation,
                                        style: getTextTheme().headlineSmall!,
                                        maxLines: 1,
                                      ),
                                      Text(
                                        DateFormat.yMEd().format(
                                            tourinfoController
                                                .selectedDate.value),
                                        style: getTextTheme()
                                            .headlineSmall!
                                            .copyWith(color: Colors.grey),
                                        maxLines: 1,
                                      ),
                                      Text(
                                        "Timing will be provided shortly",
                                        style: getTextTheme()
                                            .headlineSmall!
                                            .copyWith(color: Colors.grey),
                                        maxLines: 1,
                                      ),
                                    ],
                                  )),
                            ],
                          ),
                        ),
                        Gap(20),
                        Text(
                          "Number of Adults : 02",
                          style: getTextTheme().headlineMedium,
                        ),
                        Gap(20),
                        Expanded(
                          child: ListView.builder(
                              itemCount: paymentController
                                  .bookingPersonsDetailsData!.length,
                              //   shrinkWrap: true,
                              physics: ScrollPhysics(),
                              itemBuilder: (context, index) {
                                return Container(
                                  height: 100,
                                  width: double.maxFinite,
                                  margin: EdgeInsets.symmetric(vertical: 10),
                                  padding: EdgeInsets.all(2),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      border: Border.all(color: Colors.grey)),
                                  child: Row(
                                    children: [
                                      SizedBox(
                                        width: 300.w,
                                        height: 100,
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          child: Image.network(
                                            "https://ghumneho.pythonanywhere.com/${paymentController.bookingPersonsDetailsData![index]['photo']}",
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                      Gap(10),
                                      Expanded(
                                          child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          FittedBox(
                                            child: Row(
                                              children: [
                                                Text(
                                                  "${paymentController.bookingPersonsDetailsData![index]['traveler_name']}",
                                                  style: getTextTheme()
                                                      .headlineSmall!
                                                      .copyWith(
                                                          color: Color(
                                                              0xFF5B5B5B)),
                                                  textWidthBasis:
                                                      TextWidthBasis.parent,
                                                  maxLines: 1,
                                                ),
                                                SizedBox(
                                                  height: 15,
                                                  child: VerticalDivider(
                                                    color: Color(0xFF5B5B5B),
                                                  ),
                                                ),
                                                Text(
                                                  paymentController
                                                          .bookingPersonsDetailsData![
                                                      index]['age'],
                                                  style: getTextTheme()
                                                      .headlineSmall!
                                                      .copyWith(
                                                          color: Color(
                                                              0xFF5B5B5B)),
                                                  maxLines: 1,
                                                ),
                                                SizedBox(
                                                  height: 15,
                                                  child: VerticalDivider(
                                                    color: Color(0xFF5B5B5B),
                                                  ),
                                                ),
                                                Text(
                                                  paymentController
                                                          .bookingPersonsDetailsData![
                                                      index]['gender'],
                                                  style: getTextTheme()
                                                      .headlineSmall!
                                                      .copyWith(
                                                          color: Color(
                                                              0xFF5B5B5B)),
                                                  maxLines: 1,
                                                ),
                                              ],
                                            ),
                                          ),
                                          Text(
                                            paymentController
                                                    .bookingPersonsDetailsData![
                                                index]['email'],
                                            style: getTextTheme()
                                                .headlineSmall!
                                                .copyWith(
                                                    color: Color(0xFF5B5B5B)),
                                            maxLines: 1,
                                          ),
                                          Text(
                                            paymentController
                                                    .bookingPersonsDetailsData![
                                                index]['phone_number'],
                                            style: getTextTheme()
                                                .headlineSmall!
                                                .copyWith(
                                                    color: Color(0xFF5B5B5B)),
                                            maxLines: 1,
                                          ),
                                        ],
                                      )),
                                    ],
                                  ),
                                );
                              }),
                        )
                      ],
                    ),
                  ),
          )),
    );
  }
}
