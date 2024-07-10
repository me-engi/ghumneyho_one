import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../constants/const_colors.dart';
import '../../constants/custom_textstyle.dart';
import '../../widgets/custom_textfield.dart';
import 'sign_up_repo/sign_up_repo.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final username = TextEditingController();
  final password = TextEditingController();
  final email = TextEditingController();
  final phone = TextEditingController();
  final city = TextEditingController();
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
                  }else{
                    googleSignIn.signOut()
                  }
              });
      isLoadingGoogle.value = false;
    } catch (e) {
      print('error is this $e');
      googleSignIn.signOut();

      isLoadingGoogle.value = false;
      rethrow;
    } finally {
      isLoadingGoogle.value = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return PopScope(
      canPop: false,
      child: Scaffold(
        body: Stack(
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
                          top: size.height * 0.1, bottom: size.height * 0.05),
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
                            Column(
                              children: [
                                Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Image.asset(
                                        'assets/logo.png',
                                        width: size.width * .2,
                                        height: size.width * .2,
                                        fit: BoxFit.fitWidth,
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "Ghumneyho",
                                            style: getTextTheme().headlineLarge,
                                          ),
                                          Text(
                                            " Travel With Us",
                                            style: getTextTheme().headlineSmall,
                                          )
                                        ],
                                      )
                                    ]),
                                SizedBox(
                                  width: size.width * .6,
                                  child: const Divider(
                                    color: ConstColors.shadowColor,
                                    height: 0,
                                  ),
                                )
                              ],
                            ),
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
                            CustomTextFormField(
                                customText: "Email",
                                controller: email,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter your email';
                                  }
                                  if (!RegExp(r'^[^@]+@[^@]+\.[^@]+')
                                      .hasMatch(value)) {
                                    return 'Please enter a valid email address';
                                  }
                                  return null;
                                },
                                inputFormatters: [
                                  FilteringTextInputFormatter.deny(
                                      RegExp(r'\s')),
                                ],
                                onChanged: (value) {}),
                            SizedBox(
                              height: size.height * .03,
                            ),
                            CustomTextFormField(
                                customText: "Phone no",
                                controller: phone,
                                keyoardType: TextInputType.phone,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter your phone number';
                                  }
                                  // if (!RegExp(r'^\d{10}$').hasMatch(value)) {
                                  //   return 'Please enter a valid 10-digit phone number';
                                  // }
                                  return null;
                                },
                                inputFormatters: [
                                  FilteringTextInputFormatter.digitsOnly,
                                  //LengthLimitingTextInputFormatter(10),
                                ],
                                onChanged: (value) {}),
                            SizedBox(
                              height: size.height * .03,
                            ),
                            CustomTextFormField(
                                customText: "city",
                                controller: city,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter your city';
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
                            InkWell(
                              onTap: () async {
                                if (formkey.currentState!.validate()) {
                                  isLoading.value = true;
                                  debugPrint('Signup');
                                  SignUpRepo api = SignUpRepo();
                                  await api
                                      .signUpCall(
                                          username.text.trim(),
                                          email.text.toString(),
                                          phone.text.toString(),
                                          city.text.toString(),
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
                                              "Sign Up",
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
                                    ? CircularProgressIndicator(
                                        color: ConstColors.primaryColor,
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
                                  "Already have an account! ",
                                  style: getTextTheme().headlineSmall,
                                ),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: Text(
                                    "Sign In",
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
