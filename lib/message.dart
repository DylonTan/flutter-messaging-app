import 'package:flutter/material.dart';

class Message extends StatelessWidget {
  final String from;
  final String text;
  final bool me;

  const Message({Key key, this.from, this.text, this.me}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment:
            me ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(left: 18, right: 10),
            child: Text(
              from,
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: 18, right: 10, bottom: 18),
            child: Material(
              color: me ? Colors.greenAccent : Colors.green[100],
              borderRadius: BorderRadius.circular(10),
              elevation: 6.0,
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 12, horizontal: 12),
                child: Text(
                  text,
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
