<!--
This README describes the package. If you publish this package to pub.dev,
this README's contents appear on the landing page for your package.

For information about how to write a good package README, see the guide for
[writing package pages](https://dart.dev/tools/pub/writing-package-pages).

For general information about developing packages, see the Dart guide for
[creating packages](https://dart.dev/guides/libraries/create-packages)
and the Flutter guide for
[developing packages and plugins](https://flutter.dev/to/develop-packages).
-->

## otp_helper

`otp_helper` is a Flutter package that makes it easy to integrate a One-Time Password (OTP) verification page into your app. This package allows you to customize the appearance of the OTP page and manage OTP code validation.

##Features

- **Color customization**: You can set background, primary, secondary and accent colors.
- **OTP Validation**: Handles OTP code validation and calls a callback function when the code is validated.
- **OTP code resend**: Includes a mechanism for resending the OTP code after a timeout.
- **Intuitive User Interface**: Provides a simple and intuitive user interface for OTP code entry.

## Getting started

To start using `otp_helper`, add the dependency to your `pubspec.yaml` file:

```yaml
dependencies:
  top_helper: ^1.0.0
```

## Usage

```Dart
import 'package:flutter/material.dart';
import 'package:top_helper/otp_helper.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('OTP Verification'),
        ),
        body: OtpHelper.showOtpPage(
          backgroundColor: Colors.white,
          primaryColor: Colors.blue,
          secondaryColor: Colors.grey,
          accentColor: Colors.black,
          onVerification: (code) {
            print('OTP Code: $code');
            // Add your verification logic here
          },
          resendCode: () {
            // Add your code return logic here
          },
          localization: {
            'verify_phone': 'Vérifier le téléphone',
            'code_sent_to': 'Le code a été envoyé à ',
            'resend_code': 'Vous n\'avez pas reçu le code OTP ?',
            'resend_button': 'Renvoyer le code',
            'wait_message': 'Veuillez attendre',
            'seconds': 's',
          }, // Set translations here
          phoneNumber: '+225 0757492578', // Set phone number here or email
        ),
      ),
    );
  }
}

```

# Author

Franck Obité / obitefrank@gmail.com

# License

MIT License
