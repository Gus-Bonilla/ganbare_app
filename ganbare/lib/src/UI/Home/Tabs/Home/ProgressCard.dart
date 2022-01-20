import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sparkline/flutter_sparkline.dart';
import 'package:ganbare/src/UI/Graph/Exercise_graph.dart';

class MonthProgress extends StatefulWidget {
  final List<DocumentSnapshot> documents;
  final double total;
  final List<double> perDay;

  final int month;

  MonthProgress({Key key, this.documents, days, @required this.month})
      : total = documents
            .map((doc) => doc.data()['value'])
            .fold(0.0, (a, b) => a + b),
        perDay = List.generate(days, (int index) {
          return documents
              .where((doc) => doc.data()['day'] == (index + 1))
              .map((doc) => doc.data()['value'])
              .fold(0.0, (a, b) => a + b);
        }),
        super(key: key);
  @override
  _MonthProgressState createState() => _MonthProgressState();
}

class _MonthProgressState extends State<MonthProgress> {
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
          height: size.height * 0.25,
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
              Text(
                '${widget.total.toString()}' + ' Kcal'+' quemadas en total',
                style: TextStyle(
                  color: Colors.grey[400],
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 15, left: 30, right: 30),
                child: Sparkline(
                  data: widget.perDay,
                  fillMode: FillMode.below,
                  fillGradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.blue[800],
                        Colors.blue[300],
                        Colors.blue[200],
                      ]),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
