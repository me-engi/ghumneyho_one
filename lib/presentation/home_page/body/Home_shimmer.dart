


import 'package:flutter/material.dart';
import 'package:flutter_offline/flutter_offline.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:shimmer/shimmer.dart';

import '../../../constants/const_colors.dart';
import '../../../constants/custom_textstyle.dart';

class HomeShimmer extends StatefulWidget {
  const HomeShimmer({super.key});

  @override
  State<HomeShimmer> createState() => _HomeShimmerState();
}

class _HomeShimmerState extends State<HomeShimmer> {




  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Builder(builder: (BuildContext context) {
      return
          Shimmer.fromColors(
            baseColor: Colors.grey.shade300,
            highlightColor: Colors.grey.shade100,
            child: Column(
              children: [
                Gap(12.h),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 10.h, horizontal: 15.w),
                  width: 300.w,
                  height: 160.h,
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
                Gap(12.h),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15.0.w),
                  child: Row(
                    children: [
                      Text(
                        "POPULAR PLACES",
                        style: getTextTheme().headlineMedium,
                      ),
                    ],
                  ),
                ),

                ListView.builder(
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                      margin:
                      EdgeInsets.symmetric(horizontal: 5.w, vertical: 5),
                      height: 150.sp,
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
                    );
                  },
                ),




                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15.0.w),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "TRENDING PLACES",
                        style: getTextTheme().headlineMedium,
                      ),
                      Text(
                        "See all",
                        style: getTextTheme().displaySmall,
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15.0.w),
                  child: GridView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 0.0,
                      crossAxisSpacing: 0.0,
                    ),
                    itemCount: 5,
                    itemBuilder: (BuildContext context, int index) {
                      return Container(
                          margin: const EdgeInsets.all(10.0),
                          decoration: BoxDecoration(

                            color: ConstColors.backgroundColor,
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: const [
                              BoxShadow(
                                  color: ConstColors.shadowColor,
                                  blurRadius: 4,
                                  offset: Offset(1, 2),
                                  spreadRadius: 1)
                            ],
                          ),
                          child: Center(
                              child: Text(
                                "Kathmandu Valley",
                                style: getTextTheme().titleMedium,
                              )));
                    },
                  ),
                ),
              ],
            ),
          );
    }));
  }
}
