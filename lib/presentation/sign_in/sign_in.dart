import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/route_manager.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:toursandtravels/constants/custom_textstyle.dart';
import 'package:toursandtravels/presentation/sign_in/sign_in_repo/sign_in_repo.dart';
import 'package:toursandtravels/presentation/sign_up/sign_up_repo/sign_up_repo.dart';
import 'package:toursandtravels/widgets/custom_textfield.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../constants/const_colors.dart';
import '../../constants/global.dart';
import '../../widgets/logo_widget.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final username = TextEditingController();
  final password = TextEditingController();
  final formkey = GlobalKey<FormState>();
  RxBool passwordVisiblity = true.obs;
  RxBool isLoading = false.obs;
  RxBool isLoadingGoogle = false.obs;

  void handleGoogleLogin() async {
    GoogleSignIn googleSignIn = GoogleSignIn();
    isLoadingGoogle.value = true;
    try {
      SignUpRepo api = SignUpRepo();

      final GoogleSignInAccount? guser = await googleSignIn.signIn();
      if (guser == null) {
        isLoadingGoogle.value = false;
        throw "guser is null";
      }

      final GoogleSignInAuthentication gAuth = await guser!.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: gAuth.accessToken,
        idToken: gAuth.idToken,
      );
      UserCredential user =
          await FirebaseAuth.instance.signInWithCredential(credential);

      log("user info is this ${user.user!.email}");

      await api
          .signUpGoogleCall(
              user.user!.email.toString(), user.user!.email.toString())
          .then((value) => {
                if (value == "true")
                  {
                    Get.offAllNamed('/navbar'),
                  }
                else
                  {googleSignIn.signOut()}
              });
      isLoadingGoogle.value = false;
    } on Exception catch (e) {
      googleSignIn.signOut();

      isLoadingGoogle.value = false;
      rethrow;
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          children: [
            ClipPath(
              clipper: CurveClipper(),
              child: Container(
                height: MediaQuery.of(context).size.height * .5,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [ConstColors.primaryColor, ConstColors.red],
                  ),
                ),
              ),
            ),
            SingleChildScrollView(
              child: Column(
                children: [
                  Center(
                    child: Container(
                      margin: EdgeInsets.only(
                          top: size.height * 0.2, bottom: size.height * 0.1),
                      padding: EdgeInsets.symmetric(
                        horizontal: size.width * .08,
                      ),
                      width: size.width * .9,
                      // height: size.height * .7,
                      decoration: BoxDecoration(
                          boxShadow: const [
                            BoxShadow(
                                color: ConstColors.shadowColor,
                                blurRadius: 4,
                                offset: Offset(1, 5),
                                spreadRadius: 1)
                          ],
                          borderRadius: BorderRadius.circular(40),
                          color: ConstColors.backgroundColor),
                      child: Form(
                        key: formkey,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const LogoWidget(),
                            SizedBox(
                              height: size.height * .05,
                            ),
                            CustomTextFormField(
                                customText: "Username",
                                controller: username,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter your username';
                                  }
                                  if (value.length < 3) {
                                    return 'Username must be at least 3 characters long';
                                  }
                                  return null;
                                },
                                inputFormatters: [],
                                onChanged: (value) {}),
                            SizedBox(
                              height: size.height * .03,
                            ),
                            Obx(
                              () => CustomTextFormField(
                                obsercureText: passwordVisiblity.value,
                                customText: "Password",
                                controller: password,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter your password';
                                  }
                                  if (value.length < 6) {
                                    return 'Password must be at least 6 characters long';
                                  }
                                  return null;
                                },
                                inputFormatters: [],
                                onChanged: (value) {},
                                iconss: passwordVisiblity.value
                                    ? IconButton(
                                        onPressed: () {
                                          passwordVisiblity.value = false;
                                        },
                                        icon: Icon(
                                          Icons.visibility_off,
                                          color: ConstColors.primaryColor,
                                        ))
                                    : IconButton(
                                        onPressed: () {
                                          passwordVisiblity.value = true;
                                        },
                                        icon: Icon(
                                          Icons.visibility,
                                          color: ConstColors.primaryColor,
                                        )),
                              ),
                            ),
                            SizedBox(
                              height: size.height * .02,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                InkWell(
                                  onTap: () => urlLaunch(Global.forgotPassword),
                                  child: Text(
                                    'Forgot password',
                                    style: getTextTheme().displaySmall,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: size.height * .02,
                            ),
                            InkWell(
                              onTap: () async {
                                if (formkey.currentState!.validate()) {
                                  isLoading.value = true;
                                  debugPrint('login');
                                  SignInRepo api = SignInRepo();
                                  await api
                                      .signInCall(username.text.trim(),
                                          password.text.trim())
                                      .then(
                                    (value) {
                                      if (value == "true") {
                                        Get.offAllNamed('/navbar');
                                      } else {
                                        isLoading.value = false;
                                      }
                                    },
                                  );
                                }
                              },
                              child: Container(
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
                                child: Obx(() => Center(
                                      child: isLoading.value
                                          ? const CircularProgressIndicator(
                                              color:
                                                  ConstColors.backgroundColor,
                                            )
                                          : Text(
                                              "Sign In",
                                              style: getTextTheme().titleMedium,
                                            ),
                                    )),
                              ),
                            ),
                            SizedBox(
                              height: size.height * .02,
                            ),
                            const Row(
                              children: [
                                Expanded(
                                  child: Divider(
                                    color: ConstColors.shadowColor,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text('or sign up with'),
                                ),
                                Expanded(
                                  child: Divider(
                                    color: ConstColors.shadowColor,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: size.height * .02,
                            ),
                            OutlinedButton(
                                onPressed: () {
                                  handleGoogleLogin();
                                },
                                style: OutlinedButton.styleFrom(
                                    side: BorderSide(
                                        color: ConstColors.primaryColor),
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10))),
                                child: Obx(() => isLoadingGoogle.value
                                    ? Padding(
                                        padding: const EdgeInsets.all(5.0),
                                        child: CircularProgressIndicator(
                                          color: ConstColors.primaryColor,
                                        ),
                                      )
                                    : Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 10.0, horizontal: 20),
                                            child: Image.asset(
                                              'assets/google 1.png',
                                              height: 35,
                                            ),
                                          ),
                                          Text(
                                            'Sign up with Google',
                                            style:
                                                getTextTheme().headlineMedium,
                                          )
                                        ],
                                      ))),
                            SizedBox(
                              height: size.height * .05,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Don’t have an account? ",
                                  style: getTextTheme().headlineSmall,
                                ),
                                GestureDetector(
                                  onTap: () {
                                    Get.toNamed('/signup');
                                  },
                                  child: Text(
                                    "Sign Up",
                                    style: getTextTheme().displaySmall,
                                  ),
                                )
                              ],
                            ),
                            SizedBox(
                              height: size.height * .05,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  static Future<void> urlLaunch(String urlunch) async {
    String url = urlunch;
    if (await canLaunchUrl(
      Uri.parse(url),
    )) {
      await launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);
    } else {
      debugPrint('could not launch');
    }
  }
}

class CurveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    int curveHeight = 40;
    Offset controlPoint = Offset(size.width / 2, size.height + curveHeight);
    Offset endPoint = Offset(size.width, size.height - curveHeight);

    Path path = Path()
      ..lineTo(0, size.height - curveHeight)
      ..quadraticBezierTo(
          controlPoint.dx, controlPoint.dy, endPoint.dx, endPoint.dy)
      ..lineTo(size.width, 0)
      ..close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
