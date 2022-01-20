import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:intl/intl.dart';

class Header extends StatefulWidget {
  final List<DocumentSnapshot> documents;
  final double totalcal;
  final int totalexc;

  Header({Key key, this.documents})
      : totalcal = documents
            .map((doc) => doc.data()['value'])
            .fold(0.0, (a, b) => a + b),
        totalexc = documents
            .map((doc) => doc.data()['exercise'])
            .fold(0, (a, b) => a + b),
        super(key: key);
  @override
  _HeaderState createState() => _HeaderState();
}

class _HeaderState extends State<Header> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    DateTime now = DateTime.now();
    String formattedDate = DateFormat('EEE / d / MMM').format(now);
    final CollectionReference coleccion =
        FirebaseFirestore.instance.collection('Users');
    final user = FirebaseAuth.instance.currentUser;
    return Container(
      margin: EdgeInsets.only(bottom: 20),
      height: size.height * 0.30,
      child: StreamBuilder(
          stream: coleccion.doc(user.uid).snapshots(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.connectionState == ConnectionState.active) {
              return Stack(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.only(
                      top: 80,
                      left: 20,
                      right: 20,
                      bottom: 0,
                    ),
                    height: size.height * 0.8,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.bottomLeft,
                        colors: [
                          Colors.red[400],
                          Colors.red[400],
                          Colors.red[500],
                          Colors.red[500],
                          Colors.red[500],
                        ],
                      ),
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(20),
                        bottomRight: Radius.circular(20),
                      ),
                    ),
                    child: Row(
                      children: <Widget>[
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                SvgPicture.asset(
                                  'assets/images/icons/calendar.svg',
                                  height: 40,
                                  width: 40,
                                ),
                                SizedBox(
                                  width: size.width * 0.02,
                                ),
                                Text(
                                  formattedDate + '\nEjercicio de hoy',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 15),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: size.height * 0.01,
                            ),
                            Row(
                              children: <Widget>[
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    Text(
                                      'Ejercicios \n realizados',
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 12),
                                    ),
                                    Text(
                                      '${widget.totalexc.toString()}',
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 20),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  width: size.width * 0.05,
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    Text(
                                      '${widget.totalcal.toString()}' + ' Kcal',
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 20),
                                    ),
                                    Text(
                                      'Perdidas',
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 12),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                        Spacer(),
                        ClipOval(
                          child: SizedBox(
                            height: size.height * 0.12,
                            width: size.height * 0.12,
                            child: (snapshot.data.data()['pic'] != null)
                                ? Image.network(
                                    '${snapshot.data.data()['pic']}',
                                    fit: BoxFit.cover,
                                  )
                                : Image.asset('assets/images/silueta.png'),
                          ),
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
    );
  }
}
