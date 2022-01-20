import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ganbare/src/UI/Graph/Month_widget.dart';
import 'package:ganbare/src/UI/Graph/Utils.dart';
import 'package:ganbare/src/UI/Home/Home_screen.dart';

class ExerciseGraph extends StatefulWidget {
  @override
  _ExerciseGraphState createState() => _ExerciseGraphState();
}

class _ExerciseGraphState extends State<ExerciseGraph> {
  final user = FirebaseAuth.instance.currentUser;
  PageController _controller;
  int currentPage = DateTime.now().month - 1;
  Stream<QuerySnapshot> _query;

  @override
  void initState() {
    super.initState();
    _query = FirebaseFirestore.instance
        .collection('Users')
        .doc(user.uid)
        .collection('Calories')
        .where('month', isEqualTo: currentPage + 1)
        .snapshots();
    _controller = PageController(
      initialPage: currentPage,
      viewportFraction: 0.4,
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        return Navigator.push(
            context, MaterialPageRoute(builder: (context) => HomeScreen()));
      },
      child: Scaffold(
        body: _body(),
      ),
    );
  }

  Widget _body() {
    return SafeArea(
      child: Column(
        children: <Widget>[
          _selector(),
          StreamBuilder<QuerySnapshot>(
              stream: _query,
              builder:
                  (BuildContext context, AsyncSnapshot<QuerySnapshot> data) {
                if (data.connectionState == ConnectionState.active) {
                  if (data.data.docs.length > 0) {
                    return MonthExercise(
                      days: daysInMonth(currentPage + 1),
                      documents: data.data.docs,
                      month: currentPage,
                    );
                  } else {
                    return Expanded(
                      child: Container(
                        color: Colors.white,
                        child: Column(
                          children: <Widget>[
                            Image.asset('assets/images/empty.png'),
                            SizedBox(
                              height: 60,
                            ),
                            Text(
                              'Aún no hay información aquí ¡Ejercitate!',
                              style: TextStyle(
                                  color: Colors.grey[600],
                                  fontSize: 15,
                                  fontWeight: FontWeight.w800),
                            ),
                          ],
                        ),
                      ),
                    );
                  }
                }
                return Expanded(
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              }),
        ],
      ),
    );
  }

//te amo<3
  Widget _pageItem(String name, int position) {
    var _alignment;
    final selected = TextStyle(
      fontSize: 20.0,
      fontWeight: FontWeight.bold,
      color: Colors.blueGrey,
    );
    final unselected = TextStyle(
        fontSize: 20.0,
        fontWeight: FontWeight.normal,
        color: Colors.blueGrey.withOpacity(0.4));

    if (position == currentPage) {
      _alignment = Alignment.center;
    } else if (position > currentPage) {
      _alignment = Alignment.centerRight;
    } else {
      _alignment = Alignment.centerLeft;
    }
    return Align(
      alignment: _alignment,
      child: Text(
        name,
        style: position == currentPage ? selected : unselected,
      ),
    );
  }

  Widget _selector() {
    return SizedBox.fromSize(
      size: Size.fromHeight(70),
      child: PageView(
        onPageChanged: (newpage) {
          setState(() {
            currentPage = newpage;
            _query = FirebaseFirestore.instance
                .collection('Users')
                .doc(user.uid)
                .collection('Calories')
                .where('month', isEqualTo: currentPage + 1)
                .snapshots();
          });
        },
        controller: _controller,
        children: <Widget>[
          _pageItem('Enero', 0),
          _pageItem('Febrero', 1),
          _pageItem('Marzo', 2),
          _pageItem('Abril', 3),
          _pageItem('Mayo', 4),
          _pageItem('Junio', 5),
          _pageItem('Julio', 6),
          _pageItem('Agosto', 7),
          _pageItem('Septimebre', 8),
          _pageItem('Octubre', 9),
          _pageItem('Noviembre', 10),
          _pageItem('Diciembre', 11),
        ],
      ),
    );
  }
}
