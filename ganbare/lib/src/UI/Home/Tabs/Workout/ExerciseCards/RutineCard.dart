import 'package:flutter/material.dart';

class RutineCard extends StatelessWidget {
  const RutineCard({
    Key key,
    this.title,
    this.image,
    this.tag,
    this.press,
    @required this.size,
  }) : super(key: key);
  final String title;
  final String image;
  final String tag;
  final Function press;

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: tag,
      child: GestureDetector(
        onTap: press,
        child: Container(
          height: size.height * 0.25,
          width: size.width * 0.75,
          margin: EdgeInsets.only(right: 15.0, left: 15.0),
          padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 15.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15.0),
            image: DecorationImage(
              image: AssetImage(image),
              fit: BoxFit.cover,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                title,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 25,
                    fontWeight: FontWeight.w800),
              )
            ],
          ),
        ),
      ),
    );
  }
}
