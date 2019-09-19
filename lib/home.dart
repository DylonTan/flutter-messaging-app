import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import './custom_button.dart';
import './login.dart';
import './signup.dart';

class Home extends StatelessWidget {
  static const String id = 'HOME';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Hero(
                tag: 'logo',
                child: Container(
                  width: 100,
                  child: Image.asset('assets/images/logo.png'),
                  margin: EdgeInsets.only(right: 20),
                ),
              ),
              Text(
                'Connect',
                style: TextStyle(fontSize: 40, color: const Color(0xFF24BF95)),
              ),
            ],
          ),
          SizedBox(
            height: 50,
          ),
          CustomButton(
            callback: () {
              Navigator.of(context).pushNamed(Login.id);
            },
            text: 'Log In',
          ),
          CustomButton(
            callback: () {
              Navigator.of(context).pushNamed(Signup.id);
            },
            text: 'Sign Up',
          )
        ],
      ),
    );
  }
}
