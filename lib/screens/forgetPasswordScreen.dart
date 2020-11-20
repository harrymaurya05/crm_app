import 'dart:ui';

import 'package:crm_app/widget/widget.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ForgetPassword extends StatefulWidget {
  ForgetPassword({Key key}) : super(key: key);

  @override
  _ForgetPasswordState createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
  FocusNode _loginFocusNode;
  FocusNode _emailFocusNode;
  bool _passwordVisible;

  @override
  void initState() {
    super.initState();
    _loginFocusNode = FocusNode();
    _emailFocusNode = FocusNode();
    _passwordVisible = true;
  }

  @override
  void dispose() {
    _loginFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: EdgeInsets.all(20.0),
        child: Column(
          children: [
            Row(
              children: [
                Container(
                  child: InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Image(
                      image: AssetImage(
                        'assest/images/back_arrow_icon.png',
                      ),
                      color: Color(0xFF4D80E4),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(
                    left: 12.0,
                  ),
                  child: Text(
                    "Back",
                    style: TextStyle(
                      color: Color(0xFF4D80E4),
                      fontSize: 17.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            Container(
              margin: EdgeInsets.symmetric(
                horizontal: 75.0,
                vertical: 20.0,
              ),
              decoration: BoxDecoration(
                  //color: Colors.white,
                  ),
              child: Center(
                child: Image.asset(
                  'assest/images/crm_logo/crm_logo@2x.png',
                  width: 226,
                  height: 82.0,
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(
                top: 20.0,
                left: 100.0,
                right: 99.0,
              ),
              child: Text(
                "Forget Password ?",
                style: TextStyle(
                  color: Color(0xFF000000),
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(
                horizontal: 24.0,
                vertical: 24.0,
              ),
              child: Text(
                "Enter your Username and Email address below to reset your password.",
                style: GoogleFonts.metrophobic(
                  textStyle: Theme.of(context).textTheme.display1,
                  fontSize: 14.0,
                  color: Color(0xFF707070),
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            UsernameField(
              loginFocusNode: _loginFocusNode,
              passwordFocusNode: _emailFocusNode,
              textLabel: "Username",
            ),
            //Password Text Field
            EmailField(
              emailFocusNode: _emailFocusNode,
              textLabel: "Email",
            ),
            ForgetPasswordSubmit(),
          ],
        ),
      ),
    );
  }
}
