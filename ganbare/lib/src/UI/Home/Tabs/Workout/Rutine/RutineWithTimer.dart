import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class RutineWithTimer extends StatefulWidget {
  final int time;
  final String image;
  final String name;
  final Function press;
  final Function info;

  const RutineWithTimer({Key key, this.time, this.press, this.image, this.name, this.info})
      : super(key: key);
  @override
  _RutineWithTimerState createState() => _RutineWithTimerState();
}

class _RutineWithTimerState extends State<RutineWithTimer> {
  CountDownController _controller = CountDownController();
  bool _isPause = false;
  int timer;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    timer = widget.time;
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
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Expanded(
              flex: 6,
              child: Container(
                alignment: Alignment.center,
                padding: EdgeInsets.all(0),
                decoration: BoxDecoration(color: Colors.white),
                child: Image.asset(
                  widget.image,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Container(
                alignment: Alignment.bottomCenter,
                padding: EdgeInsets.all(5),
                decoration: BoxDecoration(color: Colors.white),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      widget.name,
                      style: TextStyle(
                          color: Colors.blue[300],
                          fontSize: 30,
                          fontWeight: FontWeight.w500),
                    ),
                    IconButton(icon: Icon(FontAwesomeIcons.infoCircle, color: Colors.blue[100],), onPressed: widget.info),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Container(
                alignment: Alignment.bottomCenter,
                padding: EdgeInsets.all(5),
                decoration: BoxDecoration(color: Colors.white),
                child: Text(
                  'Hacerlo durante:',
                  style: TextStyle(
                      color: Colors.blueAccent,
                      fontSize: 20,
                      fontWeight: FontWeight.w500),
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
                  duration: timer,
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
                  width: size.width * 8,
                  child: Row(
                    children: <Widget>[
                      Container(
                        alignment: Alignment.center,
                        padding: EdgeInsets.all(0),
                        decoration: BoxDecoration(color: Colors.white),
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
                              setState(() {
                                if (_isPause) {
                                  _isPause = false;
                                  _controller.resume();
                                } else {
                                  _isPause = true;
                                  _controller.pause();
                                }
                              });
                            },
                            padding: EdgeInsets.all(5.0),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30.0),
                            ),
                            color: Colors.blueAccent,
                            child: Text(
                              _isPause ? "Resumir" : "Pausar",
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
                      SizedBox(
                        height: 15,
                      ),
                      Container(
                        alignment: Alignment.center,
                        padding: EdgeInsets.all(0),
                        decoration: BoxDecoration(color: Colors.white),
                        child: Container(
                          height: 100.0,
                          width: 180.0,
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
                              'Omitir',
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
                )),
          ],
        ),
      ),
    );
  }
}
