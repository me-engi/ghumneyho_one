import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:like_button/like_button.dart';
import 'package:shimmer/shimmer.dart';

import '../../constants/const_colors.dart';
import '../../constants/custom_textstyle.dart';
import '../home_page/controller/home_controller.dart';
import '../home_page/home_repo/home_Repo.dart';
import '../tour_info/tour_info.dart';

class FavTours extends StatefulWidget {
  const FavTours({super.key});

  @override
  State<FavTours> createState() => _FavToursState();
}

class _FavToursState extends State<FavTours> {
  var homeController = Get.put(HomeController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(
        () => Column(
          children: [
            if (homeController.isLoadingFav.value) ...[
              Shimmer.fromColors(
                baseColor: Colors.grey.shade300,
                highlightColor: Colors.grey.shade100,
                child: Column(
                  children: [
                    // Container(
                    //   margin: EdgeInsets.symmetric(
                    //       vertical: 11.h, horizontal: 80.w),
                    //   width: 1920.w,
                    //   height: 60.h,
                    //   decoration: BoxDecoration(
                    //       // image: DecorationImage(
                    //       //     fit: BoxFit.cover,
                    //       //     image: NetworkImage(toursControlleradd
                    //       //         .toursById
                    //       //         .tourImages![
                    //       //             toursControlleradd.imageIndex.value]
                    //       //         .image!)),
                    //       borderRadius: BorderRadius.circular(30),
                    //       color: Colors.grey),
                    // ),
                    // Gap(18.h),
                    // Padding(
                    //   padding: EdgeInsets.symmetric(horizontal: 80.0.w),
                    //   child: Row(
                    //     children: [
                    //       Text(
                    //         "POPULAR PLACES",
                    //         style: getTextTheme().headlineMedium,
                    //       ),
                    //     ],
                    //   ),
                    // ),
                    // Container(
                    //   margin:
                    //       EdgeInsets.symmetric(vertical: 1.h, horizontal: 80.w),
                    //   width: 1920.w,
                    //   height: 176.h,
                    //   decoration: BoxDecoration(
                    //       // image: DecorationImage(
                    //       //     fit: BoxFit.cover,
                    //       //     image: NetworkImage(toursControlleradd
                    //       //         .toursById
                    //       //         .tourImages![
                    //       //             toursControlleradd.imageIndex.value]
                    //       //         .image!)),
                    //       borderRadius: BorderRadius.circular(30),
                    //       color: Colors.grey),
                    // ),
                    // Padding(
                    //   padding: EdgeInsets.symmetric(horizontal: 80.w),
                    //   child: Row(
                    //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //     children: [
                    //       Text(
                    //         "TRENDING PLACES",
                    //         style: getTextTheme().headlineMedium,
                    //       ),
                    //       Text(
                    //         "See all",
                    //         style: getTextTheme().displaySmall,
                    //       ),
                    //     ],
                    //   ),
                    // ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 80.0.w),
                      child: GridView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisSpacing: 0.0,
                          crossAxisSpacing: 0.0,
                        ),
                        itemCount: 6,
                        itemBuilder: (BuildContext context, int index) {
                          return Container(
                            margin: const EdgeInsets.all(10.0),
                            height: 50.h,
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
                          );
                        },
                      ),
                    )
                  ],
                ),
              )
            ] else if (homeController.favListTours!.isEmpty) ...[
              SizedBox(
                height: 900.h,
                child: Center(
                  child: Text(
                    'No Liked Tours',
                    style: getTextTheme().headlineMedium,
                  ),
                ),
              )
            ] else ...[
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 80.0.w),
                child: GridView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 0.0,
                    crossAxisSpacing: 0.0,
                  ),
                  itemCount: homeController.favListTours?.length,
                  itemBuilder: (BuildContext context, int index) {
                    return GestureDetector(
                      onTap: () {
                        Get.to(() => TourInfo(
                            id: homeController.favListTours![index]["tour"]
                                    ['id']
                                .toString(),
                            name: homeController.favListTours?[index]["tour"]
                                ['name']));
                      },
                      child: Container(
                          margin: const EdgeInsets.all(10.0),
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              fit: BoxFit.fill,
                              image: NetworkImage(homeController
                                      .favListTours![index]["tour"]
                                          ['tour_images']
                                      .isEmpty
                                  ? "https://cdn-icons-png.freepik.com/512/15114/15114626.png"
                                  : homeController.favListTours![index]["tour"]
                                      ['tour_images'][0]['image_url']),
                            ),
                            color: Colors.grey,
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: const [
                              BoxShadow(
                                  color: ConstColors.shadowColor,
                                  blurRadius: 4,
                                  offset: Offset(1, 2),
                                  spreadRadius: 1)
                            ],
                          ),
                          child: Stack(
                            children: [
                              Positioned(
                                top: 0,
                                right: 0,
                                child: Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: LikeButton(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    isLiked: true,
                                    onTap: (isLiked) async {
                                      HomeRepo api = HomeRepo();
                                      log("this is like $isLiked");
                                      // setState(() {
                                      //   homeController.favListTours!
                                      //       .removeAt(index);
                                      // });
                                      await api.dislikeTour(homeController
                                          .favListTours![index]["tour"]['id']
                                          .toString());
                                      await homeController.getFavDataRecall();
                                      setState(() {});

                                      return !isLiked;
                                    },
                                    likeBuilder: (bool isLiked) {
                                      return Icon(
                                        Icons.favorite,
                                        color: isLiked
                                            ? Colors.red
                                            : Colors.black54,
                                        size: 35,
                                      );
                                    },
                                  ),
                                ),
                              ),
                              Center(
                                  child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  homeController.favListTours?[index]["tour"]
                                      ['name'],
                                  style: getTextTheme().titleMedium,
                                  textAlign: TextAlign.center,
                                ),
                              )),
                            ],
                          )),
                    );
                  },
                ),
              ),
            ]
          ],
        ),
      ),
    );
  }
}
