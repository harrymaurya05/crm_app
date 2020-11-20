import 'package:crm_app/Api/authApi.dart';
import 'package:crm_app/Model/login.dart';
import 'package:crm_app/screens/forgetPasswordScreen.dart';
import 'package:crm_app/widget/widget.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

class LoginCard extends StatefulWidget {
  @override
  _LoginCardState createState() => _LoginCardState();
}

class _LoginCardState extends State<LoginCard>
    with SingleTickerProviderStateMixin {
  FocusNode _loginFocusNode;
  FocusNode _passwordFocusNode;
  bool _passwordVisible;
  TextEditingController usernameTextFieldController =
      new TextEditingController();
  TextEditingController passwordTextFieldController =
      new TextEditingController();

  ApiHelper api = new ApiHelper();
  FirebaseMessaging _firebaseMessaging = FirebaseMessaging();

  @override
  void initState() {
    super.initState();
    _loginFocusNode = FocusNode();
    _passwordFocusNode = FocusNode();
    _passwordVisible = true;
    firebaseCloudMessaging_Listeners();
  }

  void firebaseCloudMessaging_Listeners() {
    // var isIOS;
    // if (Platform) iOS_Permission();

    _firebaseMessaging.getToken().then((token) {
      print(token);
    });

    _firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) async {
        print('on message $message');
      },
      onResume: (Map<String, dynamic> message) async {
        print('on resume $message');
      },
      onLaunch: (Map<String, dynamic> message) async {
        print('on launch $message');
      },
    );
  }

  @override
  void dispose() {
    _loginFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment(0.0, 1.0),
      child: Container(
        width: double.infinity,
        height: 380.0,
        decoration: BoxDecoration(
            color: Color(0xFF4D80E4),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
            gradient: LinearGradient(
              colors: [
                Colors.deepPurple,
                Color(0xFF4D80E4),
              ],
              begin: Alignment.bottomCenter,
              stops: [0.0, 0.5],
            )),
        child: Container(
          margin: EdgeInsets.only(
            right: 31.96,
            left: 27.43,
            top: 22,
          ),
          child: Column(
            children: [
              // User Creds TextField
              Container(
                // width: 24.0,
                // height: 24.0,
                child: Column(
                  children: [
                    // Username Text Field
                    UsernameField(
                      loginFocusNode: _loginFocusNode,
                      passwordFocusNode: _passwordFocusNode,
                      textLabel: "Username",
                      usernameController: usernameTextFieldController,
                    ),
                    //Password Text Field
                    PasswordField(
                      passwordVisible: _passwordVisible,
                      passwordFocusNode: _passwordFocusNode,
                      textLabel: "Password",
                      passwordController: passwordTextFieldController,
                    ),
                    //Forget password text
                    Container(
                      child: CustomText(
                        btnText: "Forget Password ?",
                        align: Alignment.bottomRight,
                      ),
                    ),
                  ],
                ),
              ),
              //Login button UI
              Container(
                  child: SignInButton(
                    username: usernameTextFieldController,
                    password: passwordTextFieldController,
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
