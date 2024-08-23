import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:otp_helper/otp_helper.dart';
import 'package:otp_autofill/otp_autofill.dart';

class MockOTPInteractor extends Mock implements OTPInteractor {
  @override
  Future<String?> getAppSignature() async {
    return Future.value('mockSignature');
  }
}

void main() {
  testWidgets('OtpPage displays correctly', (WidgetTester tester) async {
    // Mock the OTPInteractor
    final mockOTPInteractor = MockOTPInteractor();
    when(mockOTPInteractor.getAppSignature())
        .thenAnswer((_) => Future.value('mockSignature'));

    // Build our app and trigger a frame.
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: OtpHelper.showOtpPage(
            Colors.white, // backgroundColor
            Colors.blue, // primaryColor
            Colors.green, // secondaryColor
            (code) {
              // Handle OTP validation
              print('OTP Code: $code');
            },
            Colors.red, // accentColor
          ),
        ),
      ),
    );

    // Verify that the getAppSignature method was called.
    verify(mockOTPInteractor.getAppSignature()).called(1);

    // Verify that the OtpPage displays the correct text.
    expect(find.text('Vérifier le téléphone'), findsOneWidget);
    expect(find.text('Le code a été envoyé à '), findsOneWidget);

    // Verify that the OTP input fields are displayed.
    expect(find.byType(TextFormField), findsNWidgets(4));

    // Enter OTP code.
    await tester.enterText(find.byType(TextFormField).first, '1');
    await tester.enterText(find.byType(TextFormField).at(1), '2');
    await tester.enterText(find.byType(TextFormField).at(2), '3');
    await tester.enterText(find.byType(TextFormField).at(3), '4');

    // Verify that the OTP code is updated.
    await tester.pump();
    expect(find.text('1'), findsOneWidget);
    expect(find.text('2'), findsOneWidget);
    expect(find.text('3'), findsOneWidget);
    expect(find.text('4'), findsOneWidget);
  });
}
