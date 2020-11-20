import 'package:crm_app/Model/login.dart';
import 'package:crm_app/screens/dashBoard.dart';
import 'package:crm_app/widget/widget.dart';
import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class OtpScreen extends StatefulWidget {
  LoginResponse loginResponse;
  OtpScreen({this.loginResponse});

  @override
  _OtpScreenState createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  TextEditingController otpController = new TextEditingController();
  String currentText;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          child: Stack(
            children: [
              Container(
                child: Column(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            InkWell(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(20.0),
                                child: Container(
                                  padding: EdgeInsets.only(
                                      //right: 10.0,
                                      ),
                                  child: Image(
                                    image: AssetImage(
                                      'assest/images/back_arrow_icon.png',
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(
                                //top: 20,
                                left: 40.0,
                              ),
                              decoration: BoxDecoration(
                                  //color: Colors.white,
                                  ),
                              child: Center(
                                child: Image.asset(
                                  'assest/images/crm_logo/crm_logo.png',
                                  width: 204,
                                  height: 74.12,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Container(
                          margin: EdgeInsets.only(
                            top: 30,
                            bottom: 30,
                          ),
                          child: Center(
                            child: Image.asset(
                              'assest/images/signInScreenLogo/signInScreenLogo.png',
                              width: 416,
                              height: 214,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Align(
                alignment: Alignment(0.0, 1.0),
                child: Container(
                  width: double.infinity,
                  height: 350.0,
                  decoration: BoxDecoration(
                    color: Color(0xFF4D80E4),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
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
                            // errorAnimationController: errorController,
                            // controller: widget.otpController,
                            onCompleted: (v) {
                              print("Completed $currentText");
                              // widget.otpController.text = currentText;
                              // widget.otp = currentText;
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
                      ),
                      SubmitButton(
                          loginResponse: widget.loginResponse,
                          otp: currentText),
                      Container(
                        //width: double.infinity,
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => DashBoard()),
                            );
                          },
                          child: CustomText(
                            btnText: "Resend OTP",
                            align: Alignment.center,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
