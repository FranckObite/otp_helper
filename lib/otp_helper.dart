library otp_helper;

import 'package:flutter/material.dart';

import 'otp_page.dart';

class OtpHelper {
  static Widget showOtpPage(
    Color backgroundColor,
    Color primaryColor,
    Color secondaryColor,
    Function(String) onVerification,
    Color accentColor,
  ) {
    return OtpPage(
      backgroundColor: backgroundColor,
      primaryColor: primaryColor,
      secondaryColor: secondaryColor,
      onOtpValidated: onVerification,
      accentColor: accentColor,
    );
  }
}
