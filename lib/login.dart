import './custom_button.dart';
import './chat.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Login extends StatefulWidget {
  static const String id = 'LOGIN';

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  String email;
  String password;
  bool _isChecked = false;

  final emailKey = 'user_email_key';
  final passwordKey = 'user_password_key';

  final FirebaseAuth _auth = FirebaseAuth.instance;

  final _scaffoldKey = GlobalKey<ScaffoldState>();

  TextEditingController emailTextEditingController = TextEditingController();
  TextEditingController passwordTextEditingController = TextEditingController();

  Future<void> loginUser(String email, String password) async {
    try {
      FirebaseUser user = (await _auth.signInWithEmailAndPassword(
        email: email,
        password: password.replaceAll(' ', ''),
      ))
          .user;

      if (_isChecked) {
        _saveInfo(email, password);
      } else {
        _deleteInfo();
      }

      Navigator.push(
          context, MaterialPageRoute(builder: (context) => Chat(user: user)));
    } catch (e) {
      _displaySnackBar(context);
    }
  }

  _saveInfo(String email, String password) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(emailKey, email);
    prefs.setString(passwordKey, password);
  }

  _deleteInfo() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(emailKey, null);
    prefs.setString(passwordKey, null);
  }

  void _displaySnackBar(BuildContext context) {
    final snackBar = SnackBar(
      content: Text('Email or password incorrect.'),
      action: SnackBarAction(
        label: 'TRY AGAIN',
        onPressed: () {
          loginUser(email, password);
        },
      ),
    );
    _scaffoldKey.currentState.showSnackBar(snackBar);
  }

  checkForInfo() async {
    final prefs = await SharedPreferences.getInstance();
    email = prefs.getString(emailKey);
    password = prefs.getString(passwordKey);
    emailTextEditingController.text = email;
    passwordTextEditingController.text = password;
  }

  @override
  Widget build(BuildContext context) {
    checkForInfo();

    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text(
          'Log In',
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
                controller: emailTextEditingController,
                keyboardType: TextInputType.emailAddress,
                onChanged: (value) => email = value,
                decoration: InputDecoration(
                    hintText: 'Enter your email',
                    border: const OutlineInputBorder())),
            SizedBox(
              height: 20,
            ),
            TextField(
                controller: passwordTextEditingController,
                autocorrect: false,
                obscureText: true,
                onChanged: (value) => password = value,
                decoration: InputDecoration(
                    hintText: 'Enter your password',
                    border: const OutlineInputBorder())),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Checkbox(
                  value: _isChecked,
                  onChanged: (bool value) {
                    setState(() {
                      _isChecked = value;
                    });
                  },
                ),
                Text('Save password'),
              ],
            ),
            SizedBox(
              height: 40,
            ),
            CustomButton(
              text: 'Log In',
              callback: () async {
                await loginUser(email, password);
              },
            ),
            SizedBox(
              height: 40,
            ),
          ]),
    );
  }
}
