import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class CustomButton extends StatelessWidget {
  final Function callback;
  final String text;
  final Color color;

  CustomButton({Key key, this.callback, this.text, this.color = Colors.white});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      child: Material(
        color: const Color(0xFF56d1af),
        elevation: 5,
        borderRadius: BorderRadius.circular(30),
        child: MaterialButton(
          child: Text(
            text,
            style: TextStyle(color: color),
          ),
          shape: StadiumBorder(),
          onPressed: callback,
          minWidth: 200,
          height: 45,
        ),
      ),
      padding: EdgeInsets.all(8),
    );
  }
}
