import 'package:flutter/material.dart';

class SendButton extends StatelessWidget {
  final VoidCallback callback;

  SendButton({Key key, this.callback});

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      onPressed: callback,
      padding: EdgeInsets.only(top: 20, bottom: 20),
      child: IconTheme(data: new IconThemeData(color: const Color(0xFF24BF95)), child: Icon(Icons.arrow_forward),),
    );
  }
}