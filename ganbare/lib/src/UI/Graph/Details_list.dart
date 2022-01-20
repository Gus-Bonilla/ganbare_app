import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class DetailParams {
  final String categoryName;
  final int month;

  DetailParams(this.categoryName, this.month);
}

class DetailsScreen extends StatefulWidget {
  final DetailParams params;

  const DetailsScreen({Key key, this.params}) : super(key: key);
  @override
  _DetailsScreenState createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  final user = FirebaseAuth.instance.currentUser;
  int currentPage = DateTime.now().month - 1;
  Stream<QuerySnapshot> _query;

  @override
  void initState() {
    super.initState();
    _query = FirebaseFirestore.instance
        .collection('Users')
        .doc(user.uid)
        .collection('Calories')
        .where('month', isEqualTo: widget.params.month + 1)
        .where('category', isEqualTo: widget.params.categoryName)
        .snapshots();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue[800],
        title: Text(widget.params.categoryName),
      ),
      body: StreamBuilder<QuerySnapshot>(
          stream: _query,
          builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> data) {
            if (data.hasData) {
              return ListView.builder(
                itemBuilder: (BuildContext context, int index) {
                  var document = data.data.docs[index];
                  return ListTile(
                    leading: Stack(
                      alignment: Alignment.center,
                      children: <Widget>[
                        Icon(
                          Icons.calendar_today,
                          size: 40,
                        ),
                        Positioned(
                          left: 0,
                          right: 0,
                          bottom: 9,
                          child: Text(
                            document.data()['day'].toString(),
                            style: TextStyle(fontWeight: FontWeight.w900),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    ),
                    title: Container(
                        decoration: BoxDecoration(
                          color: Colors.blue[200],
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: RichText(
                            text: TextSpan(
                              text: 'Kcal quemadas: ',
                              style: DefaultTextStyle.of(context).style,
                              children: <TextSpan>[
                                TextSpan(text: document.data()['value'].toString() + ' Kcal', style: TextStyle(color: Colors.white))
                              ]
                            ),
                          ),
                        )),
                  );
                },
                itemCount: data.data.docs.length,
              );
            }
            return Center(
              child: CircularProgressIndicator(),
            );
          }),
    );
  }
}
