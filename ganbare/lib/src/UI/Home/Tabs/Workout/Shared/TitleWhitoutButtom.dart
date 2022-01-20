import 'package:flutter/material.dart';

class TitleWithoutButtom extends StatelessWidget {
  const TitleWithoutButtom({
    Key key,
    this.title,
  }) : super(key: key);
  final String title;
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
        ],
      ),
    );
  }
}
