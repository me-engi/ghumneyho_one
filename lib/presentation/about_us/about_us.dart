import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/route_manager.dart';
import 'package:toursandtravels/constants/custom_textstyle.dart';

import '../../constants/const_colors.dart';

class AboutUs extends StatefulWidget {
  const AboutUs({super.key});

  @override
  State<AboutUs> createState() => _AboutUsState();
}

class _AboutUsState extends State<AboutUs> {
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
          "About Us",
          style: getTextTheme().headlineMedium,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Text(
                'Welcome to Ghumneyho',
                style: getTextTheme().headlineLarge,
              ),
              Gap(10),
              Text(
                'Ghumneyho is your ultimate gateway to exploring the majestic hills and the serene Himalayan regions. We believe in creating unforgettable travel experiences by connecting adventurers with local guides and tour companies who offer unique, personalized, and sustainable travel options.',
                style: getTextTheme().headlineSmall,
              ),
              Gap(30),
              Row(
                children: [
                  Text(
                    'Our Team',
                    style: getTextTheme().headlineMedium,
                  ),
                ],
              ),
              Gap(20),
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
}
