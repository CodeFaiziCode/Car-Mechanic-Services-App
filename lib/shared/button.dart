import 'package:car_fix_up/resources/constatnt.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomButton extends StatefulWidget {
  final String text;
  final Function() onPressed;
  final bool isLoading;
  final Color textColor;
  final Color buttonColor;
  const CustomButton(
      {super.key,
      required this.text,
      required this.onPressed,
      this.isLoading = false,
      required this.textColor,
      required this.buttonColor});

  @override
  State<CustomButton> createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onPressed,
      child: Container(
        height: 50.h,
        width: 1.sw,
        decoration: BoxDecoration(
          color: widget.buttonColor,
          borderRadius: BorderRadius.circular(50),
        ),
        child: Center(
          child: widget.isLoading
              ? const CircularProgressIndicator(
                  color: kWhiteColor,
                )
              : Text(widget.text,
                  style: GoogleFonts.oxanium(
                      fontSize: 20.sp,
                      fontWeight: FontWeight.bold,
                      color: widget.textColor)),
        ),
      ),
    );
  }
}
