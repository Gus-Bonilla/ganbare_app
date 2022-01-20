import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({
    Key key,
    @required this.size,
    @required this.coleccion,
    @required this.user,
  }) : super(key: key);

  final double size;
  final CollectionReference coleccion;
  final User user;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 0,
      height: size * 0.40,
      left: 0,
      right: 0,
      child: ClipRRect(
        borderRadius: BorderRadius.vertical(
          bottom: Radius.circular(20),
        ),
        child: Container(
          padding: EdgeInsets.only(top: 35, left: 38, right: 16, bottom: 6),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              colors: [
                Colors.green[200],
                Colors.green[200],
                Colors.green[200],
                Colors.green[200],
                Colors.green[300],
              ],
            ),
          ),
          child: StreamBuilder(
              stream: coleccion.doc(user.uid).snapshots(),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.connectionState == ConnectionState.active) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      ListTile(
                        title: Text(
                          'Hola, ' + '${snapshot.data.data()['name']}' + '!',
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w800,
                              color: Colors.black),
                        ),
                        subtitle: Text(
                          'Bienvenido de nuevo',
                          style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w400,
                              color: Colors.black26),
                        ),
                        trailing: ClipOval(
                            child: SizedBox(
                          height: size * 0.3,
                          width: size * 0.08,
                          child: (snapshot.data.data()['pic'] != null)
                              ? Image.network(
                                  '${snapshot.data.data()['pic']}',
                                  fit: BoxFit.cover,
                                )
                              : Image.asset('assets/images/silueta.png'),
                        )),
                      ),
                      Expanded(
                        child: Row(
                          children: <Widget>[
                            Container(
                              height: size * 0.2,
                              width: size * 0.2,
                              color: Colors.green[200],
                              child: SfRadialGauge(axes: <RadialAxis>[
                                RadialAxis(
                                    minimum: (snapshot.data
                                        .data()['idealWeight']).toDouble(),
                                    maximum: (snapshot.data
                                        .data()['initialWeigth']).toDouble(),
                                    interval: 2,
                                    ranges: <GaugeRange>[
                                      GaugeRange(
                                          startValue: (snapshot.data
                                              .data()['idealWeight']).toDouble(),
                                          endValue: (snapshot.data
                                              .data()['weigth']).toDouble(),
                                          color: Colors.blue[400],
                                          startWidth: 10,
                                          endWidth: 10),
                                    ],
                                    pointers: <GaugePointer>[
                                      NeedlePointer(
                                          value: snapshot.data.data()['weigth'].toDouble(),
                                          enableAnimation: true)
                                    ],
                                    annotations: <GaugeAnnotation>[
                                      GaugeAnnotation(
                                          widget: Container(
                                              child: Text(
                                                  '${snapshot.data.data()['weigth'].toStringAsFixed(2)}' +
                                                      ' Kg',
                                                  style: TextStyle(
                                                      color: Colors.grey[700],
                                                      fontSize: 13,
                                                      fontWeight:
                                                          FontWeight.bold))),
                                          angle: 90,
                                          positionFactor: 0.8)
                                    ])
                              ]),
                            ),
                            SizedBox(
                              width: 15,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Container(
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(6)),
                                  child: Column(
                                    children: <Widget>[
                                      Container(
                                        padding: EdgeInsets.all(5),
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.vertical(
                                            top: Radius.circular(6),
                                          ),
                                        ),
                                        child: Text('Tu IMC es de ' +
                                            '${snapshot.data.data()['IMC'].toStringAsFixed(2)}'),
                                      ),
                                      Container(
                                        padding: EdgeInsets.all(5),
                                        child: imcResult(snapshot,
                                            snapshot.data.data()['IMC']),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Container(
                                  padding: EdgeInsets.all(5),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Colors.white,
                                  ),
                                  child: Text('Tu peso ideal es de: \n' +
                                      '${snapshot.data.data()['idealWeight'].round().toString()}' +
                                      ' Kg'),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  );
                } else {
                  return CircularProgressIndicator();
                }
              }),
        ),
      ),
    );
  }

  Container imcResult(AsyncSnapshot snapshot, double val) {
    Color color;
    String description;
    if (val < 22) {
      color = Colors.yellow[600];
      description = 'Tienes peso bajo';
    } else if (val > 22 && val < 25) {
      color = Colors.green[700];
      description = 'Tu peso es normal';
    } else if (val > 25 && val < 30) {
      color = Colors.yellow[600];
      description = 'Tienes sobrepeso';
    } else if (val > 30 && val < 34) {
      color = Colors.red[600];
      description = 'Tienes obesidad';
    } else {
      color = Colors.white;
    }
    return Container(
      padding: EdgeInsets.all(5),
      decoration:
          BoxDecoration(color: color, borderRadius: BorderRadius.circular(6)),
      child: Text(
        description,
        style: TextStyle(color: Colors.white),
      ),
    );
  }
}
