library otp_helper;

import 'package:flutter/material.dart';

import 'otp_page.dart';

class OtpHelper {
  static showOtpPage(
      BuildContext context,
      Color backgroundColor,
      Color primaryColor,
      Color secondaryColor,
      Function(String) onVerification) async {
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return OtpPage(
          backgroundColor: backgroundColor,
          primaryColor: primaryColor,
          secondaryColor: secondaryColor,
        );
      },
    );
  }
}
