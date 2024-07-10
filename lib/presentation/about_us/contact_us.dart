import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/route_manager.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../constants/const_colors.dart';
import '../../constants/custom_textstyle.dart';

class ContactUs extends StatefulWidget {
  const ContactUs({super.key});

  @override
  State<ContactUs> createState() => _ContactUsState();
}

class _ContactUsState extends State<ContactUs> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new_rounded,
            color: ConstColors.textColor,
          ),
          onPressed: () => Get.back(),
        ),
        title: Text(
          "Contact Us",
          style: getTextTheme().headlineMedium,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'For inquiries, feedback, or support, feel free to reach out to us at:',
                style: getTextTheme().headlineMedium,
              ),
              const Gap(10),
              Row(
                children: [
                  Text(
                    'Email -',
                    style: getTextTheme().headlineMedium,
                  ),
                  const Gap(10),
                  InkWell(
                    onTap: () {
                      openMail('support@ghumneyho.com');
                    },
                    child: Text(
                      'support@ghumneyho.com',
                      style: getTextTheme().displaySmall,
                    ),
                  ),
                ],
              ),
              const Gap(10),
              Row(
                children: [
                  Text(
                    'Phone No. -',
                    style: getTextTheme().headlineMedium,
                  ),
                  const Gap(10),
                  InkWell(
                    onTap: () {
                      openDialPad('+91-1234567890');
                    },
                    child: Text(
                      '+91-1234567890',
                      style: getTextTheme().displaySmall,
                    ),
                  ),
                ],
              ),
              const Gap(30),
              Text(
                'Address - 123, Mountain View Road, Kathmandu, Nepal.\n\nStay connected with us on social media for the latest updates and travel inspiration:',
                style: getTextTheme().headlineSmall,
              ),
              const Gap(20),
              Text(
                'Ghumneyho is powered by a passionate team of travel enthusiasts, technology experts, and local guides dedicated to bringing you the best travel experiences. Our team works tirelessly to curate, promote, and manage tours that highlight the natural beauty and cultural richness of the Himalayan regions.',
                style: getTextTheme().headlineSmall,
              ),
            ],
          ),
        ),
      ),
    );
  }

  openDialPad(String phoneNumber) async {
    Uri url = Uri(scheme: "tel", path: phoneNumber);
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      log("Can't open dial pad.");
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
}
