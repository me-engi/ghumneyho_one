import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:shimmer/shimmer.dart';


import '../../../constants/const_colors.dart';
import '../../../constants/custom_textstyle.dart';
import '../../../widgets/customDottedlines.dart';


class TourShimmer extends StatefulWidget {
  const TourShimmer({super.key});

  @override
  State<TourShimmer> createState() => _CalCulusShimmerState();
}

class _CalCulusShimmerState extends State<TourShimmer> {
  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      child: Column(
        children: [
          Container(
            margin:  EdgeInsets.symmetric(vertical: 11.h, horizontal: 80.w),
            width: 1920.w,
            height: 240.h,
            decoration: BoxDecoration(
                // image: DecorationImage(
                //     fit: BoxFit.cover,
                //     image: NetworkImage(toursControlleradd
                //         .toursById
                //         .tourImages![
                //             toursControlleradd.imageIndex.value]
                //         .image!)),
                borderRadius: BorderRadius.circular(30),
                color: Colors.grey),
          ),
          Padding(
            padding:  EdgeInsets.symmetric(vertical: 11.h, horizontal: 80.w),
            child: Row(
              children: [
                Text(
                  'More Images',
                  style: getTextTheme().headlineMedium,
                ),
              ],
            ),
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Padding(
              padding: EdgeInsets.only(left: 80.w),
              child: Row(
                children: List.generate(
                    6,
                        (index) {
                      return Container(
                        margin: EdgeInsets.symmetric(
                            horizontal: 35.w, vertical: 6),
                        height: 350.sp,
                        width: 350.sp,
                        decoration: BoxDecoration(
                            boxShadow: const [
                              BoxShadow(
                                  color: ConstColors.primaryColor,
                                  blurRadius: 4,
                                  spreadRadius: 1)
                            ],
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.grey),
                      );
                    }),
              ),
            ),
          ),
         /* SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Padding(
              padding: EdgeInsets.only(left: 10.w),
              child: Row(
                children: List.generate(6, (index) {
                  return GestureDetector(
                    onTap: () {
                      //toursControlleradd.imageIndex.value = index;
                    },
                    child: Container(
                      margin:
                          EdgeInsets.symmetric(horizontal: 5.w, vertical: 5),
                      height: 70.sp,
                      width: 70.sp,
                      decoration: BoxDecoration(

                          // image: DecorationImage(
                          //     fit: BoxFit.cover,
                          //     image: NetworkImage(toursControlleradd
                          //         .toursById
                          //         .tourImages![index]
                          //         .image!)),
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.grey),
                    ),
                  );
                }),
              ),
            ),
          ),*/
          Gap(53.h),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 0.h, horizontal: 80.w),
            child: Container(
              height: 10,
              width: 1696.w,
              decoration: BoxDecoration(
                  color: Colors.grey, borderRadius: BorderRadius.circular(10)),
            ),
          ),
          Gap(4.h),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 0.h, horizontal: 80.w),
            child: Container(
              height: 10,
              width: 1696.w,
              decoration: BoxDecoration(
                  color: Colors.grey, borderRadius: BorderRadius.circular(10)),
            ),
          ),
          Gap(4.h),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 0.h, horizontal: 80.w),
            child: Container(
              height: 10,
              width: 1696.w,
              decoration: BoxDecoration(
                  color: Colors.grey, borderRadius: BorderRadius.circular(10)),
            ),
          ),
          Gap(53.h),
          // Padding(
          //   padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 80.w),
          //   child: Text(
          //     'Mount Everest is Earth\'s highest mountain above sea level, located in the Mahalangur Himal sub-range of the Himalayas.',
          //     style: getTextTheme().headlineSmall,
          //   ),
          // ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 0.h, horizontal: 80.w),
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
            padding:
            EdgeInsets.symmetric(vertical: 11.h, horizontal: 80.w),
            child: ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount:
                5,
                itemBuilder: (context, index) {
                  return index % 2 == 0
                      ? Container(
                    width: 1920.w,
                    height: index ==
                        (5 - 1)
                        ? 100
                        : 180,
                    child: Stack(
                      children: [
                        Positioned(
                          top: 0,
                          right: 0,
                          child: SizedBox(
                            width: 1300.w,
                            height: 100,
                            child: Column(
                                crossAxisAlignment:
                                CrossAxisAlignment.start,
                                children: List.generate(
                                  4,
                                      (index) => Container(
                                    margin:
                                    EdgeInsets.symmetric(vertical: 4),
                                    height: 10,
                                    width: 1275.w,
                                    decoration: BoxDecoration(
                                        color: Colors.grey,
                                        borderRadius:
                                        BorderRadius.circular(10)),
                                  ),
                                )),
                          ),
                        ),
                        Positioned(
                            bottom: -104,
                            right: 132.w,
                            child: index ==
                                (5 -
                                    1)
                                ? const SizedBox()
                                : const LefttoRightCurve(
                                color: Colors.black)),
                        Positioned(
                          top: 2,
                          left: 53.w,
                          child: Container(
                            height: 180.sp,
                            width: 180.sp,
                            decoration: BoxDecoration(
                              // color:
                              //     user ? ConstColors.backgroundColor : ConstColors.lightpurple,
                              borderRadius: BorderRadius.circular(50),
                              // boxShadow: const [
                              //   BoxShadow(
                              //     color: ConstColors.shadowColor,
                              //     spreadRadius: 4,
                              //     blurRadius: 4,
                              //   )
                              // ],
                              gradient: const LinearGradient(
                                colors: [
                                  Color(0xFFFF0000),
                                  Color(0xFFFF8B28),
                                ],
                                transform: GradientRotation(3.14 / 4),
                                begin: Alignment(-1.0, -1),
                                end: Alignment(-1.0, 1),
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
                        (5 -
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
                            width: 1300.w,
                            height: 100,
                            child: Column(
                                crossAxisAlignment:
                                CrossAxisAlignment.start,
                                children: List.generate(
                                  4,
                                      (index) => Container(
                                    margin:
                                    EdgeInsets.symmetric(vertical: 4),
                                    height: 10,
                                    width: 1275.w,
                                    decoration: BoxDecoration(
                                        color: Colors.grey,
                                        borderRadius:
                                        BorderRadius.circular(10)),
                                  ),
                                )),
                          ),
                        ),
                        Positioned(
                            bottom: -104,
                            left: 180.w,
                            child: index ==
                                (5 -
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
                              borderRadius: BorderRadius.circular(50),
                              // boxShadow: const [
                              //   BoxShadow(
                              //     color: ConstColors.shadowColor,
                              //     spreadRadius: 4,
                              //     blurRadius: 4,
                              //   )
                              // ],
                              gradient: const LinearGradient(
                                colors: [
                                  Color(0xFFFF0000),
                                  Color(0xFFFF8B28),
                                ],
                                transform: GradientRotation(3.14 / 4),
                                begin: Alignment(-1.0, -1),
                                end: Alignment(-1.0, 1),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                }),
          ),

         /* Padding(
            padding: EdgeInsets.symmetric(vertical: 53.h, horizontal: 80.w),
            child: ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: 5,
                itemBuilder: (context, index) {
                  return index % 2 == 0
                      ? Container(
                          width: 1920.w,
                          height: index == (5 - 1) ? 100 : 180,
                          child: Stack(
                            children: [
                              Positioned(
                                top: 0,
                                right: 0,
                                child: SizedBox(
                                  width: 1378.w,
                                  height: 100,
                                  child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: List.generate(
                                        4,
                                        (index) => Container(
                                          margin:
                                              EdgeInsets.symmetric(vertical: 4),
                                          height: 53,
                                          width: 1378.w,
                                          decoration: BoxDecoration(
                                              color: Colors.grey,
                                              borderRadius:
                                                  BorderRadius.circular(10)),
                                        ),
                                      )),
                                ),
                              ),
                              Positioned(
                                  bottom: -104,
                                  right: 25.w,
                                  child: index == (5 - 1)
                                      ? SizedBox()
                                      : LefttoRightCurve(color: Colors.black)),
                              Positioned(
                                top: 0,
                                left: 53.w,
                                child: Container(
                                  height: 180.sp,
                                  width: 180.sp,
                                  decoration: BoxDecoration(
                                    // color:
                                    //     user ? ConstColors.backgroundColor : ConstColors.lightpurple,
                                    borderRadius: BorderRadius.circular(50),

                                    gradient: const LinearGradient(
                                      colors: [
                                        Color(0xFFFF0000),
                                        Color(0xFFFF8B28),
                                      ],
                                      transform: GradientRotation(3.14 / 4),
                                      begin: Alignment(-1.0, -1),
                                      end: Alignment(-1.0, 1),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )
                      : Container(
                          width: 1920.w,
                          height: index == (5 - 1) ? 100 : 180,
                          //   color: Colors.green,
                          child: Stack(
                            children: [
                              Positioned(
                                top: 0,
                                left: 0,
                                child: SizedBox(
                                  width: 270.w,
                                  height: 100,
                                  child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: List.generate(
                                        4,
                                        (index) => Container(
                                          margin:
                                              EdgeInsets.symmetric(vertical: 4),
                                          // width: 1378.w,
                                          // height: 100,
                                          decoration: BoxDecoration(
                                              color: Colors.grey,
                                              borderRadius:
                                                  BorderRadius.circular(10)),
                                        ),
                                      )),
                                ),
                              ),
                              Positioned(
                                  bottom: -104,
                                  left: 30.w,
                                  child: index == (5 - 1)
                                      ? SizedBox.shrink()
                                      : RightToLeftCurve(color: Colors.black)),
                              Positioned(
                                top: 2,
                                right: 53.w,
                                child: Container(
                                  height: 180.sp,
                                  width: 180.sp,
                                  decoration: BoxDecoration(
                                    // color:
                                    //     user ? ConstColors.backgroundColor : ConstColors.lightpurple,
                                    borderRadius: BorderRadius.circular(50),
                                    // boxShadow: const [
                                    //   BoxShadow(
                                    //     color: ConstColors.shadowColor,
                                    //     spreadRadius: 4,
                                    //     blurRadius: 4,
                                    //   )
                                    // ],
                                    gradient: const LinearGradient(
                                      colors: [
                                        Color(0xFFFF0000),
                                        Color(0xFFFF8B28),
                                      ],
                                      transform: GradientRotation(3.14 / 4),
                                      begin: Alignment(-1.0, -1),
                                      end: Alignment(-1.0, 1),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                }),
          ),*/
        ],
      ),
    );
  }
}
