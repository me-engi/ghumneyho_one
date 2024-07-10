import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/route_manager.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../constants/const_colors.dart';
import '../../constants/custom_textstyle.dart';

Future<Object?> CustomSignInDialog(
    String heading, String discription, BuildContext context,
    {required ValueChanged onClosed}) {
  return showGeneralDialog(
      barrierDismissible: true,
      barrierLabel: "Register",
      barrierColor: Colors.transparent,
      context: context,
      transitionDuration: const Duration(milliseconds: 400),
      transitionBuilder: (context, animation, secondaryAnimation, child) {
        Tween<Offset> tween;
        tween = Tween(begin: const Offset(0, 1), end: Offset.zero);
        return SlideTransition(
          position: tween.animate(
              CurvedAnimation(parent: animation, curve: Curves.easeInOut)),
          child: child,
        );
      },
      pageBuilder: ((context, _, __) => BackdropFilter(
            filter: ImageFilter.blur(
              sigmaX: 3,
              sigmaY: 3,
            ),
            child: Center(
                child: Container(
              width: Get.width < 800 ? Get.width * .8 : Get.width / 2,
              height: Get.height * .5,
              padding: EdgeInsets.symmetric(horizontal: 60.w, vertical: 30.h),
              margin: EdgeInsets.symmetric(horizontal: 30.w),
              decoration: BoxDecoration(
                  color: ConstColors.backgroundColor.withOpacity(.94),
                  boxShadow: [
                    BoxShadow(
                        color: ConstColors.shadowColor,
                        spreadRadius: 1,
                        blurRadius: 14)
                  ],
                  borderRadius: const BorderRadius.all(Radius.circular(10))),
              child: Scaffold(
                  resizeToAvoidBottomInset: false,
                  backgroundColor: Colors.transparent,
                  body: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              heading,
                              maxLines: 2,
                              style: Get.width < 800
                                  ? getTextTheme().headlineMedium
                                  : GoogleFonts.montserrat(
                                      fontWeight: FontWeight.w600,
                                      color: ConstColors.textColor,
                                      fontSize: 24,
                                    ),
                            ),
                          ],
                        ),
                        Gap(10.h),
                        Text(
                          discription,
                          style: Get.width < 800
                              ? getTextTheme().bodyMedium
                              : GoogleFonts.montserrat(
                                  fontWeight: FontWeight.w400,
                                  color: ConstColors.textColor,
                                  fontSize: 16,
                                ),
                        ),
                      ],
                    ),
                  )),
            )),
          ))).then((onClosed));
}
