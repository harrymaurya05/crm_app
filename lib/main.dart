import 'package:crm_app/screens/LoginScreen.dart';
import 'package:crm_app/screens/dashBoard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

bool value;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    value = prefs.getBool('isLoggedIn') ?? false;
  } on Exception catch (_) {
    print('never reached');
  }
  
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        textTheme: GoogleFonts.nunitoSansTextTheme(
          Theme.of(context).textTheme,
        ),
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  FlutterSecureStorage storage;

  @override
  void initState() {
    super.initState();
    _readAll();
  }

  @override
  void dispose() {
    super.dispose();
    //storage = null;
  }

  Future<Null> _readAll() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    value = prefs.getBool('isLoggedIn') ?? false;

    //return value;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: value == true ? DashBoard() : LoginPage(),
    );
  }
}
