import 'package:flutter/material.dart';
import 'package:ganbare/src/UI/Home/Tabs/Workout/ExerciseCards/ExerciseCard.dart';
import 'package:ganbare/src/UI/Home/Tabs/Workout/Shared/Exercise_screen.dart';

class WeigthLoseExercise extends StatelessWidget {
  const WeigthLoseExercise({
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
            title: 'Abdomen plano',
            tag: 'Abdomendel',
            image: 'assets/images/abdominalesBP.jpg',
            press: () {
              return Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ExerciseScreen(
                    tag: 'Abdomendel',
                    image: 'assets/images/abdominalesBP.jpg',
                    minutes: '20',
                    repetitions: '10',
                    calories: '150',
                    description: 'Hola jejeje',
                    press: () {},
                  ),
                ),
              );
            },
          ),
          ExerciseCard(
            title: 'Brazo delgado',
            tag: 'Brazodel',
            image: 'assets/images/brazotonificado.jpg',
            press: () {
              return Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ExerciseScreen(
                    tag: 'Brazodel',
                    image: 'assets/images/brazotonificado.jpg',
                    minutes: '20',
                    repetitions: '10',
                    calories: '150',
                    description: 'Hola jejeje',
                    press: () {},
                  ),
                ),
              );
            },
          ),
          ExerciseCard(
            title: 'Piernas tonificadas',
            tag: 'Piernadel',
            image: 'assets/images/piernatonificada.jpg',
            press: () {
              return Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ExerciseScreen(
                    tag: 'Piernadel',
                    image: 'assets/images/piernatonificada.jpg',
                    minutes: '20',
                    repetitions: '10',
                    calories: '150',
                    description: 'Hola jejeje',
                    press: () {},
                  ),
                ),
              );
            },
          ),
          ExerciseCard(
            title: 'Espalda delgada',
            tag: 'Espaldadel',
            image: 'assets/images/espaldadelgada.jpg',
            press: () {
              return Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ExerciseScreen(
                    tag: 'Espaldadel',
                    image: 'assets/images/espaldadelgada.jpg',
                    minutes: '20',
                    repetitions: '10',
                    calories: '150',
                    description: 'Hola jejeje',
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
