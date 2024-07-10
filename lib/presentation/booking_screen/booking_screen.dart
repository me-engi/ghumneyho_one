import 'dart:developer';
import 'dart:io';
import 'dart:ui';

import 'package:email_validator/email_validator.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:toursandtravels/constants/const_colors.dart';
import 'package:toursandtravels/constants/custom_textstyle.dart';
import 'package:toursandtravels/presentation/booking_screen/booking_repo/booking_repo.dart';
import 'package:toursandtravels/widgets/accordin.dart';
import 'package:toursandtravels/widgets/custom_dialog.dart';
import 'package:toursandtravels/widgets/custom_textfield.dart';

import '../../utils/number_to_words.dart';
import '../payment_screen/payment_screen.dart';
import '../tour_info/tour_controller/tour_controller.dart';

class BookingForm extends StatefulWidget {
  const BookingForm(
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
  State<BookingForm> createState() => _BookingFormState();
}

class _BookingFormState extends State<BookingForm> {
  var toursControlleradd = Get.put(TourController());

  // String selectedGender = "Male";
  // String idProof = "Citizenship";
  bool validateFormAll() {
    if (toursControlleradd.formkeys[0].currentState != null) {
      for (int i = 0; i < toursControlleradd.passengerCount.value; i++) {
        if (!toursControlleradd.formkeys[i].currentState!.validate()) {
          return false;
        }
      }
      return true;
    } else {
      Fluttertoast.showToast(msg: "Please Fill all the details");
      return false;
    }
  }

  exitDialog() {
    return showDialog(
        barrierDismissible: true,
        barrierColor: ConstColors.textColor.withOpacity(0.1),
        context: context,
        builder: (context) => customDialogueWithCancel(
              backgroundColor: ConstColors.backgroundColor,
              content: "Are you sure you want to go back?",
              dismissBtnTitle: "Yes",
              onClick: () {
                toursControlleradd.clearAllList();
                toursControlleradd.initialAddOn();
                toursControlleradd.passengerCount.value = 1;
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
          bottomNavigationBar: GestureDetector(
            onTap: () async {
              BookingRepo api = BookingRepo();
              if (validateFormAll()) {
                print("payment proccessing");
                toursControlleradd.ispersonbookingLoading.value = true;
                int count = 0;

                try {
                  for (int i = 0;
                      i < toursControlleradd.passengerCount.value;
                      i++) {
                    await api.bookingPersonDetails(
                        "2",
                        "${i + 1}",
                        "${toursControlleradd.nameControllers[i].value.text} ${toursControlleradd.surnameControllers[i].value.text}",
                        toursControlleradd.contactControllers[i].value.text,
                        toursControlleradd.emailControllers[i].value.text,
                        toursControlleradd.idType[i].value,
                        toursControlleradd.idTypesFiles[i].value,
                        toursControlleradd.photoFiles[i].value,
                        toursControlleradd.ageControllers[i].value.text,
                        toursControlleradd.genderList[i].value);
                    count++;
                  }
                  toursControlleradd.ispersonbookingLoading.value = false;
                  if (count == toursControlleradd.passengerCount.value) {
                    Get.off(() => PaymentScreen(
                          tourId: widget.tourId,
                          tourName: widget.tourName,
                          tourImage: widget.tourImage,
                          tourLocation: widget.tourLocation,
                        ));
                  }
                } on Exception catch (e) {
                  rethrow;
                }
              }
            },
            child: Container(
                margin:
                    const EdgeInsets.symmetric(vertical: 14.0, horizontal: 15),
                height: 50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  gradient: const LinearGradient(
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                    colors: [ConstColors.primaryColor, ConstColors.red],
                  ),
                ),
                child: Obx(() => Center(
                      child: toursControlleradd.ispersonbookingLoading.value
                          ? CircularProgressIndicator(
                              color: Colors.white,
                            )
                          : Text(
                              "Procced To Payment",
                              style: getTextTheme().titleMedium,
                            ),
                    ))),
          ),
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
          ),
          body: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Stepper(toursControlleradd: toursControlleradd),
                ListView.builder(
                    itemCount: toursControlleradd.passengerCount.value,
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      return Accordion(
                          showContent: true,
                          title:
                              "Add ${numberToWords(index + 1)} Passenger Details",
                          onClick: SizedBox(
                            child: Form(
                              key: toursControlleradd.formkeys[index],
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      Expanded(
                                        child: CustomTextFormField(
                                            customText: "Name",
                                            controller: toursControlleradd
                                                .nameControllers[index],
                                            validator: (value) {
                                              if (value!.isEmpty) {
                                                return 'Please enter Name';
                                              }
                                              return null;
                                            },
                                            inputFormatters: [],
                                            onChanged: (value) {}),
                                      ),
                                      const Gap(20),
                                      Expanded(
                                        child: CustomTextFormField(
                                            customText: "Surname",
                                            controller: toursControlleradd
                                                .surnameControllers[index],
                                            validator: (value) {
                                              if (value!.isEmpty) {
                                                return 'Please enter Surname';
                                              }
                                              return null;
                                            },
                                            inputFormatters: [],
                                            onChanged: (value) {}),
                                      ),
                                    ],
                                  ),
                                  Gap(20),
                                  CustomTextFormField(
                                      customText: "Email",
                                      controller: toursControlleradd
                                          .emailControllers[index],
                                      validator: (value) {
                                        if (EmailValidator.validate(value!) ==
                                            false) {
                                          return 'Please enter valid Email';
                                        }
                                        return null;
                                      },
                                      inputFormatters: [],
                                      onChanged: (value) {}),
                                  Gap(20),
                                  CustomTextFormField(
                                      customText: "Contact No.",
                                      keyoardType: TextInputType.phone,
                                      controller: toursControlleradd
                                          .contactControllers[index],
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return 'Please enter Surname';
                                        }
                                        return null;
                                      },
                                      inputFormatters: [
                                        FilteringTextInputFormatter.digitsOnly,
                                      ],
                                      onChanged: (value) {}),
                                  Gap(20),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: DropdownButtonFormField<String>(
                                          value: toursControlleradd
                                              .genderList[index].value,
                                          onChanged: (String? newValue) {
                                            toursControlleradd.genderList[index]
                                                .value = newValue!;
                                          },
                                          decoration: InputDecoration(
                                            label: const Text("Gender",
                                                style: const TextStyle(
                                                    fontWeight: FontWeight.w500,
                                                    color: Color(0xFFC5C5C5))),
                                            //suffixIcon: iconss,
                                            hintStyle: const TextStyle(
                                                fontWeight: FontWeight.w500,
                                                color: Color(0xFFC5C5C5)),
                                            errorStyle: const TextStyle(
                                                height: 0,
                                                color: ConstColors.red),
                                            filled: true,
                                            fillColor: ConstColors
                                                .backgroundColor
                                                .withOpacity(.7),
                                            contentPadding:
                                                const EdgeInsets.symmetric(
                                                    vertical: 15,
                                                    horizontal: 16),
                                            focusedBorder:
                                                const OutlineInputBorder(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(10)),
                                              borderSide: BorderSide(
                                                  width: .6,
                                                  color:
                                                      ConstColors.primaryColor),
                                            ),
                                            disabledBorder:
                                                const OutlineInputBorder(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(10)),
                                              borderSide: BorderSide(
                                                  width: .6,
                                                  color:
                                                      ConstColors.primaryColor),
                                            ),
                                            enabledBorder:
                                                const OutlineInputBorder(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(10)),
                                              borderSide: BorderSide(
                                                  width: .6,
                                                  color:
                                                      ConstColors.primaryColor),
                                            ),
                                            border: const OutlineInputBorder(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(10)),
                                              borderSide: BorderSide(width: .6),
                                            ),
                                            errorBorder:
                                                const OutlineInputBorder(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(10)),
                                              borderSide: BorderSide(
                                                  width: .6,
                                                  color: ConstColors.red),
                                            ),
                                            focusedErrorBorder:
                                                const OutlineInputBorder(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(10)),
                                              borderSide: BorderSide(
                                                  width: .6,
                                                  color: ConstColors.red),
                                            ),
                                          ),
                                          isExpanded: true,
                                          items: <String>[
                                            'Male',
                                            'Female',
                                            'Other'
                                          ].map<DropdownMenuItem<String>>(
                                              (String value) {
                                            return DropdownMenuItem<String>(
                                              value: value,
                                              child: Text(
                                                value,
                                                style: getTextTheme()
                                                    .headlineMedium,
                                              ),
                                            );
                                          }).toList(),
                                        ),
                                      ),
                                      const Gap(20),
                                      Expanded(
                                        child: CustomTextFormField(
                                            customText: "Age",
                                            keyoardType: TextInputType.number,
                                            controller: toursControlleradd
                                                .ageControllers[index],
                                            validator: (value) {
                                              if (value!.isEmpty) {
                                                return 'Please enter Age';
                                              }
                                              return null;
                                            },
                                            inputFormatters: [],
                                            onChanged: (value) {}),
                                      ),
                                    ],
                                  ),
                                  Gap(20),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: DropdownButtonFormField<String>(
                                          value: toursControlleradd
                                              .idType[index].value,
                                          onChanged: (String? newValue) {
                                            toursControlleradd.idType[index]
                                                .value = newValue!;
                                          },
                                          decoration: InputDecoration(
                                            label: const Text("ID Type",
                                                style: const TextStyle(
                                                    fontWeight: FontWeight.w500,
                                                    color: Color(0xFFC5C5C5))),
                                            //suffixIcon: iconss,
                                            hintStyle: const TextStyle(
                                                fontWeight: FontWeight.w500,
                                                color: Color(0xFFC5C5C5)),
                                            errorStyle: const TextStyle(
                                                height: 0,
                                                color: ConstColors.red),
                                            filled: true,
                                            fillColor: ConstColors
                                                .backgroundColor
                                                .withOpacity(.7),
                                            contentPadding:
                                                const EdgeInsets.symmetric(
                                                    vertical: 15,
                                                    horizontal: 16),
                                            focusedBorder:
                                                const OutlineInputBorder(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(10)),
                                              borderSide: BorderSide(
                                                  width: .6,
                                                  color:
                                                      ConstColors.primaryColor),
                                            ),
                                            disabledBorder:
                                                const OutlineInputBorder(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(10)),
                                              borderSide: BorderSide(
                                                  width: .6,
                                                  color:
                                                      ConstColors.primaryColor),
                                            ),
                                            enabledBorder:
                                                const OutlineInputBorder(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(10)),
                                              borderSide: BorderSide(
                                                  width: .6,
                                                  color:
                                                      ConstColors.primaryColor),
                                            ),
                                            border: const OutlineInputBorder(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(10)),
                                              borderSide: BorderSide(width: .6),
                                            ),
                                            errorBorder:
                                                const OutlineInputBorder(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(10)),
                                              borderSide: BorderSide(
                                                  width: .6,
                                                  color: ConstColors.red),
                                            ),
                                            focusedErrorBorder:
                                                const OutlineInputBorder(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(10)),
                                              borderSide: BorderSide(
                                                  width: .6,
                                                  color: ConstColors.red),
                                            ),
                                          ),
                                          isExpanded: true,
                                          items: <String>[
                                            'Aadhar Card',
                                            'Citizenship',
                                            'Passport'
                                          ].map<DropdownMenuItem<String>>(
                                              (String value) {
                                            return DropdownMenuItem<String>(
                                              value: value,
                                              child: Text(value,
                                                  style: getTextTheme()
                                                      .headlineMedium),
                                            );
                                          }).toList(),
                                        ),
                                      ),
                                      const Gap(20),
                                      Obx(() => Expanded(
                                          child: toursControlleradd
                                                      .idFileName[index]
                                                      .value ==
                                                  ""
                                              ? ElevatedButton(
                                                  style:
                                                      ElevatedButton.styleFrom(
                                                          backgroundColor:
                                                              ConstColors
                                                                  .shadowColor),
                                                  onPressed: () async {
                                                    await selectID(index);
                                                  },
                                                  child: Text(
                                                    'Choose File',
                                                    style: getTextTheme()
                                                        .titleMedium,
                                                  ),
                                                )
                                              : Row(
                                                  children: [
                                                    SizedBox(
                                                      width: 600.w,
                                                      child: Text(
                                                        toursControlleradd
                                                            .idFileName[index]
                                                            .value,
                                                        maxLines: 2,
                                                      ),
                                                    ),
                                                    IconButton(
                                                        onPressed: () async {
                                                          await selectID(index);
                                                        },
                                                        icon: Icon(Icons.close))
                                                  ],
                                                ))),
                                    ],
                                  ),
                                  Gap(20),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: CustomTextFormField(
                                            readOnly: true,
                                            customText: "",
                                            controller: TextEditingController(
                                                text: "Photo"),
                                            validator: (value) {
                                              return null;
                                            },
                                            inputFormatters: const [],
                                            onChanged: (value) {}),
                                      ),
                                      const Gap(20),
                                      Obx(() => Expanded(
                                          child: toursControlleradd
                                                      .photoFileName[index]
                                                      .value ==
                                                  ""
                                              ? ElevatedButton(
                                                  style:
                                                      ElevatedButton.styleFrom(
                                                          backgroundColor:
                                                              ConstColors
                                                                  .shadowColor),
                                                  onPressed: () async {
                                                    await selectPhoto(index);
                                                  },
                                                  child: Text(
                                                    'Choose File',
                                                    style: getTextTheme()
                                                        .titleMedium,
                                                  ),
                                                )
                                              : Row(
                                                  children: [
                                                    SizedBox(
                                                      width: 600.w,
                                                      child: Text(
                                                          toursControlleradd
                                                              .photoFileName[
                                                                  index]
                                                              .value),
                                                    ),
                                                    IconButton(
                                                        onPressed: () async {
                                                          await selectPhoto(
                                                              index);
                                                        },
                                                        icon: Icon(Icons.close))
                                                  ],
                                                ))),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ));
                    }),
                const Gap(80)
              ],
            ),
          )),
    );
  }

  Future<void> selectPhoto(int index) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      allowMultiple: false,
      type: FileType.custom,
      allowedExtensions: [
        'jpg',
        'jpeg',
        'png',
        'HEIC',
      ],
    );
    // log("path is ${result!.files}");
    if (result != null) {
      File file = File(result.files.single.path!);

      int maxSizeInBytes = 1 * 1024 * 1024; // 10MB
      if (file.lengthSync() > maxSizeInBytes) {
        Fluttertoast.showToast(
          msg: "Please select file size less than 1mb",
        );
      } else {
        log("No file selected ${result.files.single.path!}");
        toursControlleradd.photoFileName[index].value =
            result.files.single.path!.split('/').last;
        toursControlleradd.photoFiles[index] =
            File(result.files.single.path!).obs;
      }
    } else {
      log("No file selected");
    }
  }

  Future<void> selectID(int index) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      allowMultiple: false,
      type: FileType.custom,
      allowedExtensions: [
        'jpg',
        'pdf',
        'jpeg',
        'png',
        'HEIC',
      ],
    );
    // log("path is ${result!.files}");
    if (result != null) {
      File file = File(result.files.single.path!);

      int maxSizeInBytes = 1 * 1024 * 1024; // 10MB
      if (file.lengthSync() > maxSizeInBytes) {
        Fluttertoast.showToast(
          msg: "Please select file size less than 1mb",
        );
      } else {
        toursControlleradd.idFileName[index].value =
            result.files.single.path!.split('/').last;
        log("No file selected ${result.files.single.path!}");
        toursControlleradd.idTypesFiles[index] =
            File(result.files.single.path!).obs;
      }
    } else {
      log("No file selected");
    }
  }
}

class Stepper extends StatelessWidget {
  Stepper({
    super.key,
    required this.toursControlleradd,
  });

  final TourController toursControlleradd;

  final List<String> stepperTitle = [
    'Tour detail',
    'Passenger detail',
    'Payment',
    'Booking Confirmed'
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20.0),
      child: Column(
        children: [
          Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(4, (index) {
                return Row(
                  children: [
                    Obx(
                      () => Container(
                        height: 150.sp,
                        width: 150.sp,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            gradient: LinearGradient(
                              colors: [
                                toursControlleradd.currentStepperCount.value <
                                        index
                                    ? ConstColors.shadowColor
                                    : Color(0xFFFF0000),
                                toursControlleradd.currentStepperCount.value <
                                        index
                                    ? ConstColors.shadowColor
                                    : Color(0xFFFF8B28),
                              ],
                              transform: GradientRotation(3.14 / 4),
                              begin: Alignment(-1.0, -1),
                              end: Alignment(-1.0, 1),
                            )),
                        child: Center(
                          child: Text(
                            "${index + 1}",
                            style: getTextTheme().displayLarge,
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ),
                    index == 3
                        ? const SizedBox.shrink()
                        : Container(
                            height: 20.sp,
                            width: 350.w,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(0),
                                gradient: LinearGradient(
                                  colors: [
                                    toursControlleradd
                                                .currentStepperCount.value <=
                                            index
                                        ? ConstColors.shadowColor
                                        : Color(0xFFFF0000),
                                    toursControlleradd
                                                .currentStepperCount.value <=
                                            index
                                        ? ConstColors.shadowColor
                                        : Color(0xFFFF8B28),
                                  ],
                                  //transform: GradientRotation(3.14 / 4),
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                )),
                          ),
                  ],
                );
              })),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    stepperTitle[0],
                    style: getTextTheme().bodyMedium,
                  ),
                  SizedBox(
                    width: 900.w,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          stepperTitle[1],
                          style: getTextTheme().bodyMedium,
                        ),
                        Text(
                          stepperTitle[2],
                          style: getTextTheme().bodyMedium,
                        )
                      ],
                    ),
                  ),
                  Text(
                    stepperTitle[3],
                    style: getTextTheme().bodyMedium,
                  )
                ]),
          ),
        ],
      ),
    );
  }
}
