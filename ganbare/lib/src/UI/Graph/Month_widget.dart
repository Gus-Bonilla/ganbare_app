import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ganbare/src/UI/Graph/Details_list.dart';
import 'package:ganbare/src/UI/Graph/GraphWidget.dart';

class MonthExercise extends StatefulWidget {
  final List<DocumentSnapshot> documents;
  final double total;
  final List<double> perDay;
  final Map<String, double> categories;
  final int month;

  MonthExercise({Key key, this.documents, days, @required this.month})
      : total = documents
            .map((doc) => doc.data()['value'])
            .fold(0.0, (a, b) => a + b),
        perDay = List.generate(days, (int index) {
          return documents
              .where((doc) => doc.data()['day'] == (index + 1))
              .map((doc) => doc.data()['value'])
              .fold(0.0, (a, b) => a + b);
        }),
        categories = documents.fold({}, (Map<String, double> map, document) {
          if (!map.containsKey(document.data()['category'])) {
            map[document.data()['category']] = 0.0;
          }
          map[document.data()['category']] += document.data()['value'];
          return map;
        }),
        super(key: key);
  @override
  _MonthExerciseState createState() => _MonthExerciseState();
}

class _MonthExerciseState extends State<MonthExercise> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: <Widget>[
          _calories(),
          _graph(),
          Container(
            color: Colors.blueAccent.withOpacity(0.15),
            height: 16.0,
          ),
          _list(),
        ],
      ),
    );
  }

  Widget _calories() {
    return Column(
      children: <Widget>[
        Text(
          '${widget.total.toStringAsFixed(2)}' + ' Kcal',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 35.0,
          ),
        ),
        Text(
          'Calorias totales',
          style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 15.0,
              color: Colors.blueGrey),
        ),
      ],
    );
  }

  Widget _graph() {
    return Container(
      height: 220.0,
      child: GraphWidget(data: widget.perDay),
    );
  }

  Widget _item(IconData icon, String name, double minutes, double calories) {
    return ListTile(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    DetailsScreen(params: DetailParams(name, widget.month))));
      },
      leading: SvgPicture.asset(
        'assets/images/icons/011-weight loss.svg',
        height: 30,
        width: 30,
      ),
      title: Text(name),
      subtitle: Text('$minutes% del ejercicio del mes'),
      trailing: Container(
        decoration: BoxDecoration(
          color: Colors.blue[200],
          borderRadius: BorderRadius.circular(5.0),
        ),
        child: Padding(
          padding: EdgeInsets.all(6.0),
          child: Text('$calories Kcal perdidas'),
        ),
      ),
    );
  }

  Widget _list() {
    return Expanded(
      child: ListView.separated(
        itemCount: widget.categories.keys.length,
        itemBuilder: (BuildContext context, int index) {
          var key = widget.categories.keys.elementAt(index);
          var data = widget.categories[key].toStringAsFixed(2);
          return _item(
              Icons.fitness_center_sharp, key, 100 * double.parse(data) / widget.total, double.parse(data));
        },
        separatorBuilder: (BuildContext context, int index) {
          return Container(
            color: Colors.blueAccent.withOpacity(0.15),
            height: 8.0,
          );
        },
      ),
    );
  }
}
