import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/route_manager.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:line_icons/line_icons.dart';
import 'package:toursandtravels/constants/const_colors.dart';
import 'package:toursandtravels/presentation/customer_profile/customer_profile.dart';
import 'package:toursandtravels/presentation/history_tours.dart/history_tours.dart';
import 'package:toursandtravels/presentation/notification_screen/notification.dart';
import 'package:toursandtravels/widgets/custom_dialog.dart';

import '../../constants/custom_textstyle.dart';
import '../fav_tours/fav_tours.dart';
import '../home_page/body/menu_drawer.dart';
import '../home_page/home_page.dart';

class GhumiyoNavBar extends StatefulWidget {
  const GhumiyoNavBar({super.key});

  @override
  State<GhumiyoNavBar> createState() => _GhumiyoNavBarState();
}

class _GhumiyoNavBarState extends State<GhumiyoNavBar> {
  var scaffoldKey = GlobalKey<ScaffoldState>();
  int _selectedIndex = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.w600);
  static const List<Widget> _widgetOptions = <Widget>[
    HomePage(),
    FavTours(),
    ToursHistory(),
    CustomerProfile(),
  ];

  exitDialog() {
    return showDialog(
        barrierDismissible: true,
        barrierColor: ConstColors.textColor.withOpacity(0.1),
        context: context,
        builder: (context) => customDialogueWithCancel(
              backgroundColor: ConstColors.backgroundColor,
              content: "Are you sure you want exit?",
              dismissBtnTitle: "Yes",
              onClick: () {
                exit(0);
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
      child: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          double availableWidth = constraints.maxWidth;
          double availableHeight = constraints.maxHeight;
          if (availableWidth <= 600) {
            return phoneScreen();
          } else {
            return webScreen(availableHeight, availableWidth);
          }
        },
      ),
    );
  }

  phoneScreen() {
    return Scaffold(
      extendBody: true,
      key: scaffoldKey,
      backgroundColor: ConstColors.backgroundColor,
      drawer: MenuDrawer(),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        surfaceTintColor: ConstColors.backgroundColor,
        backgroundColor: ConstColors.backgroundColor,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: EdgeInsets.only(left: 45.0.w),
              child: IconButton(
                  onPressed: () {
                    scaffoldKey.currentState?.openDrawer();
                  },
                  icon: Icon(
                    Icons.subject_rounded,
                    color: ConstColors.primaryColor,
                    size: 133.sp,
                  )),
            ),
            Text(
              'Ghumneyho',
              style: getTextTheme().headlineLarge,
            ),
            Padding(
              padding: EdgeInsets.only(right: 45.0.w),
              child: IconButton(
                  onPressed: () {
                    Get.to(() => NotificationScreen());
                  },
                  icon: Icon(
                    CupertinoIcons.bell,
                    color: ConstColors.primaryColor,
                    size: 133.sp,
                  )),
            )
          ],
        ),
        centerTitle: true,
      ),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: Container(
        margin: EdgeInsets.symmetric(vertical: 10.h, horizontal: 53.w),
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
        child: SafeArea(
          child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.00),
            child: GNav(
              rippleColor: Colors.grey[300]!,
              hoverColor: Colors.grey[100]!,
              gap: 8,
              activeColor: ConstColors.backgroundColor,
              iconSize: 24,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
              duration: const Duration(milliseconds: 400),
              tabBackgroundColor: ConstColors.primaryColor,
              color: Colors.grey,
              tabs: const [
                GButton(
                  icon: Icons.home,
                  text: 'Home',
                ),
                GButton(
                  icon: CupertinoIcons.heart_fill,
                  text: 'Likes',
                ),
                GButton(
                  icon: Icons.shopping_bag_rounded,
                  text: 'Journey',
                ),
                GButton(
                  icon: CupertinoIcons.person_solid,
                  text: 'Account',
                ),
              ],
              selectedIndex: _selectedIndex,
              onTabChange: (index) {
                setState(() {
                  _selectedIndex = index;
                });
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget webScreen(double availableHeight, double availableWidth) {
    return Scaffold(
        appBar: PreferredSize(
          preferredSize: Size(availableWidth, 250),
          child: Container(
            color: ConstColors.primaryColor,
            padding: EdgeInsets.symmetric(vertical: availableHeight * .001),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Image.asset("assets/logo.png",
                        height: availableHeight * .08,
                        width: availableWidth * .04,
                        fit: BoxFit.fill),
                    Text(
                      "Ghumneyho",
                      style: GoogleFonts.italianno(
                        fontWeight: FontWeight.w600,
                        color: ConstColors.darkBlue,
                        fontSize: 40,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    textbut("Home", () {}),
                    textbut("About Us", () {}),
                    textbut("Dashboard", () {}),
                    textbut("News", () {}),
                    textbut("Contact Us", () {}),
                    textbut("Login/Sign up", () {}),
                  ],
                )
              ],
            ),
          ),
        ),
        body: const HomePage());
  }

  Widget textbut(String text, VoidCallback onpressed) {
    return TextButton(
      onPressed: onpressed,
      child: Text(
        text,
        style: GoogleFonts.inter(
          fontWeight: FontWeight.w400,
          color: ConstColors.backgroundColor,
          fontSize: 15,
        ),
      ),
    );
  }
}
