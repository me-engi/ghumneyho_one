import 'dart:developer';
import 'dart:io';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:toursandtravels/constants/custom_textstyle.dart';
import 'package:toursandtravels/presentation/about_us/contact_us.dart';
import 'package:toursandtravels/widgets/logo_widget.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../constants/const_colors.dart';
import '../../about_us/about_us.dart';

class MenuDrawer extends StatefulWidget {
  const MenuDrawer({super.key});

  @override
  State<StatefulWidget> createState() => MenuDrawerState();
}

class MenuDrawerState extends State<MenuDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      width: 1400.w,
      child: Container(

          //padding: const EdgeInsets.symmetric(horizontal: 5.w),
          color: ConstColors.backgroundColor,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 50.h),
            child: Column(children: [
              LogoWidget(),
              Container(
                width: 1400.w,
                height: 1.h,
                color: ConstColors.shadowColor,
                padding: EdgeInsets.symmetric(vertical: 40.h),
              ),
              Container(
                // height: 560.h,
                width: 1400.w,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                    boxShadow: const [
                      BoxShadow(
                          color: ConstColors.shadowColor,
                          blurRadius: 6,
                          offset: Offset(1, 6),
                          spreadRadius: 1)
                    ],
                    border: Border.all(color: Colors.black.withOpacity(.2))),
                margin:
                    const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                padding: const EdgeInsets.symmetric(
                  vertical: 15,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    /* Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(left: 280.w,top: 25.h),
                              child: Text("Home",style: getTextTheme().bodyMedium),
                            ),
                            Container(
                              width: 1000.w,
                              height: 1.h,
                              margin: EdgeInsets.symmetric(horizontal: 150.w,vertical: 20.h),
                              color: ConstColors.shadowColor,
                            ),
                          ],
                        ),*/

                    textCont("Home", Icons.home, () {
                      Navigator.of(context).pop();
                    }),
                    textCont(
                        "Become a travel guide",
                        Icons.hiking_rounded,
                        () => showInfo(
                            context,
                            "Become a travel guide",
                            "Do you love traveling and have a passion for sharing your experiences with others? Become a Ghumneyho Travel Guide! Send your resume to join our team and help others explore the world.\nInstructions:\nTo apply, please send your resume to",
                            "travel@ghumneyho.com")),
                    textCont(
                        "Become a affiliate partner guide",
                        Icons.handshake,
                        () => showInfo(
                            context,
                            "Become a affiliate partner guide",
                            "Are you a travel corporation looking to collaborate with Ghumneyho? Become our travel partner! Send us your certificate of incorporation to start the partnership.\nInstructions:\nTo apply, please send your certificate of incorporation to",
                            "travel@ghumneyho.com")),
                    textCont("About Us", Icons.report_gmailerrorred_rounded,
                        () {
                      Get.to(() => const AboutUs());
                    }),
                    textCont("Contact us", Icons.phone_in_talk, () {
                      Get.to(() => const ContactUs());
                    }),
                    textCont(
                        "Join us",
                        Icons.group_rounded,
                        () => showInfo(
                            context,
                            "Join us",
                            "Embark on an unforgettable adventure with Ghumneyho. Whether you're a seasoned trekker or a first-time explorer, we have something for everyone. Browse our tours, book your next adventure, and discover the magic of the Himalayas with us.",
                            "travel@ghumneyho.com")),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: 100.w, vertical: 15.h),
                      child: Row(
                        children: [
                          InkWell(
                            onTap: () => urlLaunch(
                                'https://www.facebook.com/profile.php?id=61554850642634'),
                            child: Image.asset("assets/Facebook.png",
                                height: 180.sp,
                                width: 180.sp,
                                fit: BoxFit.fill),
                          ),
                          SizedBox(
                            width: 28.w,
                          ),
                          InkWell(
                            onTap: () => urlLaunch(
                                'https://www.instagram.com/g_humnaho/'),
                            child: Image.asset("assets/Instagram.png",
                                height: 180.sp,
                                width: 180.sp,
                                fit: BoxFit.fill),
                          ),
                          SizedBox(
                            width: 28.w,
                          ),
                          InkWell(
                            onTap: () => urlLaunch('twitter.com/ghumneyho'),
                            child: Image.asset("assets/Twitter.png",
                                height: 180.sp,
                                width: 180.sp,
                                fit: BoxFit.fill),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                // height: 180.h,
                width: 1300.w,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                    boxShadow: const [
                      BoxShadow(
                          color: ConstColors.shadowColor,
                          blurRadius: 6,
                          offset: Offset(1, 6),
                          spreadRadius: 1)
                    ],
                    border: Border.all(color: Colors.black.withOpacity(.2))),
                child: Column(
                  children: [
                    listIcon(
                        "assets/IndianFlag.png", "Country/ Religion", "India"),
                    Gap(15.h),
                    listIcon("assets/blankrectangle.png", "App Version: 1.0.0",
                        "The Story of GHUMNEYHO"),
                  ],
                ),
              )
            ]),
          )),
    );
  }

  Widget textCont(String headtext, IconData icon, Function() press) {
    return InkWell(
      onTap: press,
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 150.w),
            child: Row(
              children: [
                Icon(
                  icon,
                ),
                Gap(35.w),
                Text(headtext, style: getTextTheme().bodyMedium),
              ],
            ),
          ),
          Container(
            width: 1000.w,
            height: 1.h,
            margin: EdgeInsets.symmetric(horizontal: 50.w, vertical: 20.h),
            color: ConstColors.shadowColor,
          ),
        ],
      ),
    );
  }

  Widget listIcon(String image, String titleText, String subtitle) {
    return Row(
      children: [
        Image.asset(image, height: 45.h, width: 200.w, fit: BoxFit.fill),
        Gap(30.w),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              titleText,
              style: getTextTheme().headlineMedium,
            ),
            Text(subtitle,
                style: GoogleFonts.montserrat(
                  fontWeight: FontWeight.w400,
                  color: ConstColors.textColor,
                  fontSize: 53.sp,
                )),
          ],
        )
      ],
    );
  }

  static Future<void> urlLaunch(String urlunch) async {
    String url = urlunch;
    if (await canLaunchUrl(
      Uri.parse(url),
    )) {
      await launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);
    } else {
      log('could not launch');
    }
  }

  openMail(String mail) async {
    Uri url = Uri(scheme: "mailto", path: mail);
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      log("Can't open dial pad.");
    }
  }

  Future<dynamic> showInfo(
      BuildContext context, String title, String content, String email) {
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
                title: Text(
                  title,
                  style: getTextTheme().headlineMedium,
                ),
                content: SizedBox(
                  width: 1500.w,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        content,
                        style: getTextTheme().headlineSmall,
                      ),
                      TextButton(
                          onPressed: () {
                            openMail(email);
                          },
                          style: TextButton.styleFrom(padding: EdgeInsets.zero),
                          child: Text(
                            email,
                            style: getTextTheme().displaySmall,
                          ))
                    ],
                  ),
                ),
              ),
            ));
  }
}
