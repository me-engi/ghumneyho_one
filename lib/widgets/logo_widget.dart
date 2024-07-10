import 'package:flutter/material.dart';

import '../constants/const_colors.dart';
import '../constants/custom_textstyle.dart';

class LogoWidget extends StatelessWidget {
  const LogoWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Column(
      children: [
        Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                'assets/logo.png',
                width: size.width * .2,
                height: size.width * .2,
                fit: BoxFit.fitWidth,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
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
    );
  }
}
