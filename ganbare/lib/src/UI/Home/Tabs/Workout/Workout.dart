import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ganbare/src/UI/Home/Tabs/Workout/ExerciseCategory/HomeExercise.dart';
import 'package:ganbare/src/UI/Home/Tabs/Workout/ExerciseCategory/ToneUpExercise.dart';
import 'package:ganbare/src/UI/Home/Tabs/Workout/Shared/Header.dart';
import 'package:ganbare/src/UI/Home/Tabs/Workout/ExerciseCategory/WeigthLoseExercise.dart';
import 'package:ganbare/src/UI/Home/Tabs/Workout/Shared/TitleWhitoutButtom.dart';

class Workout extends StatefulWidget {
  @override
  _WorkoutState createState() => _WorkoutState();
}

class _WorkoutState extends State<Workout> {
  final user = FirebaseAuth.instance.currentUser;
  Stream<QuerySnapshot> _query;

  @override
  void initState() {
    super.initState();
    _query = FirebaseFirestore.instance
        .collection('Users')
        .doc(user.uid)
        .collection('Calories')
        .where('day', isEqualTo: DateTime.now().day)
        .snapshots();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            StreamBuilder<QuerySnapshot>(
                stream: _query,
                builder:
                    (BuildContext context, AsyncSnapshot<QuerySnapshot> data) {
                  if (data.connectionState == ConnectionState.active) {
                    return Header(documents: data.data.docs);
                  } else {
                    return CircularProgressIndicator();
                  }
                }),
            TitleWithoutButtom(
              title: 'Tonificar',
            ),
            ToneUpExercise(),
            TitleWithoutButtom(
              title: 'Ejercitarse en casa',
            ),
            HomeExercise(),
            TitleWithoutButtom(
              title: 'Para bajar de peso',
            ),
            WeigthLoseExercise(),
          ],
        ),
      ),
    );
  }
}
