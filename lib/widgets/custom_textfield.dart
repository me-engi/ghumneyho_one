import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../constants/const_colors.dart';
import '../../constants/custom_textstyle.dart';

class CustomTextFormField extends StatelessWidget {
  // final double width;
  // final double height;
  final String customText;
  final TextEditingController controller;
  final TextInputType? keyoardType;
  final String? Function(String?)? validator;
  final Function(String) onChanged;
  final List<TextInputFormatter>? inputFormatters;
  final bool readOnly;
  final bool obsercureText;
  final int minline;
  final int maxline;
  final Widget iconss;
  const CustomTextFormField({
    super.key,

    // required this.width,

    required this.customText,
    required this.controller,
    required this.validator,
    required this.inputFormatters,
    this.readOnly = false,
    this.obsercureText = false,
    this.minline = 1,
    this.maxline = 1,
    this.iconss = const SizedBox(),
    required this.onChanged,
    this.keyoardType,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: obsercureText,
      inputFormatters: inputFormatters,
      keyboardType: keyoardType ?? TextInputType.emailAddress,
      readOnly: readOnly,
      onTapOutside: (event) {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      style: getTextTheme().headlineMedium,
      cursorColor: Colors.black,
      maxLines: maxline,
      minLines: minline,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      decoration: InputDecoration(
        label: Text(customText, style: getTextTheme().displayMedium),
        suffixIcon: iconss,
        hintStyle: const TextStyle(
            fontWeight: FontWeight.w500, color: Color(0xFFC5C5C5)),
        errorStyle: const TextStyle(height: 0, color: ConstColors.red),
        filled: true,
        fillColor: ConstColors.backgroundColor.withOpacity(.7),
        contentPadding:
            const EdgeInsets.symmetric(vertical: 15, horizontal: 16),
        focusedBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          borderSide: BorderSide(width: .6, color: ConstColors.primaryColor),
        ),
        disabledBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          borderSide: BorderSide(width: .6, color: ConstColors.primaryColor),
        ),
        enabledBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          borderSide: BorderSide(width: .6, color: ConstColors.primaryColor),
        ),
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          borderSide: BorderSide(width: .6),
        ),
        errorBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          borderSide: BorderSide(width: .6, color: ConstColors.red),
        ),
        focusedErrorBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          borderSide: BorderSide(width: .6, color: ConstColors.red),
        ),
      ),
      onChanged: onChanged,
      validator: validator,
    );
  }
}
