import 'package:flutter/material.dart';
import 'package:ganbare/src/UI/Home/Tabs/Workout/ExerciseCards/ExerciseCard.dart';
import 'package:ganbare/src/UI/Home/Tabs/Workout/Rutine/RutineCompleted.dart';
import 'package:ganbare/src/UI/Home/Tabs/Workout/Rutine/RutineRest.dart';
import 'package:ganbare/src/UI/Home/Tabs/Workout/Rutine/RutineWithRepetitions.dart';
import 'package:ganbare/src/UI/Home/Tabs/Workout/Shared/Exercise_screen.dart';
import 'package:ganbare/src/UI/Home/Tabs/Workout/Rutine/RutineStart.dart';

class ToneUpExercise extends StatelessWidget {
  const ToneUpExercise({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      physics: BouncingScrollPhysics(),
      child: Row(
        children: <Widget>[
          ExerciseCard(
            title: 'Upperbody',
            tag: 'Upperbody',
            image: 'assets/images/upperbody.jpg',
            press: () {
              return Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ExerciseScreen(
                    tag: 'Upperbody',
                    image: 'assets/images/upperbody.jpg',
                    minutes: '15',
                    repetitions: '8',
                    calories: '80.4',
                    description: 'Hola jejeje',
                    list: 'brazos',
                    press: () {
                      return Navigator.push(
                        context,
                        new MaterialPageRoute(
                          builder: (context) => RutineStart(
                            ejercicio: 'Biceps curl',
                            info: () {},
                            press: () {
                              return Navigator.push(
                                context,
                                new MaterialPageRoute(
                                  builder: (context) => RutineWithRepetitions(
                                    image:
                                        'assets/images/exercises/bicepscurl.gif',
                                    name: 'Biceps curl',
                                    repetitions: '12',
                                    press1: () {
                                      return Navigator.push(
                                        context,
                                        new MaterialPageRoute(
                                          builder: (context) => RutineRest(
                                            press: () {
                                              return Navigator.push(
                                                context,
                                                new MaterialPageRoute(
                                                  builder: (context) =>
                                                      RutineWithRepetitions(
                                                    image:
                                                        'assets/images/exercises/bicepscurl.gif',
                                                    name: 'Biceps curl',
                                                    repetitions: '10',
                                                    press1: () {
                                                      return Navigator.push(
                                                        context,
                                                        new MaterialPageRoute(
                                                          builder: (context) =>
                                                              RutineRest(
                                                            press: () {
                                                              return Navigator
                                                                  .push(
                                                                context,
                                                                new MaterialPageRoute(
                                                                  builder:
                                                                      (context) =>
                                                                          RutineWithRepetitions(
                                                                    image:
                                                                        'assets/images/exercises/bicepscurl.gif',
                                                                    name:
                                                                        'Biceps curl',
                                                                    repetitions:
                                                                        '8',
                                                                    press1: () {
                                                                      return Navigator
                                                                          .push(
                                                                        context,
                                                                        new MaterialPageRoute(
                                                                          builder: (context) =>
                                                                              RutineRest(
                                                                            press:
                                                                                () {
                                                                              return Navigator.push(
                                                                                context,
                                                                                new MaterialPageRoute(
                                                                                  builder: (context) => RutineWithRepetitions(
                                                                                    image: 'assets/images/exercises/tricepsext.gif',
                                                                                    name: 'Triceps ext',
                                                                                    repetitions: '12',
                                                                                    press1: () {
                                                                                      return Navigator.push(
                                                                                        context,
                                                                                        new MaterialPageRoute(
                                                                                          builder: (context) => RutineRest(
                                                                                            press: () {
                                                                                              return Navigator.push(
                                                                                                context,
                                                                                                new MaterialPageRoute(
                                                                                                  builder: (context) => RutineWithRepetitions(
                                                                                                    image: 'assets/images/exercises/tricepsext.gif',
                                                                                                    name: 'Triceps ext',
                                                                                                    repetitions: '10',
                                                                                                    press1: () {
                                                                                                      return Navigator.push(
                                                                                                        context,
                                                                                                        new MaterialPageRoute(
                                                                                                          builder: (context) => RutineRest(
                                                                                                            press: () {
                                                                                                              return Navigator.push(
                                                                                                                context,
                                                                                                                new MaterialPageRoute(
                                                                                                                  builder: (context) => RutineWithRepetitions(
                                                                                                                    image: 'assets/images/exercises/tricepsext.gif',
                                                                                                                    name: 'Triceps ext',
                                                                                                                    repetitions: '8',
                                                                                                                    press1: () {
                                                                                                                      return Navigator.push(
                                                                                                                        context,
                                                                                                                        new MaterialPageRoute(
                                                                                                                          builder: (context) => RutineRest(
                                                                                                                            press: () {
                                                                                                                              return Navigator.push(
                                                                                                                                context,
                                                                                                                                new MaterialPageRoute(
                                                                                                                                  builder: (context) => RutineWithRepetitions(
                                                                                                                                    image: 'assets/images/exercises/pressacostado.gif',
                                                                                                                                    name: 'Press acostado',
                                                                                                                                    repetitions: '12',
                                                                                                                                    press1: () {
                                                                                                                                      return Navigator.push(
                                                                                                                                        context,
                                                                                                                                        new MaterialPageRoute(
                                                                                                                                          builder: (context) => RutineRest(
                                                                                                                                            press: () {
                                                                                                                                              return Navigator.push(
                                                                                                                                                context,
                                                                                                                                                new MaterialPageRoute(
                                                                                                                                                  builder: (context) => RutineWithRepetitions(
                                                                                                                                                    image: 'assets/images/exercises/pressacostado.gif',
                                                                                                                                                    name: 'Press acostado',
                                                                                                                                                    repetitions: '10',
                                                                                                                                                    press1: () {
                                                                                                                                                      return Navigator.push(
                                                                                                                                                        context,
                                                                                                                                                        new MaterialPageRoute(
                                                                                                                                                          builder: (context) => RutineRest(
                                                                                                                                                            press: () {
                                                                                                                                                              return Navigator.push(
                                                                                                                                                                context,
                                                                                                                                                                new MaterialPageRoute(
                                                                                                                                                                  builder: (context) => RutineWithRepetitions(
                                                                                                                                                                    image: 'assets/images/exercises/pressacostado.gif',
                                                                                                                                                                    name: 'Press acostado',
                                                                                                                                                                    repetitions: '8',
                                                                                                                                                                    press1: () {
                                                                                                                                                                      return Navigator.push(
                                                                                                                                                                        context,
                                                                                                                                                                        new MaterialPageRoute(
                                                                                                                                                                          builder: (context) => RutineRest(
                                                                                                                                                                            press: () {
                                                                                                                                                                              return Navigator.push(
                                                                                                                                                                                context,
                                                                                                                                                                                new MaterialPageRoute(
                                                                                                                                                                                  builder: (context) => RutineWithRepetitions(
                                                                                                                                                                                    image: 'assets/images/exercises/pressacostado.gif',
                                                                                                                                                                                    name: 'Ski row',
                                                                                                                                                                                    repetitions: '10',
                                                                                                                                                                                    press1: () {
                                                                                                                                                                                      return Navigator.push(
                                                                                                                                                                                        context,
                                                                                                                                                                                        new MaterialPageRoute(
                                                                                                                                                                                          builder: (context) => RutineRest(
                                                                                                                                                                                            press: () {
                                                                                                                                                                                              return Navigator.push(
                                                                                                                                                                                                context,
                                                                                                                                                                                                new MaterialPageRoute(
                                                                                                                                                                                                  builder: (context) => RutineWithRepetitions(
                                                                                                                                                                                                    image: 'assets/images/exercises/pressacostado.gif',
                                                                                                                                                                                                    name: 'Ski row',
                                                                                                                                                                                                    repetitions: '10',
                                                                                                                                                                                                    press1: () {
                                                                                                                                                                                                      return Navigator.push(
                                                                                                                                                                                                        context,
                                                                                                                                                                                                        new MaterialPageRoute(
                                                                                                                                                                                                          builder: (context) => RutineRest(
                                                                                                                                                                                                            press: () {
                                                                                                                                                                                                              return Navigator.push(
                                                                                                                                                                                                                context,
                                                                                                                                                                                                                new MaterialPageRoute(
                                                                                                                                                                                                                  builder: (context) => RutineWithRepetitions(
                                                                                                                                                                                                                    image: 'assets/images/exercises/pressacostado.gif',
                                                                                                                                                                                                                    name: 'Ski row',
                                                                                                                                                                                                                    repetitions: '10',
                                                                                                                                                                                                                    press1: () {
                                                                                                                                                                                                                      return Navigator.push(
                                                                                                                                                                                                                        context,
                                                                                                                                                                                                                        new MaterialPageRoute(
                                                                                                                                                                                                                          builder: (context) => RutineRest(
                                                                                                                                                                                                                            press: () {
                                                                                                                                                                                                                              return Navigator.push(
                                                                                                                                                                                                                                context,
                                                                                                                                                                                                                                new MaterialPageRoute(
                                                                                                                                                                                                                                  builder: (context) => RutineWithRepetitions(
                                                                                                                                                                                                                                    image: 'assets/images/exercises/backrow.gif',
                                                                                                                                                                                                                                    name: 'Back row',
                                                                                                                                                                                                                                    repetitions: '12',
                                                                                                                                                                                                                                    press1: () {
                                                                                                                                                                                                                                      return Navigator.push(
                                                                                                                                                                                                                                        context,
                                                                                                                                                                                                                                        new MaterialPageRoute(
                                                                                                                                                                                                                                          builder: (context) => RutineRest(
                                                                                                                                                                                                                                            press: () {
                                                                                                                                                                                                                                              return Navigator.push(
                                                                                                                                                                                                                                                context,
                                                                                                                                                                                                                                                new MaterialPageRoute(
                                                                                                                                                                                                                                                  builder: (context) => RutineWithRepetitions(
                                                                                                                                                                                                                                                    image: 'assets/images/exercises/backrow.gif',
                                                                                                                                                                                                                                                    name: 'Back row',
                                                                                                                                                                                                                                                    repetitions: '10',
                                                                                                                                                                                                                                                    press1: () {
                                                                                                                                                                                                                                                      return Navigator.push(
                                                                                                                                                                                                                                                        context,
                                                                                                                                                                                                                                                        new MaterialPageRoute(
                                                                                                                                                                                                                                                          builder: (context) => RutineRest(
                                                                                                                                                                                                                                                            press: () {
                                                                                                                                                                                                                                                              return Navigator.push(
                                                                                                                                                                                                                                                                context,
                                                                                                                                                                                                                                                                new MaterialPageRoute(
                                                                                                                                                                                                                                                                  builder: (context) => RutineWithRepetitions(
                                                                                                                                                                                                                                                                    image: 'assets/images/exercises/backrow.gif',
                                                                                                                                                                                                                                                                    name: 'Backrow',
                                                                                                                                                                                                                                                                    repetitions: '8',
                                                                                                                                                                                                                                                                    press1: () {
                                                                                                                                                                                                                                                                      return Navigator.push(
                                                                                                                                                                                                                                                                        context,
                                                                                                                                                                                                                                                                        new MaterialPageRoute(
                                                                                                                                                                                                                                                                          builder: (context) => RutineRest(
                                                                                                                                                                                                                                                                            press: () {
                                                                                                                                                                                                                                                                              return Navigator.push(
                                                                                                                                                                                                                                                                                context,
                                                                                                                                                                                                                                                                                new MaterialPageRoute(
                                                                                                                                                                                                                                                                                  builder: (context) => RutineWithRepetitions(
                                                                                                                                                                                                                                                                                    image: 'assets/images/exercises/pressmilitar.gif',
                                                                                                                                                                                                                                                                                    name: 'Press militar',
                                                                                                                                                                                                                                                                                    repetitions: '12',
                                                                                                                                                                                                                                                                                    press1: () {
                                                                                                                                                                                                                                                                                      return Navigator.push(
                                                                                                                                                                                                                                                                                        context,
                                                                                                                                                                                                                                                                                        new MaterialPageRoute(
                                                                                                                                                                                                                                                                                          builder: (context) => RutineRest(
                                                                                                                                                                                                                                                                                            press: () {
                                                                                                                                                                                                                                                                                              return Navigator.push(
                                                                                                                                                                                                                                                                                                context,
                                                                                                                                                                                                                                                                                                new MaterialPageRoute(
                                                                                                                                                                                                                                                                                                  builder: (context) => RutineWithRepetitions(
                                                                                                                                                                                                                                                                                                    image: 'assets/images/exercises/pressmilitar.gif',
                                                                                                                                                                                                                                                                                                    name: 'Press militar',
                                                                                                                                                                                                                                                                                                    repetitions: '10',
                                                                                                                                                                                                                                                                                                    press1: () {
                                                                                                                                                                                                                                                                                                      return Navigator.push(
                                                                                                                                                                                                                                                                                                        context,
                                                                                                                                                                                                                                                                                                        new MaterialPageRoute(
                                                                                                                                                                                                                                                                                                          builder: (context) => RutineRest(
                                                                                                                                                                                                                                                                                                            press: () {
                                                                                                                                                                                                                                                                                                              return Navigator.push(
                                                                                                                                                                                                                                                                                                                context,
                                                                                                                                                                                                                                                                                                                new MaterialPageRoute(
                                                                                                                                                                                                                                                                                                                  builder: (context) => RutineWithRepetitions(
                                                                                                                                                                                                                                                                                                                    image: 'assets/images/exercises/pressmilitar.gif',
                                                                                                                                                                                                                                                                                                                    name: 'Press militar',
                                                                                                                                                                                                                                                                                                                    repetitions: '8',
                                                                                                                                                                                                                                                                                                                    press1: () {
                                                                                                                                                                                                                                                                                                                      return Navigator.push(
                                                                                                                                                                                                                                                                                                                        context,
                                                                                                                                                                                                                                                                                                                        new MaterialPageRoute(
                                                                                                                                                                                                                                                                                                                          builder: (context) => RutineRest(
                                                                                                                                                                                                                                                                                                                            press: () {
                                                                                                                                                                                                                                                                                                                              return Navigator.push(
                                                                                                                                                                                                                                                                                                                                context,
                                                                                                                                                                                                                                                                                                                                new MaterialPageRoute(
                                                                                                                                                                                                                                                                                                                                  builder: (context) => RutineWithRepetitions(
                                                                                                                                                                                                                                                                                                                                    image: 'assets/images/exercises/frontfly.gif',
                                                                                                                                                                                                                                                                                                                                    name: 'Front fly',
                                                                                                                                                                                                                                                                                                                                    repetitions: '10',
                                                                                                                                                                                                                                                                                                                                    press1: () {
                                                                                                                                                                                                                                                                                                                                      return Navigator.push(
                                                                                                                                                                                                                                                                                                                                        context,
                                                                                                                                                                                                                                                                                                                                        new MaterialPageRoute(
                                                                                                                                                                                                                                                                                                                                          builder: (context) => RutineRest(
                                                                                                                                                                                                                                                                                                                                            press: () {
                                                                                                                                                                                                                                                                                                                                              return Navigator.push(
                                                                                                                                                                                                                                                                                                                                                context,
                                                                                                                                                                                                                                                                                                                                                new MaterialPageRoute(
                                                                                                                                                                                                                                                                                                                                                  builder: (context) => RutineWithRepetitions(
                                                                                                                                                                                                                                                                                                                                                    image: 'assets/images/exercises/frontfly.gif',
                                                                                                                                                                                                                                                                                                                                                    name: 'Front fly',
                                                                                                                                                                                                                                                                                                                                                    repetitions: '10',
                                                                                                                                                                                                                                                                                                                                                    press1: () {
                                                                                                                                                                                                                                                                                                                                                      return Navigator.push(
                                                                                                                                                                                                                                                                                                                                                        context,
                                                                                                                                                                                                                                                                                                                                                        new MaterialPageRoute(
                                                                                                                                                                                                                                                                                                                                                          builder: (context) => RutineRest(
                                                                                                                                                                                                                                                                                                                                                            press: () {
                                                                                                                                                                                                                                                                                                                                                              return Navigator.push(
                                                                                                                                                                                                                                                                                                                                                                context,
                                                                                                                                                                                                                                                                                                                                                                new MaterialPageRoute(
                                                                                                                                                                                                                                                                                                                                                                  builder: (context) => RutineWithRepetitions(
                                                                                                                                                                                                                                                                                                                                                                    image: 'assets/images/exercises/frontfly.gif',
                                                                                                                                                                                                                                                                                                                                                                    name: 'Front fly',
                                                                                                                                                                                                                                                                                                                                                                    repetitions: '10',
                                                                                                                                                                                                                                                                                                                                                                    press1: () {
                                                                                                                                                                                                                                                                                                                                                                      return Navigator.push(
                                                                                                                                                                                                                                                                                                                                                                        context,
                                                                                                                                                                                                                                                                                                                                                                        new MaterialPageRoute(
                                                                                                                                                                                                                                                                                                                                                                          builder: (context) => RutineRest(
                                                                                                                                                                                                                                                                                                                                                                            press: () {
                                                                                                                                                                                                                                                                                                                                                                              return Navigator.push(
                                                                                                                                                                                                                                                                                                                                                                                context,
                                                                                                                                                                                                                                                                                                                                                                                new MaterialPageRoute(
                                                                                                                                                                                                                                                                                                                                                                                  builder: (context) => RutineWithRepetitions(
                                                                                                                                                                                                                                                                                                                                                                                    image: 'assets/images/exercises/dips.gif',
                                                                                                                                                                                                                                                                                                                                                                                    name: 'Dips',
                                                                                                                                                                                                                                                                                                                                                                                    repetitions: '12',
                                                                                                                                                                                                                                                                                                                                                                                    press1: () {
                                                                                                                                                                                                                                                                                                                                                                                      return Navigator.push(
                                                                                                                                                                                                                                                                                                                                                                                        context,
                                                                                                                                                                                                                                                                                                                                                                                        new MaterialPageRoute(
                                                                                                                                                                                                                                                                                                                                                                                          builder: (context) => RutineRest(
                                                                                                                                                                                                                                                                                                                                                                                            press: () {
                                                                                                                                                                                                                                                                                                                                                                                              return Navigator.push(
                                                                                                                                                                                                                                                                                                                                                                                                context,
                                                                                                                                                                                                                                                                                                                                                                                                new MaterialPageRoute(
                                                                                                                                                                                                                                                                                                                                                                                                  builder: (context) => RutineWithRepetitions(
                                                                                                                                                                                                                                                                                                                                                                                                    image: 'assets/images/exercises/dips.gif',
                                                                                                                                                                                                                                                                                                                                                                                                    name: 'Dips',
                                                                                                                                                                                                                                                                                                                                                                                                    repetitions: '10',
                                                                                                                                                                                                                                                                                                                                                                                                    press1: () {
                                                                                                                                                                                                                                                                                                                                                                                                      return Navigator.push(
                                                                                                                                                                                                                                                                                                                                                                                                        context,
                                                                                                                                                                                                                                                                                                                                                                                                        new MaterialPageRoute(
                                                                                                                                                                                                                                                                                                                                                                                                          builder: (context) => RutineRest(
                                                                                                                                                                                                                                                                                                                                                                                                            press: () {
                                                                                                                                                                                                                                                                                                                                                                                                              return Navigator.push(
                                                                                                                                                                                                                                                                                                                                                                                                                context,
                                                                                                                                                                                                                                                                                                                                                                                                                new MaterialPageRoute(
                                                                                                                                                                                                                                                                                                                                                                                                                  builder: (context) => RutineWithRepetitions(
                                                                                                                                                                                                                                                                                                                                                                                                                    image: 'assets/images/exercises/dips.gif',
                                                                                                                                                                                                                                                                                                                                                                                                                    name: 'Dips',
                                                                                                                                                                                                                                                                                                                                                                                                                    repetitions: '8',
                                                                                                                                                                                                                                                                                                                                                                                                                    press1: () {
                                                                                                                                                                                                                                                                                                                                                                                                                      return Navigator.push(
                                                                                                                                                                                                                                                                                                                                                                                                                        context,
                                                                                                                                                                                                                                                                                                                                                                                                                        new MaterialPageRoute(
                                                                                                                                                                                                                                                                                                                                                                                                                          builder: (context) => RutineCompleted(
                                                                                                                                                                                                                                                                                                                                                                                                                            categoryname: 'Upper body',
                                                                                                                                                                                                                                                                                                                                                                                                                            calories: 80.4,
                                                                                                                                                                                                                                                                                                                                                                                                                            ejercicios: 8,
                                                                                                                                                                                                                                                                                                                                                                                                                            duracion: '15',
                                                                                                                                                                                                                                                                                                                                                                                                                          ),
                                                                                                                                                                                                                                                                                                                                                                                                                        ),
                                                                                                                                                                                                                                                                                                                                                                                                                      );
                                                                                                                                                                                                                                                                                                                                                                                                                    },
                                                                                                                                                                                                                                                                                                                                                                                                                  ),
                                                                                                                                                                                                                                                                                                                                                                                                                ),
                                                                                                                                                                                                                                                                                                                                                                                                              );
                                                                                                                                                                                                                                                                                                                                                                                                            },
                                                                                                                                                                                                                                                                                                                                                                                                          ),
                                                                                                                                                                                                                                                                                                                                                                                                        ),
                                                                                                                                                                                                                                                                                                                                                                                                      );
                                                                                                                                                                                                                                                                                                                                                                                                    },
                                                                                                                                                                                                                                                                                                                                                                                                  ),
                                                                                                                                                                                                                                                                                                                                                                                                ),
                                                                                                                                                                                                                                                                                                                                                                                              );
                                                                                                                                                                                                                                                                                                                                                                                            },
                                                                                                                                                                                                                                                                                                                                                                                          ),
                                                                                                                                                                                                                                                                                                                                                                                        ),
                                                                                                                                                                                                                                                                                                                                                                                      );
                                                                                                                                                                                                                                                                                                                                                                                    },
                                                                                                                                                                                                                                                                                                                                                                                  ),
                                                                                                                                                                                                                                                                                                                                                                                ),
                                                                                                                                                                                                                                                                                                                                                                              );
                                                                                                                                                                                                                                                                                                                                                                            },
                                                                                                                                                                                                                                                                                                                                                                          ),
                                                                                                                                                                                                                                                                                                                                                                        ),
                                                                                                                                                                                                                                                                                                                                                                      );
                                                                                                                                                                                                                                                                                                                                                                    },
                                                                                                                                                                                                                                                                                                                                                                  ),
                                                                                                                                                                                                                                                                                                                                                                ),
                                                                                                                                                                                                                                                                                                                                                              );
                                                                                                                                                                                                                                                                                                                                                            },
                                                                                                                                                                                                                                                                                                                                                          ),
                                                                                                                                                                                                                                                                                                                                                        ),
                                                                                                                                                                                                                                                                                                                                                      );
                                                                                                                                                                                                                                                                                                                                                    },
                                                                                                                                                                                                                                                                                                                                                  ),
                                                                                                                                                                                                                                                                                                                                                ),
                                                                                                                                                                                                                                                                                                                                              );
                                                                                                                                                                                                                                                                                                                                            },
                                                                                                                                                                                                                                                                                                                                          ),
                                                                                                                                                                                                                                                                                                                                        ),
                                                                                                                                                                                                                                                                                                                                      );
                                                                                                                                                                                                                                                                                                                                    },
                                                                                                                                                                                                                                                                                                                                  ),
                                                                                                                                                                                                                                                                                                                                ),
                                                                                                                                                                                                                                                                                                                              );
                                                                                                                                                                                                                                                                                                                            },
                                                                                                                                                                                                                                                                                                                          ),
                                                                                                                                                                                                                                                                                                                        ),
                                                                                                                                                                                                                                                                                                                      );
                                                                                                                                                                                                                                                                                                                    },
                                                                                                                                                                                                                                                                                                                  ),
                                                                                                                                                                                                                                                                                                                ),
                                                                                                                                                                                                                                                                                                              );
                                                                                                                                                                                                                                                                                                            },
                                                                                                                                                                                                                                                                                                          ),
                                                                                                                                                                                                                                                                                                        ),
                                                                                                                                                                                                                                                                                                      );
                                                                                                                                                                                                                                                                                                    },
                                                                                                                                                                                                                                                                                                  ),
                                                                                                                                                                                                                                                                                                ),
                                                                                                                                                                                                                                                                                              );
                                                                                                                                                                                                                                                                                            },
                                                                                                                                                                                                                                                                                          ),
                                                                                                                                                                                                                                                                                        ),
                                                                                                                                                                                                                                                                                      );
                                                                                                                                                                                                                                                                                    },
                                                                                                                                                                                                                                                                                  ),
                                                                                                                                                                                                                                                                                ),
                                                                                                                                                                                                                                                                              );
                                                                                                                                                                                                                                                                            },
                                                                                                                                                                                                                                                                          ),
                                                                                                                                                                                                                                                                        ),
                                                                                                                                                                                                                                                                      );
                                                                                                                                                                                                                                                                    },
                                                                                                                                                                                                                                                                  ),
                                                                                                                                                                                                                                                                ),
                                                                                                                                                                                                                                                              );
                                                                                                                                                                                                                                                            },
                                                                                                                                                                                                                                                          ),
                                                                                                                                                                                                                                                        ),
                                                                                                                                                                                                                                                      );
                                                                                                                                                                                                                                                    },
                                                                                                                                                                                                                                                  ),
                                                                                                                                                                                                                                                ),
                                                                                                                                                                                                                                              );
                                                                                                                                                                                                                                            },
                                                                                                                                                                                                                                          ),
                                                                                                                                                                                                                                        ),
                                                                                                                                                                                                                                      );
                                                                                                                                                                                                                                    },
                                                                                                                                                                                                                                  ),
                                                                                                                                                                                                                                ),
                                                                                                                                                                                                                              );
                                                                                                                                                                                                                            },
                                                                                                                                                                                                                          ),
                                                                                                                                                                                                                        ),
                                                                                                                                                                                                                      );
                                                                                                                                                                                                                    },
                                                                                                                                                                                                                  ),
                                                                                                                                                                                                                ),
                                                                                                                                                                                                              );
                                                                                                                                                                                                            },
                                                                                                                                                                                                          ),
                                                                                                                                                                                                        ),
                                                                                                                                                                                                      );
                                                                                                                                                                                                    },
                                                                                                                                                                                                  ),
                                                                                                                                                                                                ),
                                                                                                                                                                                              );
                                                                                                                                                                                            },
                                                                                                                                                                                          ),
                                                                                                                                                                                        ),
                                                                                                                                                                                      );
                                                                                                                                                                                    },
                                                                                                                                                                                  ),
                                                                                                                                                                                ),
                                                                                                                                                                              );
                                                                                                                                                                            },
                                                                                                                                                                          ),
                                                                                                                                                                        ),
                                                                                                                                                                      );
                                                                                                                                                                    },
                                                                                                                                                                  ),
                                                                                                                                                                ),
                                                                                                                                                              );
                                                                                                                                                            },
                                                                                                                                                          ),
                                                                                                                                                        ),
                                                                                                                                                      );
                                                                                                                                                    },
                                                                                                                                                  ),
                                                                                                                                                ),
                                                                                                                                              );
                                                                                                                                            },
                                                                                                                                          ),
                                                                                                                                        ),
                                                                                                                                      );
                                                                                                                                    },
                                                                                                                                  ),
                                                                                                                                ),
                                                                                                                              );
                                                                                                                            },
                                                                                                                          ),
                                                                                                                        ),
                                                                                                                      );
                                                                                                                    },
                                                                                                                  ),
                                                                                                                ),
                                                                                                              );
                                                                                                            },
                                                                                                          ),
                                                                                                        ),
                                                                                                      );
                                                                                                    },
                                                                                                  ),
                                                                                                ),
                                                                                              );
                                                                                            },
                                                                                          ),
                                                                                        ),
                                                                                      );
                                                                                    },
                                                                                  ),
                                                                                ),
                                                                              );
                                                                            },
                                                                          ),
                                                                        ),
                                                                      );
                                                                    },
                                                                  ),
                                                                ),
                                                              );
                                                            },
                                                          ),
                                                        ),
                                                      );
                                                    },
                                                  ),
                                                ),
                                              );
                                            },
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      );
                    },
                  ),
                ),
              );
            },
          ),
          ExerciseCard(
            title: 'Torso',
            tag: 'Abdominales',
            image: 'assets/images/abdominales.jpg',
            press: () {
              return Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ExerciseScreen(
                    tag: 'Abdominales',
                    image: 'assets/images/abdominales.jpg',
                    minutes: '20',
                    repetitions: '7',
                    calories: '110.1',
                    description: 'Hola jejeje',
                    list: 'torso',
                    press: () {},
                  ),
                ),
              );
            },
          ),
          ExerciseCard(
            title: 'Piernas',
            tag: 'Pierna',
            image: 'assets/images/pierna.jpg',
            press: () {
              return Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ExerciseScreen(
                    tag: 'Pierna',
                    image: 'assets/images/pierna.jpg',
                    minutes: '25',
                    repetitions: '8',
                    calories: '212.7',
                    description: 'Hola jejeje',
                    list: 'piernas',
                    press: () {},
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
