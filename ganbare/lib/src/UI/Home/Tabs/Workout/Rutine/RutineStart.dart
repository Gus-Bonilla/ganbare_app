import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ganbare/src/Services/Router.dart';

class RutineStart extends StatefulWidget {
  final Function press;
  final Function info;
  final String ejercicio;

  const RutineStart({Key key, this.press, this.ejercicio, this.info})
      : super(key: key);
  @override
  _RutineStartState createState() => _RutineStartState();
}

class _RutineStartState extends State<RutineStart> {
  CountDownController _controller = CountDownController();

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitDown, DeviceOrientation.portraitUp]);
    return MaterialApp(
      onGenerateRoute: Routerer.generateRoute,
      home: WillPopScope(
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
                  ));
        },
        child: Scaffold(
          body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Expanded(
                flex: 6,
                child: Container(
                  width: double.infinity,
                  alignment: Alignment.center,
                  padding: EdgeInsets.all(0),
                  decoration: BoxDecoration(color: Colors.white),
                  child: Image.asset(
                    'assets/images/start.png',
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Container(
                  alignment: Alignment.bottomCenter,
                  padding: EdgeInsets.all(5),
                  decoration: BoxDecoration(color: Colors.white),
                  child: Text(
                    '¿Preparado?',
                    style: TextStyle(
                        color: Colors.blue[300],
                        fontSize: 30,
                        fontWeight: FontWeight.w500),
                  ),
                ),
              ),
              Expanded(
                flex: 3,
                child: Container(
                  alignment: Alignment.bottomCenter,
                  padding: EdgeInsets.all(5),
                  decoration: BoxDecoration(color: Colors.white),
                  child: Column(
                    children: <Widget>[
                      Text(
                        'siguiente ejercicio',
                        style: TextStyle(
                            color: Colors.blueAccent,
                            fontSize: 20,
                            fontWeight: FontWeight.w500),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            widget.ejercicio,
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 25,
                                fontWeight: FontWeight.w500),
                          ),
                          IconButton(
                              icon: Icon(FontAwesomeIcons.infoCircle, color: Colors.blue[100],), onPressed: widget.info),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 3,
                child: Container(
                  alignment: Alignment.bottomCenter,
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(color: Colors.white),
                  child: CircularCountDownTimer(
                    duration: 20,
                    controller: _controller,
                    width: 100,
                    height: 100,
                    color: Colors.white,
                    fillColor: Colors.blue[300],
                    backgroundColor: null,
                    strokeWidth: 5.0,
                    textStyle: TextStyle(
                        fontSize: 22.0,
                        color: Colors.black,
                        fontWeight: FontWeight.bold),
                    isReverse: true,
                    isReverseAnimation: true,
                    isTimerTextShown: true,
                    onComplete: widget.press,
                  ),
                ),
              ),
              Expanded(
                flex: 3,
                child: Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(color: Colors.white),
                  child: Container(
                    height: 100.0,
                    width: 300.0,
                    padding: EdgeInsets.symmetric(
                      vertical: 25.0,
                      horizontal: 20.0,
                    ),
                    child: RaisedButton(
                      elevation: 5.0,
                      onPressed: widget.press,
                      padding: EdgeInsets.all(5.0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                      color: Colors.blueAccent,
                      child: Text(
                        '¡Empezar!',
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}
