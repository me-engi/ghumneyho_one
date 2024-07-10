import 'dart:developer';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:like_button/like_button.dart';
import 'package:omni_datetime_picker/omni_datetime_picker.dart';
import 'package:searchfield/searchfield.dart';
import 'package:shimmer/shimmer.dart';
import 'package:toursandtravels/constants/custom_textstyle.dart';
import 'package:toursandtravels/presentation/home_page/controller/home_controller.dart';
import 'package:toursandtravels/presentation/home_page/home_repo/home_Repo.dart';
import 'package:toursandtravels/presentation/tour_info/tour_info.dart';
import '../../constants/const_colors.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  CarouselController carouselController = CarouselController();
  final focus = FocusNode();
  bool isHovering = false;

  var homeController = Get.put(HomeController());
  TextEditingController searchController = TextEditingController();
  final List<String> destinations = [
    'Bungalows and villas',
    'Activities',
    'Domestic holidays',
    'International holidays',
    'Tourist guide',
  ];
  final List<String> guideInfo = [
    'Become a tourist guide',
    'Management',
    'Privacy',
    'Customer support',
    'Terms of services',
  ];
  final List<String> accountItems = [
    'My account',
    'My bookings',
    'Cancellation',
    'My wallet',
    'Favorites',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          double availableWidth = constraints.maxWidth;
          double availableHeight = constraints.maxHeight;
          if (availableWidth <= 800) {
            return phoneScreen();
          } else {
            return webScreen(availableHeight, availableWidth);
          }
        },
      ),
    );
  }

  Widget phoneScreen() {
    return SingleChildScrollView(
      child: Obx(
        () => Column(
          children: [
            if (homeController.isLoading1.value) ...[
              Shimmer.fromColors(
                baseColor: Colors.grey.shade300,
                highlightColor: Colors.grey.shade100,
                child: Column(
                  children: [
                    Container(
                      margin: EdgeInsets.symmetric(
                          vertical: 11.h, horizontal: 80.w),
                      width: 1920.w,
                      height: 60.h,
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
                    Gap(18.h),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 80.0.w),
                      child: Row(
                        children: [
                          Text(
                            "POPULAR PLACES",
                            style: getTextTheme().headlineMedium,
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin:
                          EdgeInsets.symmetric(vertical: 1.h, horizontal: 80.w),
                      width: 1920.w,
                      height: 176.h,
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
                      padding: EdgeInsets.symmetric(horizontal: 80.w),
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
                        itemCount: 5,
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
            ] else ...[
              Gap(14.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 80.0.w),
                child: SearchField(
                  controller: searchController,
                  onTapOutside: (event) {
                    // searchController.clear();
                    FocusManager.instance.primaryFocus?.unfocus();
                  },
                  searchStyle: GoogleFonts.montserrat(
                      fontWeight: FontWeight.w400,
                      color: ConstColors.textColor,
                      fontSize: 63.sp,
                      decoration: TextDecoration.underline,
                      decorationColor: ConstColors.backgroundColor),
                  onSearchTextChanged: (query) {
                    final filter = homeController.searchlist
                        .where((element) =>
                            element.toLowerCase().contains(query.toLowerCase()))
                        .toList();
                    return filter
                        .map((e) => SearchFieldListItem<String>(e,
                            child: searchChild(e)))
                        .toList();
                  },
                  // searchStyle: getTextTheme().headlineMedium,
                  onTap: () {},
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (value) {
                    if (value == null || value.length < 4) {
                      return '';
                    }
                    return null;
                  },
                  key: const Key('searchfield'),
                  hint: 'Search by country and place',
                  itemHeight: 215.sp,
                  scrollbarDecoration: ScrollbarDecoration(),
                  //   thumbVisibility: true,
                  //   thumbColor: Colors.red,
                  //   fadeDuration: const Duration(milliseconds: 3000),
                  //   trackColor: Colors.blue,
                  //   trackRadius: const Radius.circular(10),
                  // ),

                  searchInputDecoration: InputDecoration(
                    prefixIcon: IconButton(
                        onPressed: () {},
                        icon: Icon(Icons.search_outlined,
                            size: 133.sp, color: ConstColors.primaryColor)),
                    isDense: true,
                    focusedBorder: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(30)),
                      borderSide:
                          BorderSide(width: 1, color: ConstColors.primaryColor),
                    ),
                    disabledBorder: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(30)),
                      borderSide:
                          BorderSide(width: 1, color: ConstColors.primaryColor),
                    ),
                    enabledBorder: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(30)),
                      borderSide:
                          BorderSide(width: 1, color: ConstColors.primaryColor),
                    ),
                    border: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(30)),
                      borderSide: BorderSide(width: .6),
                    ),
                    errorBorder: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(30)),
                      borderSide:
                          BorderSide(width: 1, color: ConstColors.primaryColor),
                    ),
                    focusedErrorBorder: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(30)),
                      borderSide:
                          BorderSide(width: 1, color: ConstColors.primaryColor),
                    ),
                    fillColor: ConstColors.backgroundColor,
                    filled: true,
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 20,
                    ),
                  ),
                  marginColor: Colors.white,
                  suggestionsDecoration: SuggestionDecoration(
                    color: Colors.white,
                    //border: Border.all(color: Colors.black),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  suggestions: homeController.searchlist
                      .map((e) =>
                          SearchFieldListItem<String>(e, child: searchChild(e)))
                      .toList(),
                  focusNode: focus,
                  suggestionState: Suggestion.expand,
                  onSuggestionTap: (SearchFieldListItem<String> x) {
                    log("suggestion is this ${searchController.text.split(',').first} ${searchController.text.split('.').last} ");

                    String name = searchController.text.split(',').first;
                    String id =
                        searchController.text.split('.').last.toString().trim();

                    log('final result is this $name $id');
                    Get.to(() => TourInfo(id: id, name: name));
                    searchController.clear();

                    focus.unfocus();
                  },
                ),
              ),
              Gap(14.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 80.0.w),
                child: Row(
                  children: [
                    Text(
                      "POPULAR PLACES",
                      style: getTextTheme().headlineMedium,
                    ),
                  ],
                ),
              ),
              CarouselSlider.builder(
                carouselController: carouselController,
                itemCount: homeController.popularList!
                    .length, // _homeController.popularList?.tourImages?.length,
                options: CarouselOptions(
                    enlargeStrategy: CenterPageEnlargeStrategy.scale,
                    clipBehavior: Clip.antiAlias,
                    aspectRatio: Get.width / Get.height * 4.2,
                    enlargeCenterPage: true,
                    enableInfiniteScroll: false,
                    autoPlay: false,
                    onPageChanged: (index, reason) {},
                    viewportFraction: 0.81),
                itemBuilder:
                    (BuildContext context, int index, int pageViewIndex) {
                  return GestureDetector(
                    onTap: () {
                      Get.to(() => TourInfo(
                          id: homeController.popularList![index]['id']
                              .toString(),
                          name: homeController.popularList?[index]['name']));
                    },
                    child: Container(
                      width: 1900.w,
                      margin:
                          EdgeInsets.symmetric(vertical: 18.h, horizontal: 0.w),
                      decoration: BoxDecoration(
                          image: DecorationImage(
                            fit: BoxFit.fill,
                            image: NetworkImage(homeController
                                    .popularList![index]['tour_images'].isEmpty
                                ? "https://cdn-icons-png.freepik.com/512/15114/15114626.png"
                                : homeController.popularList![index]
                                    ['tour_images'][0]['image']),
                          ),
                          color: Colors.grey,
                          borderRadius: BorderRadius.circular(20),
                          border:
                              Border.all(color: ConstColors.backgroundColor)),
                      child: Stack(
                        children: [
                          Container(
                            width: 1900.w,
                            decoration: BoxDecoration(
                              gradient: const LinearGradient(
                                colors: [
                                  Colors.transparent,
                                  Colors.transparent,
                                  Colors.black87,
                                ],
                                // transform: GradientRotation(3.14 / 4),
                                begin: Alignment(-1.0, -1),
                                end: Alignment(-1.0, 1),
                              ),
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                          Align(
                            alignment: Alignment.bottomCenter,
                            child: Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: Text(
                                homeController.popularList?[index]['name'],
                                style: getTextTheme().titleMedium,
                                textAlign: TextAlign.center,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                },
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 80.0.w),
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
                padding: EdgeInsets.symmetric(horizontal: 80.0.w),
                child: GridView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 0.0,
                    crossAxisSpacing: 0.0,
                  ),
                  itemCount: homeController.traindingModel?.length,
                  itemBuilder: (BuildContext context, int index) {
                    return GestureDetector(
                      onTap: () {
                        Get.to(() => TourInfo(
                            id: homeController.traindingModel![index]['id']
                                .toString(),
                            name: homeController.traindingModel?[index]
                                ['name']));
                      },
                      child: Container(
                          margin: const EdgeInsets.all(10.0),
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              fit: BoxFit.fill,
                              image: NetworkImage(homeController
                                      .traindingModel![index]['tour_images']
                                      .isEmpty
                                  ? "https://cdn-icons-png.freepik.com/512/15114/15114626.png"
                                  : homeController.traindingModel![index]
                                      ['tour_images'][0]['image']),
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
                                    isLiked: homeController.favListTours.any(
                                        (element) =>
                                            element["tour"]["id"] ==
                                            homeController
                                                .traindingModel![index]['id']),
                                    onTap: (isLiked) async {
                                      HomeRepo api = HomeRepo();
                                      log("this is like $isLiked");
                                      if (!isLiked) {
                                        await api.likeTour(homeController
                                            .traindingModel![index]['id']
                                            .toString());
                                      } else {
                                        await api.dislikeTour(homeController
                                            .traindingModel![index]['id']
                                            .toString());
                                      }
                                      await homeController.getFavDataRecall();
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
                                  homeController.traindingModel?[index]['name'],
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

  Widget webScreen(double availableHeight, double availableWidth) {
    return SingleChildScrollView(
      child: Obx(
        () => Column(
          children: [
            if (homeController.isLoading1.value) ...[
              Shimmer.fromColors(
                baseColor: Colors.grey.shade300,
                highlightColor: Colors.grey.shade100,
                child: Column(
                  children: [
                    Stack(
                      children: [
                        Container(
                          height: availableHeight * .8,
                          width: availableWidth * .9,
                          margin: EdgeInsets.symmetric(
                              vertical: 20, horizontal: availableWidth * .1),
                          decoration: BoxDecoration(
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
                          child: Image.asset("assets/unsplash_W9fYUYOWr4M.png",
                              fit: BoxFit.fill),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: ConstColors.backgroundColor,
                            boxShadow: const [
                              BoxShadow(
                                  color: ConstColors.shadowColor,
                                  blurRadius: 4,
                                  offset: Offset(1, 2),
                                  spreadRadius: 1)
                            ],
                          ),
                          margin: EdgeInsets.only(
                              top: availableHeight * .68,
                              left: availableWidth * .25),
                          child: SizedBox(
                            height: availableHeight * .08,
                            width: availableWidth * .45,
                            child: Row(
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(
                                      left: availableWidth * .02,
                                      top: availableHeight * .02),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text("Country, city, landmark",
                                          style: GoogleFonts.montserrat(
                                            fontWeight: FontWeight.w500,
                                            color: ConstColors.blue,
                                            fontSize: 15.sp,
                                          )),
                                      Gap(availableHeight * .005),
                                      Text("Nepal",
                                          style: GoogleFonts.montserrat(
                                            fontWeight: FontWeight.w500,
                                            color: ConstColors.textColor,
                                            fontSize: 15.sp,
                                          )),
                                    ],
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.symmetric(
                                      horizontal: availableWidth * .01),
                                  width: availableWidth * .001,
                                  height: availableHeight * .2,
                                  color: ConstColors.shadowColor,
                                ),
                                Padding(
                                  padding: EdgeInsets.only(
                                    left: availableWidth * .01,
                                    top: availableHeight * .02,
                                    right: availableWidth * .01,
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text("People",
                                          style: GoogleFonts.montserrat(
                                            fontWeight: FontWeight.w500,
                                            color: ConstColors.blue,
                                            fontSize: 15.sp,
                                          )),
                                      Gap(availableHeight * .005),
                                      Row(
                                        children: [
                                          Icon(
                                            CupertinoIcons.minus,
                                            size: 20.sp,
                                            color: ConstColors.primaryColor,
                                          ),
                                          Gap(availableWidth * .005),
                                          Text("2",
                                              style: GoogleFonts.montserrat(
                                                fontWeight: FontWeight.w500,
                                                color: ConstColors.textColor,
                                                fontSize: 15.sp,
                                              )),
                                          Gap(availableWidth * .005),
                                          Icon(
                                            CupertinoIcons.add,
                                            size: 20.sp,
                                            color: ConstColors.primaryColor,
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.symmetric(
                                      horizontal: availableWidth * .01),
                                  width: availableWidth * .001,
                                  height: availableHeight * .2,
                                  color: ConstColors.shadowColor,
                                ),
                                Padding(
                                  padding: EdgeInsets.only(
                                    left: availableWidth * .01,
                                    top: availableHeight * .02,
                                    right: availableWidth * .01,
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text("Dates",
                                          style: GoogleFonts.montserrat(
                                            fontWeight: FontWeight.w500,
                                            color: ConstColors.blue,
                                            fontSize: 15.sp,
                                          )),
                                      Gap(availableHeight * .005),
                                      Row(
                                        children: [
                                          Text("16.07.23 – 19.07.23",
                                              style: GoogleFonts.montserrat(
                                                fontWeight: FontWeight.w500,
                                                color: ConstColors.textColor,
                                                fontSize: 15.sp,
                                              )),
                                          Gap(availableWidth * .005),
                                          Icon(
                                            CupertinoIcons.chevron_down,
                                            size: 20.sp,
                                            color: ConstColors.textColor,
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(
                                      left: availableWidth * .05),
                                  width: availableWidth * .001,
                                  height: availableHeight * .2,
                                  color: ConstColors.shadowColor,
                                ),
                                Expanded(
                                    child: Container(
                                        height: availableHeight * .1,
                                        //width: availableWidth*.45,
                                        decoration: const BoxDecoration(
                                            gradient: LinearGradient(
                                              begin: Alignment.centerLeft,
                                              end: Alignment.centerRight,
                                              colors: [
                                                ConstColors.primaryColor,
                                                ConstColors.red
                                              ],
                                            ),
                                            borderRadius: BorderRadius.only(
                                              topRight: Radius.circular(20),
                                              bottomRight: Radius.circular(20),
                                            ),
                                            color: ConstColors.primaryColor),
                                        child: IconButton(
                                          onPressed: () {},
                                          icon: Icon(CupertinoIcons.search,
                                              size: 20.sp,
                                              color: ConstColors.textColor),
                                        )))
                              ],
                            ),
                          ),
                        ),
                      ],

                      /*Stack(
                children: [
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      height: availableHeight*.08,
                      width: availableWidth*.6,
                      color: Colors.red,
                    ),
                  )
                ],
                        ),*/
                    ),
                    Gap(availableHeight * .02),
                    Text("TRENDING PLACES",
                        style: GoogleFonts.montserrat(
                          fontWeight: FontWeight.w600,
                          color: ConstColors.darkBlue,
                          fontSize: 40.sp,
                        )),
                    GridView.builder(
                      padding: EdgeInsets.symmetric(
                          horizontal: 50, vertical: availableHeight * .02),
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 4,
                        childAspectRatio: 7 / 5,
                        mainAxisSpacing: 15.5,
                        crossAxisSpacing: 5.0,
                      ),
                      itemCount: 8,
                      itemBuilder: (BuildContext context, int index) {
                        return Container(
                          margin: const EdgeInsets.all(10.0),
                          padding: EdgeInsets.all(isHovering ? 12.0 : 10.0),
                          decoration: BoxDecoration(
                            color: ConstColors.shadowColor,
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
                    Container(
                      height: availableHeight * .05,
                      width: availableWidth * .15,
                      margin:
                          EdgeInsets.symmetric(vertical: availableHeight * .05),
                      decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                            colors: [ConstColors.primaryColor, ConstColors.red],
                          ),
                          borderRadius: BorderRadius.circular(20),
                          color: ConstColors.shadowColor),
                    ),
                    Text("THINGS TO DO",
                        style: GoogleFonts.montserrat(
                          fontWeight: FontWeight.w600,
                          color: ConstColors.darkBlue,
                          fontSize: 40.sp,
                        )),
                    Container(
                      height: availableHeight * .5,
                      width: availableWidth * 8,
                      margin: EdgeInsets.symmetric(
                          horizontal: 50, vertical: availableHeight * .01),
                      child: ListView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemCount: 3,
                        itemBuilder: (BuildContext context, int index) {
                          return Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 50,
                                vertical: availableHeight * .01),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  height: availableHeight * .3,
                                  width: availableWidth * .25,
                                  margin:
                                      const EdgeInsets.symmetric(vertical: 10),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      color: ConstColors.primaryColor),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                    Container(
                      height: availableHeight * .05,
                      width: availableWidth * .15,
                      margin: EdgeInsets.only(bottom: availableHeight * .02),
                      decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                            colors: [ConstColors.primaryColor, ConstColors.red],
                          ),
                          borderRadius: BorderRadius.circular(20),
                          color: ConstColors.primaryColor),
                    ),
                    Container(
                      width: availableWidth,
                      height: availableHeight * .5,
                      color: ConstColors.blue.withOpacity(.1),
                      padding: const EdgeInsets.symmetric(horizontal: 35),
                    )
                  ],
                ),
              )
            ] else ...[
              Stack(
                children: [
                  Container(
                    height: availableHeight * .9,
                    width: availableWidth * 1,
                    margin: EdgeInsets.symmetric(
                        vertical: 20, horizontal: availableWidth * .1),
                    decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.circular(30),
                      boxShadow: const [
                        BoxShadow(
                            color: ConstColors.shadowColor,
                            blurRadius: 4,
                            offset: Offset(1, 2),
                            spreadRadius: 1)
                      ],
                    ),
                    child: Image.asset("assets/unsplash_W9fYUYOWr4M.png",
                        fit: BoxFit.fill),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: ConstColors.backgroundColor,
                      boxShadow: const [
                        BoxShadow(
                            color: ConstColors.shadowColor,
                            blurRadius: 4,
                            offset: Offset(1, 2),
                            spreadRadius: 1)
                      ],
                    ),
                    margin: EdgeInsets.only(
                        top: availableHeight * .88, left: availableWidth * .25),
                    child: SizedBox(
                      height: availableHeight * .1,
                      width: availableWidth * .5,
                      child: Row(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(
                                left: availableWidth * .02,
                                top: availableHeight * .01),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Country, city, landmark",
                                    style: GoogleFonts.montserrat(
                                      fontWeight: FontWeight.w500,
                                      color: ConstColors.blue,
                                      fontSize: 18.sp,
                                    )),
                                Gap(availableHeight * .005),
                                Text("Nepal",
                                    style: GoogleFonts.montserrat(
                                      fontWeight: FontWeight.w500,
                                      color: ConstColors.textColor,
                                      fontSize: 18.sp,
                                    )),
                              ],
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.symmetric(
                                horizontal: availableWidth * .01),
                            width: availableWidth * .001,
                            height: availableHeight * .2,
                            color: ConstColors.shadowColor,
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                              left: availableWidth * .01,
                              top: availableHeight * .01,
                              right: availableWidth * .01,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("People",
                                    style: GoogleFonts.montserrat(
                                      fontWeight: FontWeight.w500,
                                      color: ConstColors.blue,
                                      fontSize: 18.sp,
                                    )),
                                Gap(availableHeight * .005),
                                Row(
                                  children: [
                                    InkWell(
                                      child: Icon(
                                        CupertinoIcons.minus,
                                        size: 20.sp,
                                        color: ConstColors.primaryColor,
                                      ),
                                      onTap: () {
                                        homeController.minus_count_to_item();
                                      },
                                    ),
                                    Gap(availableWidth * .01),
                                    Text(homeController.number.toString(),
                                        style: GoogleFonts.montserrat(
                                          fontWeight: FontWeight.w500,
                                          color: ConstColors.textColor,
                                          fontSize: 18.sp,
                                        )),
                                    Gap(availableWidth * .01),
                                    InkWell(
                                      child: Icon(
                                        CupertinoIcons.add,
                                        size: 20.sp,
                                        color: ConstColors.primaryColor,
                                      ),
                                      onTap: () {
                                        homeController.add_count_to_item();
                                      },
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.symmetric(
                                horizontal: availableWidth * .01),
                            width: availableWidth * .001,
                            height: availableHeight * .2,
                            color: ConstColors.shadowColor,
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                              left: availableWidth * .01,
                              top: availableHeight * .01,
                              right: availableWidth * .01,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Dates",
                                    style: GoogleFonts.montserrat(
                                      fontWeight: FontWeight.w500,
                                      color: ConstColors.blue,
                                      fontSize: 18.sp,
                                    )),
                                Gap(availableHeight * .005),
                                InkWell(
                                  onTap: () {
                                    homeController.date(context);
                                  },
                                  child: Row(
                                    children: [
                                      Text(
                                          /*homeController.datepick?[0]!=null?"${homeController.datepick?[0]} - ${homeController.datepick?[1]}":*/
                                          "16.07.23 – 19.07.23",
                                          style: GoogleFonts.montserrat(
                                            fontWeight: FontWeight.w500,
                                            color: ConstColors.textColor,
                                            fontSize: 18.sp,
                                          )),
                                      Gap(availableWidth * .005),
                                      Icon(
                                        CupertinoIcons.chevron_down,
                                        size: 20.sp,
                                        color: ConstColors.textColor,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(left: availableWidth * .05),
                            width: availableWidth * .001,
                            height: availableHeight * .2,
                            color: ConstColors.shadowColor,
                          ),
                          Expanded(
                              child: Container(
                                  height: availableHeight * .1,
                                  //width: availableWidth*.45,
                                  decoration: const BoxDecoration(
                                      gradient: LinearGradient(
                                        begin: Alignment.centerLeft,
                                        end: Alignment.centerRight,
                                        colors: [
                                          ConstColors.primaryColor,
                                          ConstColors.red
                                        ],
                                      ),
                                      borderRadius: BorderRadius.only(
                                        topRight: Radius.circular(10),
                                        bottomRight: Radius.circular(10),
                                      ),
                                      color: ConstColors.primaryColor),
                                  child: IconButton(
                                    onPressed: () {},
                                    icon: Icon(CupertinoIcons.search,
                                        size: 30.sp,
                                        color: ConstColors.backgroundColor),
                                  )))
                        ],
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(
                        top: availableHeight * .5, left: availableWidth * .30),
                    child: Text(
                      "Find Your Dream Vacation Location",
                      style: GoogleFonts.inter(
                        fontWeight: FontWeight.w700,
                        color: ConstColors.backgroundColor,
                        fontSize: 35,
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(
                        top: availableHeight * .56, left: availableWidth * .38),
                    child: Text(
                      "Search hundreds of locations from around the world and find your perfect location",
                      style: GoogleFonts.inter(
                        fontWeight: FontWeight.w400,
                        color: ConstColors.backgroundColor,
                        fontSize: 10,
                      ),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: ConstColors.backgroundColor,
                      boxShadow: const [
                        BoxShadow(
                            color: ConstColors.shadowColor,
                            blurRadius: 4,
                            offset: Offset(1, 2),
                            spreadRadius: 0)
                      ],
                    ),
                    margin: EdgeInsets.only(
                        top: availableHeight * .64, left: availableWidth * .45),
                    child: SizedBox(
                      height: availableHeight * .08,
                      width: availableWidth * .1,
                      child: Center(
                        child: Text(
                          "Discover Now",
                          style: GoogleFonts.montserrat(
                            fontWeight: FontWeight.w400,
                            color: ConstColors.darkBlue,
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],

                /*Stack(
                children: [
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      height: availableHeight*.08,
                      width: availableWidth*.6,
                      color: Colors.red,
                    ),
                  )
                ],
                        ),*/
              ),
              Gap(availableHeight * .02),
              Text("TRENDING PLACES",
                  style: GoogleFonts.montserrat(
                    fontWeight: FontWeight.w600,
                    color: ConstColors.darkBlue,
                    fontSize: 40.sp,
                  )),
              GridView.builder(
                padding: EdgeInsets.symmetric(
                    horizontal: 50, vertical: availableHeight * .02),
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                  childAspectRatio: 7 / 5,
                  mainAxisSpacing: 15.5,
                  crossAxisSpacing: 5.0,
                ),
                itemCount: homeController.traindingModel?.length,
                itemBuilder: (BuildContext context, int index) {
                  return InkWell(
                    mouseCursor: MouseCursor.uncontrolled,
                    onHover: (hovering) {
                      setState(() => isHovering = hovering);
                    },
                    onTap: () {
                      Get.to(() => TourInfo(
                          id: homeController.traindingModel![index]['id']
                              .toString(),
                          name: homeController.traindingModel?[index]['name']));
                    },
                    onDoubleTap: () {},
                    child: AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        curve: Curves.ease,
                        margin: const EdgeInsets.all(10.0),
                        padding: EdgeInsets.all(isHovering ? 12.0 : 10.0),
                        decoration: BoxDecoration(
                          color: ConstColors.primaryColor,
                          borderRadius: BorderRadius.circular(20),
                          image: DecorationImage(
                            fit: BoxFit.fill,
                            image: NetworkImage(
                                homeController.traindingModel![index]
                                    ['tour_images'][0]['image']),
                          ),
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
                          homeController.traindingModel?[index]['name'],
                          style: GoogleFonts.montserrat(
                            fontWeight: FontWeight.w600,
                            color: ConstColors.backgroundColor,
                            fontSize: 20.sp,
                          ),
                        ))),
                  );
                },
              ),
              Container(
                  height: availableHeight * .05,
                  width: availableWidth * .15,
                  margin: EdgeInsets.symmetric(vertical: availableHeight * .05),
                  decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                        colors: [ConstColors.primaryColor, ConstColors.red],
                      ),
                      borderRadius: BorderRadius.circular(20),
                      color: ConstColors.primaryColor),
                  child: Center(
                    child: Text(
                      "View More",
                      style: GoogleFonts.montserrat(
                        fontWeight: FontWeight.w500,
                        color: ConstColors.backgroundColor,
                        fontSize: 20.sp,
                      ),
                    ),
                  )),
              Text("THINGS TO DO",
                  style: GoogleFonts.montserrat(
                    fontWeight: FontWeight.w600,
                    color: ConstColors.darkBlue,
                    fontSize: 40.sp,
                  )),
              Container(
                height: availableHeight * .5,
                width: availableWidth * 8,
                margin: EdgeInsets.symmetric(
                    horizontal: 50, vertical: availableHeight * .01),
                child: ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemCount: 3,
                  itemBuilder: (BuildContext context, int index) {
                    return Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: 50, vertical: availableHeight * .01),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                              height: availableHeight * .3,
                              width: availableWidth * .25,
                              margin: const EdgeInsets.symmetric(vertical: 10),
                              decoration: BoxDecoration(
                                  image: const DecorationImage(
                                      fit: BoxFit.cover,
                                      image: NetworkImage(
                                          "https://d1nkxkz7ge96ao.cloudfront.net/eyJidWNrZXQiOiJzbW4tbWFpbi1zaXRlLWJ1Y2tldCIsImtleSI6ImltYWdlc1wvaW1hZ2luXC9JOENUUUY3eWQ4elBDcEUwajYzY3NDQlhIMUh1WkNGV1hROVV0M2NMLmpwZyIsImVkaXRzIjp7InJlc2l6ZSI6eyJ3aWR0aCI6MjYwMCwiaGVpZ2h0IjoxOTExLCJmaXQiOiJjb3ZlciJ9fX0=")),
                                  borderRadius: BorderRadius.circular(20),
                                  color: ConstColors.primaryColor),
                              child: Center(
                                child: Text(
                                  "See all",
                                  style: GoogleFonts.montserrat(
                                    fontWeight: FontWeight.w500,
                                    color: ConstColors.backgroundColor,
                                    fontSize: 20.sp,
                                  ),
                                ),
                              )),
                          Text(
                            "PHOTOGRAPHY",
                            style: GoogleFonts.montserrat(
                              fontWeight: FontWeight.w600,
                              color: ConstColors.textColor,
                              fontSize: 20.sp,
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
              Container(
                  height: availableHeight * .05,
                  width: availableWidth * .15,
                  margin: EdgeInsets.only(bottom: availableHeight * .02),
                  decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                        colors: [ConstColors.primaryColor, ConstColors.red],
                      ),
                      borderRadius: BorderRadius.circular(20),
                      color: ConstColors.primaryColor),
                  child: Center(
                    child: Text(
                      "View More",
                      style: GoogleFonts.montserrat(
                        fontWeight: FontWeight.w500,
                        color: ConstColors.backgroundColor,
                        fontSize: 20.sp,
                      ),
                    ),
                  )),
              Container(
                width: availableWidth,
                //height: availableHeight*.5,
                color: ConstColors.blue.withOpacity(.1),
                padding:
                    const EdgeInsets.symmetric(horizontal: 45, vertical: 45),
                child: Wrap(
                  spacing: availableWidth * .05,
                  children: [
                    offer("OUR OFFERINGS", destinations),
                    offer("ABOUT US", guideInfo),
                    offer("MORE LINKS", accountItems),
                  ],
                ),
              )
            ]
          ],
        ),
      ),
    );
  }

  Widget offer(String text, List list) {
    return Column(
      children: [
        Text(text,
            style: GoogleFonts.montserrat(
              fontWeight: FontWeight.w600,
              color: ConstColors.darkBlue,
              fontSize: 20,
            )),
        Container(
          height: 250,
          width: 320,
          child: ListView(
            shrinkWrap: false,
            children: List.generate(
              list.length,
              (index) {
                return ListTile(
                  leading: const Icon(Icons.check_circle),
                  title: Text(
                    list[index],
                    style: GoogleFonts.montserrat(
                      fontWeight: FontWeight.w400,
                      color: ConstColors.textColor,
                      fontSize: 15,
                    ),
                  ),
                );
              },
            ),
          ),
        )
      ],
    );
  }

  Widget searchChild(x) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 12),
        child: Text(x.toString().split('.').first,
            style: getTextTheme().headlineSmall),
      );
}
