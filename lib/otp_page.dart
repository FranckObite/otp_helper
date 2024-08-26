import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'package:otp_autofill/otp_autofill.dart';

class OtpPage extends StatefulWidget {
  const OtpPage(
      {super.key,
      required this.backgroundColor,
      required this.primaryColor,
      required this.secondaryColor,
      required this.onOtpValidated,
      required this.accentColor,
      required this.resendCode,
      required this.localization,
      required this.phoneNumber}); // Ajouter le paramètre phoneNumber

  final Color backgroundColor;
  final Color primaryColor;
  final Color secondaryColor;
  final Color accentColor;
  final Function(String)
      onOtpValidated; // Fonction de rappel pour la validation de l'OTP
  final void Function() resendCode;
  final Map<String, String> localization; // Map pour les traductions
  final String phoneNumber; // Numéro de téléphone

  @override
  State<OtpPage> createState() => _OtpPageState();
}

class _OtpPageState extends State<OtpPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  late TextEditingController controller1;
  late TextEditingController controller2;
  late TextEditingController controller3;
  late TextEditingController controller4;

  final FocusNode focusNode1 = FocusNode();
  final FocusNode focusNode2 = FocusNode();
  final FocusNode focusNode3 = FocusNode();
  final FocusNode focusNode4 = FocusNode();

  bool isEdited1 = false;
  bool isEdited2 = false;
  bool isEdited3 = false;
  bool isEdited4 = false;

  late Timer timer;
  int timeLeft = 30;
  bool canResendCode = false;
  late OTPTextEditController controller;
  late OTPInteractor _otpInteractor;
  String code = '';

  void startCountdown() {
    setState(() {
      timeLeft = 30; // Temps d'attente de 30 secondes
      canResendCode = false; // Désactiver le bouton
    });

    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (mounted) {
        setState(() {
          if (timeLeft > 0) {
            timeLeft--;
          } else {
            canResendCode = true; // Activer le bouton
            timer.cancel();
          }
        });
      }
    });
  }

  @override
  void initState() {
    super.initState();
    startCountdown();

    _initInteractor(); // Initialiser l'interacteur si c'est un numéro de téléphone
    controller = OTPTextEditController(
      codeLength: 4,
      onCodeReceive: (code) =>
          print('============Code reçu - $code =============='),
      otpInteractor: _otpInteractor,
    )..startListenUserConsent(
        (code) {
          final exp = RegExp(r'(\d{4})');
          final otpCode = exp.stringMatch(code ?? '');
          if (otpCode != null && otpCode.isNotEmpty) {
            onOtpReceived(otpCode); // Assigner le code OTP
            return otpCode;
          }
          return ''; // Retour par défaut si pas de code trouvé
        },
      );
    focusNode1.addListener(() => _onFocusChange(1));
    focusNode2.addListener(() => _onFocusChange(2));
    focusNode3.addListener(() => _onFocusChange(3));
    focusNode4.addListener(() => _onFocusChange(4));
    controller1 = TextEditingController();
    controller2 = TextEditingController();
    controller3 = TextEditingController();
    controller4 = TextEditingController();
  }

  Future<void> _initInteractor() async {
    _otpInteractor = OTPInteractor();

    // You can receive your app signature by using this method.
    final appSignature = await _otpInteractor.getAppSignature();

    if (kDebugMode) {
      print('Your app signature: $appSignature');
    }
  }

  // Récuperation ET Assignation du code OTP aux differents contrÖlleurs dédiés
  void onOtpReceived(String otpCode) {
    if (otpCode.length == 4) {
      controller1.text = otpCode[0]; // Premier chiffre
      controller2.text = otpCode[1]; // Deuxième chiffre
      controller3.text = otpCode[2]; // Troisième chiffre
      controller4.text = otpCode[3]; //Quatrième chiffre

      updateCode();
    } else {
      print('Le code OTP n\'a pas la longueur attendue.');
    }
  }

  void updateCode() {
    code =
        '${controller1.text}${controller2.text}${controller3.text}${controller4.text}';
    if (code.length == 4) {
      if (_formKey.currentState!.validate()) {
        widget.onOtpValidated(
            code); // Appeler la fonction de rappel avec le code OTP
      }
    }
  }

  @override
  void dispose() {
    controller1.dispose();
    controller2.dispose();
    controller3.dispose();
    controller4.dispose();
    focusNode1.dispose();
    focusNode2.dispose();
    focusNode3.dispose();
    focusNode4.dispose();
    timer.cancel();

    super.dispose();
  }

  void _onFocusChange(int index) {
    if (mounted) {
      setState(() {
        switch (index) {
          case 1:
            isEdited1 = controller1.text.isNotEmpty;
            break;
          case 2:
            isEdited2 = controller2.text.isNotEmpty;
            break;
          case 3:
            isEdited3 = controller3.text.isNotEmpty;
            break;
          case 4:
            isEdited4 = controller4.text.isNotEmpty;
            break;
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: widget.backgroundColor,
      height: Get.height,
      width: Get.width,
      child: Column(
        children: [
          const SizedBox(
            height: 100,
          ),
          Text(
            widget.localization['verify_phone'] ?? 'Verify Phone',
            style: TextStyle(
                color: widget.primaryColor,
                fontSize: 20,
                fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 15,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                widget.localization['code_sent_to'] ??
                    'The code has been sent to ',
                style: TextStyle(color: widget.accentColor, fontSize: 15),
              ),
              Text(widget.phoneNumber,
                  style: TextStyle(color: widget.accentColor, fontSize: 15))
            ],
          ),
          const SizedBox(
            height: 50,
          ),
          Form(
            key: _formKey,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                otpFieldCustomize(context, controller1, focusNode1, isEdited1),
                const SizedBox(
                  width: 10,
                ),
                otpFieldCustomize(context, controller2, focusNode2, isEdited2),
                const SizedBox(
                  width: 10,
                ),
                otpFieldCustomize(context, controller3, focusNode3, isEdited3),
                const SizedBox(
                  width: 10,
                ),
                otpFieldCustomize(context, controller4, focusNode4, isEdited4),
              ],
            ),
          ),
          const Spacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                widget.localization['resend_code'] ??
                    'Didn\'t receive the OTP code?',
                style: TextStyle(fontSize: 10, color: widget.accentColor),
              ),
              TextButton(
                  onPressed: canResendCode ? widget.resendCode : null,
                  child: canResendCode
                      ? Text(
                          widget.localization['resend_button'] ?? 'Resend Code',
                          style: TextStyle(
                              fontSize: 15, color: widget.primaryColor),
                        )
                      : Row(children: [
                          Text(
                            widget.localization['wait_message'] ??
                                'Please wait',
                            style: TextStyle(
                                color: widget.accentColor, fontSize: 15),
                          ),
                          Text(" $timeLeft ",
                              style: TextStyle(
                                color: widget.primaryColor,
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                              )),
                          Text(
                            widget.localization['seconds'] ?? 's',
                            style: TextStyle(
                                color: widget.accentColor, fontSize: 15),
                          ),
                        ]))
            ],
          ),
          const SizedBox(
            height: 50,
          )
        ],
      ),
    );
  }

  Widget otpFieldCustomize(BuildContext context,
      TextEditingController controller, FocusNode? focusNode, bool isEdited) {
    return SizedBox(
      width: Get.width / 5.5,
      height: 85,
      child: TextFormField(
        validator: (String? value) {
          if (value == null || value.isEmpty) {
            return '';
          }
          return null;
        },
        controller: controller,
        focusNode: focusNode,
        keyboardType: TextInputType.number,
        textAlign: TextAlign.center,
        cursorColor: isEdited ? widget.accentColor : widget.primaryColor,
        maxLength: 1,
        style: TextStyle(
            fontSize: 20,
            color: isEdited ? widget.accentColor : widget.primaryColor,
            fontWeight: FontWeight.bold),
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
                color: isEdited ? widget.primaryColor : widget.accentColor),
            borderRadius: const BorderRadius.all(Radius.circular(20)),
          ),
          fillColor: isEdited ? widget.primaryColor : widget.accentColor,
          filled: true,
          focusedBorder: OutlineInputBorder(
              borderRadius: const BorderRadius.all(Radius.circular(20)),
              borderSide: BorderSide(color: widget.primaryColor)),
          border: OutlineInputBorder(
              borderRadius: const BorderRadius.all(Radius.circular(20)),
              borderSide: BorderSide(color: widget.primaryColor)),
          counterText: '',
        ),
        onChanged: (value) {
          if (mounted) {
            setState(() {
              isEdited = value.isNotEmpty;
            });
          }
          if (value.length == 1) {
            FocusScope.of(context).nextFocus();
          }
          updateCode();
        },
      ),
    );
  }
}
