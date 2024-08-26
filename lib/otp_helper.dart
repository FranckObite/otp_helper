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
    void Function() resendCode,
    Map<String, String> localization, // Ajouter la Map pour les traductions
    String phoneNumber, // Ajouter le numéro de téléphone
  ) {
    return OtpPage(
      backgroundColor: backgroundColor,
      primaryColor: primaryColor,
      secondaryColor: secondaryColor,
      onOtpValidated: onVerification,
      accentColor: accentColor,
      resendCode: resendCode,
      localization:
          localization, // Passer la Map pour les traductions au widget OtpPage
      phoneNumber:
          phoneNumber, // Passer le numéro de téléphone au widget OtpPage
    );
  }
}
