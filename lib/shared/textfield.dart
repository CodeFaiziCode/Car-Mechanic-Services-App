import 'package:car_fix_up/resources/constatnt.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomTextField extends StatefulWidget {
  final String hintText;
  final TextEditingController controller;
  final TextInputType inputType;
  final bool isPasswordField;
  final String placeHolder;
  final void Function(String)? onChanged;

  CustomTextField({
    super.key,
    required this.hintText,
    required this.controller,
    required this.inputType,
    this.isPasswordField = false,
    required this.placeHolder,
    this.onChanged,
  });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool isObscure = true;
  late FocusNode _focusNode;

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        TextField(
            focusNode: _focusNode,
            style: GoogleFonts.oxanium(
                fontSize: 15.sp,
                fontWeight: FontWeight.w500,
                color: kPrimaryColor),
            onChanged: widget.onChanged,
            controller: widget.controller,
            keyboardType: widget.inputType,
            obscureText: widget.isPasswordField ? isObscure : false,
            decoration: InputDecoration(
              suffixIcon: widget.isPasswordField
                  ? IconButton(
                      onPressed: () {
                        setState(() {
                          isObscure = !isObscure;
                        });
                      },
                      icon: Icon(
                        isObscure ? Icons.visibility_off : Icons.visibility,
                        color: kWhiteColor,
                      ),
                    )
                  : null,
              hintText: widget.hintText,
              hintStyle: GoogleFonts.oxanium(
                  fontSize: 15.sp,
                  fontWeight: FontWeight.w500,
                  color: kWhiteColor),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
                borderSide: const BorderSide(color: Colors.grey),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
                borderSide: const BorderSide(color: kPrimaryColor),
              ),
              disabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: const BorderSide(color: kPrimaryColor)),
            )),
        SizedBox(height: 1.h),
        Align(
          alignment: Alignment.centerLeft,
          child: Padding(
            padding: const EdgeInsets.only(left: 10.0),
            child: Text(widget.placeHolder,
                style: GoogleFonts.oxanium(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w500,
                    color: kDangerColor)),
          ),
        ),
      ],
    );
  }
}
