import 'package:flutter/material.dart';
import 'package:ganbare/src/UI/Graph/Exercise_graph.dart';

class NonMonthProgress extends StatefulWidget {

  @override
  _NonMonthProgressState createState() => _NonMonthProgressState();
}

class _NonMonthProgressState extends State<NonMonthProgress> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Positioned(
      top: size.height * 0.45,
      left: 35,
      right: 35,
      child: GestureDetector(
        onTap: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => ExerciseGraph()));
        },
        child: Container(
          padding: EdgeInsets.all(5),
          height: size.height * 0.35,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                  color: Colors.grey, blurRadius: 5.0, offset: Offset(0, 3))
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Text(
                'Progreso del mes',
                style: TextStyle(
                  color: Colors.blue[300],
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(
                height: 4,
              ),
              Padding(
                padding: EdgeInsets.only(top: 15, left: 30, right: 30),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      child: Image.asset(
                        'assets/images/empty.png',
                        fit: BoxFit.cover,
                      ),
                    ),
                    Text(
                      'Aún no hay información aquí ¡Ejercitate!',
                      style: TextStyle(
                          color: Colors.grey[600],
                          fontSize: 10,
                          fontWeight: FontWeight.w800),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
