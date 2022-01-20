import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ganbare/src/Services/Database.dart';
import 'package:ganbare/src/UI/Graph/Exercise_graph.dart';

class RutineCompleted extends StatefulWidget {
  final String categoryname;
  final int ejercicios;
  final String duracion;
  final double calories;

  const RutineCompleted({
    Key key,
    this.categoryname,
    this.calories,
    this.ejercicios,
    this.duracion,
  }) : super(key: key);
  @override
  _RutineCompletedState createState() => _RutineCompletedState();
}

class _RutineCompletedState extends State<RutineCompleted> {
  final user = FirebaseAuth.instance.currentUser;
  final CollectionReference coleccion =
      FirebaseFirestore.instance.collection('Users');

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitDown, DeviceOrientation.portraitUp]);
    return WillPopScope(
      onWillPop: () {
        return showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Rutina iniciada'),
            content: Text('Por el momento no puedes salir'),
            actions: <Widget>[
              FlatButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('Ok'))
            ],
          ),
        );
      },
      child: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Expanded(
              flex: 4,
              child: Container(
                alignment: Alignment.center,
                padding: EdgeInsets.all(0),
                child: Image.asset(
                  'assets/images/complete.png',
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Column(
                children: <Widget>[
                  Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.only(left: 40, right: 40),
                    child: Text(
                      '¡Lo hiciste muy bien!',
                      style: TextStyle(
                          color: Colors.blue[300],
                          fontSize: 30,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 2,
              child: Container(
                child: Row(
                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.only(left: 20),
                          decoration: BoxDecoration(color: Colors.white),
                          child: Text(
                            widget.ejercicios.toString(),
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 25,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.only(left: 20),
                          decoration: BoxDecoration(color: Colors.white),
                          child: Text(
                            'Ejercicios',
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 20,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                      ],
                    ),
                    Spacer(),
                    Column(
                      children: <Widget>[
                        Container(
                          decoration: BoxDecoration(color: Colors.white),
                          child: Text(
                            widget.calories.toString(),
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 25,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(color: Colors.white),
                          child: Text(
                            'Kcal',
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 20,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                      ],
                    ),
                    Spacer(),
                    Column(
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.only(right: 20),
                          decoration: BoxDecoration(color: Colors.white),
                          child: Text(
                            widget.duracion + ' min',
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 25,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.only(right: 20),
                          decoration: BoxDecoration(color: Colors.white),
                          child: Text(
                            'Duración',
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 20,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 3,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.only(left: 20, right: 20),
                    child: Container(
                      height: 80.0,
                      width: 400.0,
                      padding: EdgeInsets.only(top: 10, bottom: 10),
                      child: StreamBuilder(
                          stream: coleccion.doc(user.uid).snapshots(),
                          builder:
                              (BuildContext context, AsyncSnapshot snapshot) {
                            return RaisedButton(
                              elevation: 5.0,
                              onPressed: () async {
                                await DatabaseServices(uid: user.uid)
                                    .newExerciseData(widget.categoryname,
                                        widget.calories, widget.ejercicios);
                                await coleccion.doc(user.uid).update({
                                  'weigth': ((snapshot.data.data()['weigth'])
                                          .toDouble() -
                                      (widget.calories / 7000))
                                });
                                await coleccion.doc(user.uid).update({
                                  'IMC': (snapshot.data.data()['weigth']) /
                                      ((snapshot.data.data()['height']) *
                                          (snapshot.data.data()['height']))
                                });
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => ExerciseGraph()));
                              },
                              padding: EdgeInsets.all(5.0),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30.0),
                              ),
                              color: Colors.blueAccent,
                              child: Text(
                                'Continuar',
                                style: TextStyle(
                                    color: Colors.white,
                                    letterSpacing: 1.5,
                                    fontSize: 25.0,
                                    fontWeight: FontWeight.bold,
                                    fontStyle: FontStyle.italic),
                              ),
                            );
                          }),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
