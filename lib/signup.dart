import './custom_button.dart';
import './chat.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Signup extends StatefulWidget {
  static const String id = 'SIGNUP';

  @override
  _SignupState createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  String email;
  String password;

  final FirebaseAuth _auth = FirebaseAuth.instance;

  final _scaffoldKey = GlobalKey<ScaffoldState>();

  Future<void> registerUser() async {
    bool emailValid =
        RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(email);

    if (emailValid) {
      FirebaseUser user = (await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password.replaceAll(' ', ''),
      ))
          .user;

      Navigator.push(
          context, MaterialPageRoute(builder: (context) => Chat(user: user)));
    } else {
      _displaySnackBar(context);
    }
  }

  void _displaySnackBar(BuildContext context) {
    final snackBar = SnackBar(
      content: Text('Email or password not valid'),
      action: SnackBarAction(
        label: 'TRY AGAIN',
        onPressed: registerUser,
      ),
    );
    _scaffoldKey.currentState.showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text(
          'Sign Up',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              height: 40,
            ),
            Expanded(
              child: Hero(
                tag: 'logo',
                child: Container(
                  child: Image.asset('assets/images/logo.png'),
                  padding: EdgeInsets.only(top: 20),
                ),
              ),
            ),
            SizedBox(
              height: 40,
            ),
            TextField(
                keyboardType: TextInputType.emailAddress,
                onChanged: (value) => email = value,
                decoration: InputDecoration(
                    hintText: 'Enter your email',
                    border: const OutlineInputBorder())),
            SizedBox(
              height: 20,
            ),
            TextField(
                autocorrect: false,
                obscureText: true,
                onChanged: (value) => password = value,
                decoration: InputDecoration(
                    hintText: 'Enter your password',
                    border: const OutlineInputBorder())),
            SizedBox(
              height: 40,
            ),
            CustomButton(
              text: 'Sign Up',
              callback: () async {
                await registerUser();
              },
            ),
            SizedBox(
              height: 40,
            ),
          ]),
    );
  }
}
