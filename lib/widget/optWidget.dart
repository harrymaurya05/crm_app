import 'dart:async';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class OtpCard extends StatefulWidget {
  TextEditingController otpController;
  String otp;
  OtpCard({this.otpController, this.otp});

  @override
  _OtpCardState createState() => _OtpCardState();
}

class _OtpCardState extends State<OtpCard> {
  var onTapRecognizer;

  //TextEditingController textEditingController = TextEditingController();
  // ..text = "123456";

  StreamController<ErrorAnimationType> errorController;

  bool hasError = false;
  String currentText = "";
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    onTapRecognizer = TapGestureRecognizer()
      ..onTap = () {
        Navigator.pop(context);
      };
    errorController = StreamController<ErrorAnimationType>();
    super.initState();
  }

  @override
  void dispose() {
    errorController.close();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 100.0,
      //color: Colors.red,
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 30.0,
          //vertical: 10.0,
        ),
        child: PinCodeTextField(
          appContext: context,
          length: 5,
          obscureText: false,
          animationType: AnimationType.fade,
          backgroundColor: Colors.transparent,
          textStyle: TextStyle(
            fontSize: 30,
            height: 1.6,
            color: Color(0xFF4D80E4),
            fontWeight: FontWeight.bold,
          ),
          keyboardType: TextInputType.number,
          pinTheme: PinTheme(
              shape: PinCodeFieldShape.box,
              borderRadius: BorderRadius.circular(5.0),
              fieldHeight: 55,
              fieldWidth: 45,
              activeColor: Colors.white,
              disabledColor: Colors.white,
              inactiveFillColor: Colors.white,
              activeFillColor: Colors.white,
              inactiveColor: Colors.white,
              selectedColor: Colors.white,
              selectedFillColor: Colors.white),

          animationDuration: Duration(milliseconds: 300),
          //backgroundColor: Colors.blue.shade50,
          enableActiveFill: true,
          errorAnimationController: errorController,
          controller: widget.otpController,
          onCompleted: (v) {
            print("Completed $currentText");
            widget.otpController.text = currentText;
            widget.otp = currentText;
          },
          onChanged: (value) {
            print(value);
            setState(() {
              currentText = value;
            });
          },
          beforeTextPaste: (text) {
            print("Allowing to paste $text");
            //if you return true then it will show the paste confirmation dialog. Otherwise if false, then nothing will happen.
            //but you can show anything you want here, like your pop up saying wrong paste format or etc
            return true;
          },
        ),
      ),
    );
  }
}
