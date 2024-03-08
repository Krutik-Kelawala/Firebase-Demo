import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:test_project/utilities/common_logic.dart';
import 'package:toastification/toastification.dart';

class CommonWidgets {
  // TODO common print function
  static printFunction(String text) {
    if (kDebugMode) {
      print(text);
    }
  }

  // TODO use common height box
  static heightBox(num textSize, double value) {
    return SizedBox(
      height: textSize * value,
    );
  }

  // TODO use common width box
  static widthBox(num textSize, double value) {
    return SizedBox(
      width: textSize * value,
    );
  }

  // TODO common error toast message method
  static commonErrorToast(String message, BuildContext context) {
    return toastification.show(
        context: context,
        title: Text(message,
            style: GoogleFonts.poppins(
              fontSize: CommonLogic.textSize * 0.02,
              fontWeight: FontWeight.w600,
            )),
        type: ToastificationType.error,
        style: ToastificationStyle.minimal,
        alignment: Alignment.topCenter,
        applyBlurEffect: true,
        progressBarTheme: const ProgressIndicatorThemeData(
          color: Colors.red,
        ),
        autoCloseDuration: const Duration(seconds: 5));
  }

  // TODO common error toast message method
  static commonSuccessToast(String message, BuildContext context) {
    return toastification.show(
        context: context,
        title: Text(message,
            style: GoogleFonts.poppins(
              fontSize: CommonLogic.textSize * 0.02,
              fontWeight: FontWeight.w600,
            )),
        type: ToastificationType.success,
        style: ToastificationStyle.minimal,
        alignment: Alignment.topCenter,
        applyBlurEffect: true,
        progressBarTheme: const ProgressIndicatorThemeData(
          color: Colors.green,
        ),
        autoCloseDuration: const Duration(seconds: 5));
  }
}
