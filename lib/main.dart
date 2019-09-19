import 'package:connect/homeReturn.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import './chat.dart';
import './login.dart';
import './signup.dart';
import './custom_button.dart';
import './home.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: new ThemeData(
          primaryColor: const Color(0xFF24BF95),
          primaryTextTheme: TextTheme(title: TextStyle(color: Colors.white)),
          primaryIconTheme: const IconThemeData.fallback().copyWith(
            color: Colors.white,
          )),
      initialRoute: MyHomePage.id,
      routes: {
        MyHomePage.id: (context) => MyHomePage(),
        Signup.id: (context) => Signup(),
        Login.id: (context) => Login(),
        Chat.id: (context) => Chat(),
        Home.id: (context) => Home(),
      },
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatelessWidget {
  static const String id = 'HOMEPAGE';
  final customColor = const Color(0xFF24BF95);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return FutureBuilder<FirebaseUser>(
        future: FirebaseAuth.instance.currentUser(),
        builder: (BuildContext context, AsyncSnapshot<FirebaseUser> snapshot) {
          if (snapshot.hasData) {
            return HomeReturn(snapshot: snapshot);
          } else {
            return Home();
          }
        });
  }
}

//Scaffold(
