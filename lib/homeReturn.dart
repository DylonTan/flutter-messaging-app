import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import './home.dart';
import './custom_button.dart';
import './chat.dart';

class HomeReturn extends StatelessWidget {
  static const String id = 'HOMERETURN';

  final AsyncSnapshot<FirebaseUser> snapshot;

  HomeReturn({Key key, this.snapshot});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<FirebaseUser>(
      future: FirebaseAuth.instance.currentUser(),
      builder: (BuildContext context, AsyncSnapshot<FirebaseUser> newSnapshot) {
        newSnapshot = snapshot;
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
                      style: TextStyle(
                          fontSize: 40, color: const Color(0xFF24BF95)),
                    ),
                  ],
                ),
                SizedBox(
                  height: 40,
                ),
                Text(
                  'Welcome Back',
                  style:
                      TextStyle(fontSize: 18, color: const Color(0xFF24BF95)),
                ),
                SizedBox(
                  height: 40,
                ),
                CustomButton(
                  callback: () {
                    FirebaseUser user = snapshot.data;
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Chat(user: user)));
                  },
                  text: 'Continue',
                ),
                CustomButton(
                  callback: () {
                    Navigator.of(context).pushNamed(Home.id);
                  },
                  text: 'Log Out',
                ),
              ]),
        );
      },
    );
  }
}
