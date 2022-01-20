import 'package:flutter/material.dart';
import 'package:ganbare/src/UI/Home/Tabs/Workout/ExerciseCards/RutineCard.dart';
import 'package:ganbare/src/UI/Home/Tabs/Workout/Shared/Exercise_screen.dart';

class HomeExercise extends StatelessWidget {
  const HomeExercise({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      physics: BouncingScrollPhysics(),
      child: Row(
        children: <Widget>[
          RutineCard(
            size: size,
            title: 'Cardio',
            image: 'assets/images/cardio.jpg',
            tag: 'Cardio',
            press: () {
              return Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ExerciseScreen(
                    tag: 'Cardio',
                    image: 'assets/images/cardio.jpg',
                    minutes: '12',
                    repetitions: '4',
                    calories: '300',
                    description: 'Hola jejeje',
                    press: () {},
                  ),
                ),
              );
            },
          ),
          RutineCard(
            size: size,
            title: 'Mantente en forma',
            image: 'assets/images/enforma.jpg',
            tag: 'Forma',
            press: () {
              return Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ExerciseScreen(
                    tag: 'Forma',
                    image: 'assets/images/enforma.jpg',
                    minutes: '12',
                    repetitions: '4',
                    calories: '300',
                    description: 'Hola jejeje',
                    list: 'espalda',
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
