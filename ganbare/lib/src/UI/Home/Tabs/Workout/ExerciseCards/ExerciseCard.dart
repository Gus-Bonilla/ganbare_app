import 'package:flutter/material.dart';

class ExerciseCard extends StatelessWidget {
  const ExerciseCard({
    Key key,
    this.title,
    this.image,
    this.press,
    this.tag,
  }) : super(key: key);
  final String title;
  final String image;
  final String tag;
  final Function press;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Hero(
      tag: tag,
      child: GestureDetector(
        onTap: press,
        child: Container(
          height: size.height * 0.20,
          width: size.width * 0.35,
          margin: EdgeInsets.only(left: 15.0, right: 5.0, bottom: 10.0),
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
                    fontSize: 20,
                    fontWeight: FontWeight.w800),
              )
            ],
          ),
        ),
      ),
    );
  }
}
