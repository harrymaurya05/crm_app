import 'package:crm_app/Api/authApi.dart';
import 'package:crm_app/Model/login.dart';
import 'package:crm_app/widget/loginWidget.dart';
import 'package:flutter/material.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  
  @override
  void initState() {
    // TODO: implement initState
    

    super.initState();
  }



  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
            ),
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.only(
                    top: 20,
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
          ),
          LoginCard(),
        ],
      ),
    );
  }
}
