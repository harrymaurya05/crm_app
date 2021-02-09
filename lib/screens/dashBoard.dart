import 'package:crm_app/Api/authApi.dart';
import 'package:crm_app/Model/login.dart';
import 'package:crm_app/screens/loginScreen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../main.dart';

SharedPreferences prefs;

class DashBoard extends StatefulWidget {
  LoginResponse loginResponse;
  DashBoard({this.loginResponse});
  @override
  _DashBoardState createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {
  SharedPreferences prefs;
  // ignore: non_constant_identifier_names
  String profile_image;
  @override
  void initState() {
    // ignore: todo
    // TODO: implement initState

    super.initState();
    profile_image = "";
    sheared();
  }

  Future<Null> sheared() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    profile_image = prefs.getString('profile_image');
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    if (profile_image == "") {
      return SafeArea(child: Scaffold(body: Container()));
    } else {
      return SafeArea(
        child: Scaffold(
          body: Container(
            child: InkWell(
              // onTap: () {
              //   Navigator.pop(context);
              // },
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Container(
                  padding: EdgeInsets.only(
                      //right: 10.0,
                      ),
                  child: Column(
                    children: [
                      // Image(
                      //   image: AssetImage(
                      //     'assest/images/back_arrow_icon.png',
                      //   ),
                      // ),
                      Image(
                        // image: NetworkImage(
                        //     "http://192.168.1.5/suitecrm/index.php?entryPoint=user_profile&id=1_photo&type=Users&preview=yes"),
                        image: NetworkImage(profile_image),
                        width: double.infinity,
                        height: 200.0,
                      ),
                      Text(widget.loginResponse.data.first_name +
                          "" +
                          widget.loginResponse.data.last_name),
                      const SizedBox(height: 30),
                      RaisedButton(
                        onPressed: () async {
                          ApiHelper api = new ApiHelper();
                          String access_token = widget.loginResponse == null
                              ? prefs.getString('access_token')
                              : widget.loginResponse.data.access_token;
                          bool logout = await api.logout(access_token);
                          if (logout) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => MyApp()),
                            );
                          }
                        },
                        child: const Text('Logout',
                            style: TextStyle(fontSize: 20)),
                      ),
                      const SizedBox(height: 30),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      );
    }
  }

  String buildString2() => prefs.getString('profile_image');
}
