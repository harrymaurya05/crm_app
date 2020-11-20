import 'package:crm_app/Api/authApi.dart';
import 'package:crm_app/Model/login.dart';
import 'package:crm_app/screens/dashBoard.dart';
import 'package:crm_app/screens/optScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:crm_app/Model/login.dart';

import '../main.dart';

class UsernameField extends StatelessWidget {
  FocusNode loginFocusNode, passwordFocusNode;
  TextEditingController usernameController;
  String textLabel;
  UsernameField(
      {this.loginFocusNode,
      this.passwordFocusNode,
      this.textLabel,
      this.usernameController});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Container(
        child: TextField(
          focusNode: loginFocusNode,
          controller: usernameController,
          decoration: InputDecoration(
            labelText: textLabel,
            labelStyle: TextStyle(
              fontSize: 20.0,
              color: Colors.black,
            ),
          ),
          onSubmitted: (value) {
            passwordFocusNode.requestFocus();
          },
        ),
      ),
    );
  }
}

class EmailField extends StatefulWidget {
  FocusNode emailFocusNode;
  String textLabel;
  EmailField({this.emailFocusNode, this.textLabel});
  @override
  _EmailFieldState createState() => _EmailFieldState();
}

class _EmailFieldState extends State<EmailField> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: TextField(
        focusNode: widget.emailFocusNode,
        decoration: InputDecoration(
          labelText: widget.textLabel,
          labelStyle: TextStyle(
            fontSize: 20.0,
            color: Colors.black,
          ),
        ),
        onSubmitted: (value) {
          widget.emailFocusNode.requestFocus();
        },
      ),
    );
  }
}

class PasswordField extends StatefulWidget {
  bool passwordVisible;
  FocusNode passwordFocusNode;
  String textLabel;
  TextEditingController passwordController;
  PasswordField(
      {this.passwordVisible,
      this.passwordFocusNode,
      this.textLabel,
      this.passwordController});
  @override
  _PasswordFieldState createState() => _PasswordFieldState();
}

class _PasswordFieldState extends State<PasswordField> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        top: 13.93,
      ),
      child: TextField(
        obscureText: widget.passwordVisible,
        controller: widget.passwordController,
        //textDirection: TextDirection.value                     //textAlign: TextAlign.right,
        focusNode: widget.passwordFocusNode,
        decoration: InputDecoration(
          //hintText: "Username",
          labelText: widget.textLabel,
          labelStyle: TextStyle(
            fontSize: 20.0,
            color: Colors.black,
          ),
          // icon: Icon(
          //   Icons.lock,
          //   color: Colors.grey,
          // ),
          suffixIcon: IconButton(
            icon: Icon(
              Icons.visibility,
              color: Colors.grey,
            ),
            onPressed: () {
              setState(() {
                widget.passwordVisible = !widget.passwordVisible;
              });
            },
          ),
        ),
      ),
    );
  }
}

class CustomText extends StatefulWidget {
  String btnText;
  Alignment align;
  CustomText({this.btnText, this.align});

  @override
  _CustomTextState createState() => _CustomTextState();
}

class _CustomTextState extends State<CustomText> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        top: 5,
      ),
      child: Align(
        alignment: widget.align,
        child: Text(
          widget.btnText,
          style: TextStyle(
              color: Color(0xFFFFFFFF),
              fontSize: 15,
              fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}

class SignInButton extends StatefulWidget {
  TextEditingController username;
  TextEditingController password;

  SignInButton({this.username, this.password});
  @override
  _SignInButtonState createState() => _SignInButtonState();
}

class _SignInButtonState extends State<SignInButton> {
  ApiHelper api = new ApiHelper();
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment(0.0, 0.1),
      child: GestureDetector(
        onTap: () async {
          print("clicked");

          //Future<LoginResponse> loginResponse;
          String username = widget.username.text;
          String password = widget.password.text;
          print("name $username password $password");
          LoginResponse loginResponse = await api.login(username, password);
          //User user = loginResponse.data;
          //print(loginResponse.status);
          if (int.parse(loginResponse.data.factor_auth) == 1) {
            bool successFlag =
                await api.sendOTP(loginResponse.data.access_token);
            if (successFlag) {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => OtpScreen(
                  loginResponse: loginResponse,
                )),
              );
            }
          } else {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => DashBoard(
                        loginResponse: loginResponse,
                      )),
            );
          }
        },
        child: Container(
          margin: EdgeInsets.only(
            top: 30.0,
          ),
          width: 130.0,
          height: 55.0,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20.0),
              border: Border.all(
                color: Colors.white,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: Offset(5, 5), // changes position of shadow
                ),
              ],
              gradient: LinearGradient(
                colors: [
                  Colors.deepPurple,
                  Color(0xFF4D80E4),
                ],
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
              )),
          child: Image(
            image: AssetImage("assest/images/signInTextButton.png"),
          ),
        ),
      ),
    );
  }
}

class SubmitButton extends StatefulWidget {
  LoginResponse loginResponse;
  String otp;
  SubmitButton({this.loginResponse, this.otp});
  @override
  _SubmitButtonState createState() => _SubmitButtonState();
}

class _SubmitButtonState extends State<SubmitButton> {
  ApiHelper api = new ApiHelper();
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment(0.0, 0.1),
      child: GestureDetector(
        onTap: () async {
          OtpResponse otpResponse = await api.verifyOtp(widget.loginResponse.data.access_token , widget.otp);
          //User user = loginResponse.data;
          //print(loginResponse.status);
          if (otpResponse.status == 7000) {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => DashBoard(
                        loginResponse: widget.loginResponse,
                      )),
            );
          }
        },
        child: Container(
          margin: EdgeInsets.only(
            top: 30.0,
          ),
          width: 130.0,
          height: 55.0,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20.0),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                spreadRadius: 5,
                blurRadius: 7,
                offset: Offset(5, 5), // changes position of shadow
              ),
            ],
          ),
          child: Center(
            child: Text(
              "Submit",
              style: TextStyle(
                fontSize: 25.0,
                color: Color(0xFF4D80E4),
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class ForgetPasswordSubmit extends StatefulWidget {
  @override
  _ForgetPasswordSubmitState createState() => _ForgetPasswordSubmitState();
}

class _ForgetPasswordSubmitState extends State<ForgetPasswordSubmit> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Align(
        alignment: Alignment(0.0, 0.1),
        child: GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => MyApp()),
            );
          },
          child: Container(
            margin: EdgeInsets.only(
              top: 30.0,
            ),
            width: 224.0,
            height: 43.0,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20.0),
              color: Color(0xFF4D80E4),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: Offset(5, 5), // changes position of shadow
                ),
              ],
            ),
            child: Center(
              child: Text(
                "Reset Password",
                style: TextStyle(
                  fontSize: 15.0,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
