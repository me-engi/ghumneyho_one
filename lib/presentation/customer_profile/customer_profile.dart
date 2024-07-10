import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';

class CustomerProfile extends StatefulWidget {
  const CustomerProfile({super.key});

  @override
  State<CustomerProfile> createState() => _CustomerProfileState();
}

class _CustomerProfileState extends State<CustomerProfile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: IconButton(
          onPressed: () async {
            GetStorage box = GetStorage();
            GoogleSignIn googleSignIn = GoogleSignIn();
            await box.erase();
            await googleSignIn.signOut();
            await FirebaseAuth.instance.signOut();
            Get.offAllNamed('/signin');
          },
          icon: Icon(Icons.logout),
        ),
      ),
    );
  }
}
