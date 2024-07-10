import 'package:get/route_manager.dart';
import 'package:toursandtravels/presentation/sign_in/sign_in.dart';
import 'package:toursandtravels/presentation/sign_up/sign_up.dart';
import 'package:toursandtravels/presentation/splashscreen/splashscreen.dart';
import 'package:toursandtravels/presentation/tour_info/tour_info.dart';

import '../presentation/dashboard/dashboard.dart';
import '../presentation/home_page/home_page.dart';

class Routes {
  static final pages = [
     GetPage(name: '/signin', page: () => const SignIn()),
      GetPage(name: '/signup', page: () => const SignUp()),
    GetPage(name: '/home', page: () => const HomePage()),
    //GetPage(name: '/tourInfo', page: () => const TourInfo()),
    GetPage(name: '/navbar', page: () => const GhumiyoNavBar()),
    GetPage(name: '/', page: () => const SplashScreen()),
   
  ];
}
