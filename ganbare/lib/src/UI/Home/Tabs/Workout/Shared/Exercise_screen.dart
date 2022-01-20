import 'package:flutter/material.dart';
import 'package:ganbare/src/UI/Home/Tabs/Workout/Shared/ExerciseList.dart';

class ExerciseScreen extends StatelessWidget {
  const ExerciseScreen({
    this.tag,
    this.image,
    this.minutes,
    this.repetitions,
    this.calories,
    this.description,
    this.press,
    this.list,
    Key key,
  }) : super(key: key);
  final String tag;
  final String image;
  final String minutes;
  final String repetitions;
  final String calories;
  final String description;
  final Function press;
  final String list;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Column(
        children: <Widget>[
          Container(
            height: size.height * 0.35,
            width: size.width * 1,
            decoration: BoxDecoration(
              color: Colors.red[400],
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20),
              ),
            ),
            child: Hero(
              tag: tag,
              child: Image.asset(
                image,
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(
            height: size.height * 0.025,
          ),
          Container(
            alignment: Alignment.center,
            margin: EdgeInsets.symmetric(horizontal: 20.0),
            padding: EdgeInsets.symmetric(horizontal: 20.0),
            height: size.height * 0.08,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  offset: Offset(0, 0),
                  blurRadius: 8,
                  color: Colors.grey,
                )
              ],
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Icon(Icons.timer),
                    SizedBox(
                      width: size.width * 0.025,
                    ),
                    Text(
                      minutes + 'm',
                      style: TextStyle(color: Colors.blue[400]),
                    ),
                    Spacer(),
                    Icon(Icons.fitness_center),
                    SizedBox(
                      width: size.width * 0.025,
                    ),
                    Text(
                      repetitions,
                      style: TextStyle(color: Colors.blue[400]),
                    ),
                    Spacer(),
                    Icon(Icons.person),
                    SizedBox(width: size.width * 0.025),
                    Text(
                      calories + ' Kcal',
                      style: TextStyle(color: Colors.blue[400]),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Container(
            height: size.height * 0.4,
            child: ExerciseList(
              list: list,
            ),
          ),
          Expanded(
            flex: 1,
            child: Container(
              height: size.height * 0.13,
              width: size.width * 0.8,
              padding: EdgeInsets.symmetric(
                vertical: 28.0,
                horizontal: 20.0,
              ),
              child: RaisedButton(
                elevation: 0.0,
                onPressed: press,
                padding: EdgeInsets.all(5.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0),
                ),
                color: Colors.blueAccent,
                child: Text(
                  'Iniciar rutina',
                  style: TextStyle(
                      color: Colors.white,
                      letterSpacing: 1.5,
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                      fontStyle: FontStyle.italic),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
