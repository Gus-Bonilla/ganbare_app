import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class RutineRest extends StatefulWidget {
  final Function press;

  const RutineRest({Key key, this.press}) : super(key: key);
  @override
  _RutineRestState createState() => _RutineRestState();
}

class _RutineRestState extends State<RutineRest> {
  int timer = 20;
  String showTimer = '0';
  bool canceltimer = false;

  @override
  void initState() {
    starttimer();
    super.initState();
  }

  void starttimer() async {
    const onesecond = Duration(seconds: 1);
    Timer.periodic(onesecond, (Timer t) {
      setState(() {
        if (timer < 1) {
          t.cancel();
          nextExercise();
        } else if (canceltimer == true) {
          t.cancel();
        } else {
          timer = timer - 1;
        }
        showTimer = timer.toString();
      });
    });
  }

  void nextExercise() {
    setState(() {
      if (timer < 1) {
        if (widget.press != null) widget.press();
      } else {}
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
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
                ));
      },
      child: Scaffold(
        body: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
            colors: [
              Colors.blue[300],
              Colors.blue[400],
              Colors.blue,
              Colors.blue[600]
            ],
            begin: FractionalOffset(0.5, 1),
          )),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                child: Text(
                  'Toma un descanso',
                  style: TextStyle(color: Colors.white, fontSize: 30),
                ),
              ),
              SizedBox(
                height: size.height * 0.04,
              ),
              Container(
                alignment: Alignment.bottomCenter,
                padding: EdgeInsets.all(10),
                child: Text(
                  timer.toString(),
                  style: TextStyle(color: Colors.white, fontSize: 50),
                ),
              ),
              Container(
                alignment: Alignment.bottomCenter,
                padding: EdgeInsets.all(10),
                child: Text(
                  'segundos',
                  style: TextStyle(color: Colors.white, fontSize: 30),
                ),
              ),
              SizedBox(
                height: size.height * 0.08,
              ),
              Container(
                width: size.width * 8,
                child: Row(
                  children: <Widget>[
                    Container(
                      alignment: Alignment.center,
                      padding: EdgeInsets.all(0),
                      child: Container(
                        height: 100.0,
                        width: 180.0,
                        padding: EdgeInsets.symmetric(
                          vertical: 25.0,
                          horizontal: 20.0,
                        ),
                        child: RaisedButton(
                          elevation: 5.0,
                          onPressed: () {
                            timer = timer + 10;
                          },
                          padding: EdgeInsets.all(5.0),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                          color: Colors.white,
                          child: Text(
                            "+ 0:10",
                            style: TextStyle(
                                color: Colors.blue,
                                letterSpacing: 1.5,
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold,
                                fontStyle: FontStyle.italic),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Container(
                      alignment: Alignment.center,
                      padding: EdgeInsets.all(0),
                      child: Container(
                        height: 100.0,
                        width: 180.0,
                        padding: EdgeInsets.symmetric(
                          vertical: 25.0,
                          horizontal: 20.0,
                        ),
                        child: RaisedButton(
                          elevation: 5.0,
                          onPressed: () {
                            timer = 0;
                          },
                          padding: EdgeInsets.all(5.0),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                          color: Colors.white,
                          child: Text(
                            'Omitir',
                            style: TextStyle(
                                color: Colors.blue,
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
              )
            ],
          ),
        ),
      ),
    );
  }
}
