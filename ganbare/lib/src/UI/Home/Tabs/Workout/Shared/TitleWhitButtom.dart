import 'package:flutter/material.dart';

class TitleWithButtom extends StatelessWidget {
  const TitleWithButtom({
    Key key,
    this.title,
    this.press,
  }) : super(key: key);
  final String title;
  final Function press;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      child: Row(
        children: <Widget>[
          Text(
            title,
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.w800),
          ),
          Spacer(),
          FlatButton(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              color: Colors.red[400],
              onPressed: press,
              child: Text(
                'Ver todos',
                style: TextStyle(color: Colors.white),
              ))
        ],
      ),
    );
  }
}
