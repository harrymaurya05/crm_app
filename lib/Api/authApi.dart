import 'dart:async';
import 'dart:convert';
import 'package:crm_app/Model/login.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

const String IS_LOGIN = "SECURE_NOTE_KEY";

class ApiHelper {
  //String baseUrl = "http://192.168.1.5:80/suitecrm/Api"; // for local
  String baseUrl =
      "https://stg1mayberrycrm.milnp.net/Api/index.php"; // prod
  //String client_id = "c02198ed-1583-b950-b918-5f17ebadd31e"; // local
  String client_id = "39211f3e-27e4-40d5-6d77-6006a7824afa"; // prod
  FlutterSecureStorage storage = new FlutterSecureStorage();

  /* Demo Api call */
  Future<DemoModel> demoApiCall() async {
    final response =
        await http.get('https://jsonplaceholder.typicode.com/albums/1');

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      print(jsonDecode(response.body));
      return DemoModel.fromJson(jsonDecode(response.body));
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      int temp = response.statusCode;
      print("Some Error Occured $temp");
      throw Exception('Failed to load album');
    }
  }

  /* Login API */
  Future<LoginResponse> login(String username, String password) async {
    FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
    String token = await _firebaseMessaging.getToken();
    Map body = {
      'grant_type': 'password',
      'client_id': client_id,
      'client_secret': '123456',
      'username': username,
      'password': password,
      'device_token': token,
      'device_type': 'android',
    };
    //print(BodyElement.onlineEvent);
    http.Response response = await http.post(
      "$baseUrl/access_token",
      headers: {
        'Content-Type': 'application/x-www-form-urlencoded',
        'Accept': '*/*',
        'Charset': 'gzip, deflate, br',
      },
      body: body,
    );
    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      //print((response.body));
      //LoginResponse loginResponse = LoginResponse();
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs?.setBool("isLoggedIn", true);
      var data = jsonDecode(response.body);
      prefs?.setString("access_token", data['data']['user']['access_token']);
      prefs?.setString("profile_image", data['data']['user']['profile_image']);
      return LoginResponse.fromJson(data);
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      int temp = response.statusCode;
      print("Some Error Occured $temp");
      throw Exception('Failed to load album');
    }
  }

  // Logout
  Future<bool> logout(String access_token) async {
    http.Response response = await http.post(
      '$baseUrl/V8/logout',
      headers: {
        'Authorization': 'Bearer $access_token',
      },
    );
    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs?.clear();
      return true;
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      int temp = response.statusCode;
      print("Some Error Occured $temp");
      throw Exception('Failed to load album');
    }
  }

  Future<bool> sendOTP(String access_token) async {
    http.Response response = await http.get(
      '$baseUrl/V8/send-otp',
      headers: {
        'Authorization': 'Bearer $access_token',
      },
    );
    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.

      return true;
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      int temp = response.statusCode;
      print("Some Error Occured $temp");
      throw Exception('Failed to load album');
    }
  }

  Future<OtpResponse> verifyOtp(String access_token, String opt) async {
    Map request = {
      'otp': opt,
    };
    Map data = {"request": request};
    http.Response response = await http.post(
      '$baseUrl/V8/factor-auth/verify',
      headers: {
        'Authorization': 'Bearer $access_token',
        'Content-Type': 'application/json'
      },
      body: jsonEncode(data),
    );
    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      // SharedPreferences prefs = await SharedPreferences.getInstance();
      // prefs?.setBool("isLoggedIn", true);
      // prefs?.setString("access_token", access_token);
      return OtpResponse.fromJson(jsonDecode(response.body));
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      int temp = response.statusCode;
      print("Some Error Occured $temp");
      throw Exception('Failed to load album');
    }
  }
}
