import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ganbare/src/UI/Graph/Utils.dart';
import 'package:ganbare/src/UI/Home/Tabs/Home/HomeHeader.dart';
import 'package:ganbare/src/UI/Home/Tabs/Home/NonProgressCard.dart';
import 'package:ganbare/src/UI/Home/Tabs/Home/ProgressCard.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final CollectionReference coleccion =
      FirebaseFirestore.instance.collection('Users');
  final user = FirebaseAuth.instance.currentUser;
  Stream<QuerySnapshot> _query;

  @override
  void initState() {
    super.initState();
    _query = FirebaseFirestore.instance
        .collection('Users')
        .doc(user.uid)
        .collection('Calories')
        .where('month', isEqualTo: DateTime.now().month)
        .snapshots();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Stack(
        children: <Widget>[
          HomeHeader(size: size, coleccion: coleccion, user: user),
          StreamBuilder<QuerySnapshot>(
              stream: _query,
              builder:
                  (BuildContext context, AsyncSnapshot<QuerySnapshot> data) {
                if (data.connectionState == ConnectionState.active) {
                  if (data.data.docs.length > 0) {
                    return MonthProgress(
                      days: daysInMonth(DateTime.now().month + 1),
                      documents: data.data.docs,
                      month: DateTime.now().month + 1,
                    );
                  } else {
                    return NonMonthProgress();
                  }
                } else {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
              }),
        ],
      ),
    );
  }

  Future firebaseiniciacion() async {
    FirebaseApp initialization = await Firebase.initializeApp();
    return initialization;
  }

  Future firebaseUsuario() async {
    final usuario = await FirebaseAuth.instance.currentUser.email;
    return usuario;
  }
}
