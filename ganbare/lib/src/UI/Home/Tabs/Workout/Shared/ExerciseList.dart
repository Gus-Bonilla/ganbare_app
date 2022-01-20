import 'package:flutter/material.dart';
import 'package:ganbare/src/Models/Exercise.dart';

class ExerciseList extends StatelessWidget {
  const ExerciseList({
    this.list,
    Key key,
  }) : super(key: key);
  final String list;
  static String rootPath = "assets/images/exercises/";
  static List<Exercise> exerciseList = [];

  static List<Exercise> brazos = [
      Exercise(
          name: 'Biceps curl',
          image: rootPath + 'bicepscurl.gif',
          duration: '20',
          description: ''),
      Exercise(
          name: 'Triceps ext',
          image: rootPath + 'tricepsext.gif',
          duration: '20',
          description: ''),
      Exercise(
          name: 'Press acostado',
          image: rootPath + 'pressacostado.gif',
          duration: '20',
          description: ''),
      Exercise(
          name: 'Ski row',
          image: 'assets/images/biceps.jpg',
          duration: '20',
          description: ''),
      Exercise(
          name: 'Back row',
          image: rootPath + 'backrow.gif',
          duration: '20',
          description: ''),
      Exercise(
          name: 'Press militar',
          image: rootPath + 'pressmilitar.gif',
          duration: '20',
          description: ''),
      Exercise(
          name: 'Flys',
          image: rootPath + 'frontfly.gif',
          duration: '20',
          description: ''),
      Exercise(
          name: 'Dips',
          image: rootPath + 'dips.gif',
          duration: '20',
          description: ''),
    ];
    static List<Exercise> piernas = [
      Exercise(
          name: 'Hip thrust',
          image: rootPath + 'hipthrust.gif',
          duration: '20',
          description: ''),
      Exercise(
          name: 'Assisted frontleg squad',
          image: rootPath + 'backlegsquat.gif',
          duration: '20',
          description: ''),
      Exercise(
          name: 'Assisted backleg squad',
          image: rootPath + 'backlegsquat.gif',
          duration: '20',
          description: ''),
      Exercise(
          name: 'Outwards heel ext',
          image: rootPath + 'heelextension.gif',
          duration: '20',
          description: ''),
      Exercise(
          name: 'Inwards heel ext',
          image: rootPath + 'heelextension.gif',
          duration: '20',
          description: ''),
      Exercise(
          name: 'Mountain climbers',
          image: rootPath + 'mountainclimber.gif',
          duration: '20',
          description: ''),
      Exercise(
          name: 'Dead lift',
          image: rootPath + 'deadlift.gif',
          duration: '20',
          description: ''),
      Exercise(
          name: 'Squad whit pause',
          image: rootPath + 'pausesquat.gif',
          duration: '20',
          description: ''),
    ];
    static List<Exercise> torso = [
      Exercise(
          name: 'Pull up',
          image: rootPath + 'pullup.gif',
          duration: '20',
          description: ''),
      Exercise(
          name: 'Dive bomber',
          image: rootPath + 'divebomber.gif',
          duration: '20',
          description: ''),
      Exercise(
          name: 'Frontal plank',
          image: rootPath + 'frontalplank.gif',
          duration: '20',
          description: ''),
      Exercise(
          name: 'Side plank',
          image: rootPath + 'sideplank.gif',
          duration: '20',
          description: ''),
      Exercise(
          name: 'Superman',
          image: rootPath + 'superman.gif',
          duration: '20',
          description: ''),
      Exercise(
          name: 'Reverse fly',
          image: rootPath + 'reversefly.gif',
          duration: '20',
          description: ''),
      Exercise(
          name: 'Shrungs',
          image: rootPath + 'shrungs.gif',
          duration: '20',
          description: ''),
    ];


  
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;


    (() {
      if (list == 'brazos') {
        exerciseList = brazos;
      } else if (list == 'piernas') {
        exerciseList = piernas;
      } else if (list == 'torso') {
        exerciseList = torso;
      }
    }());

    return Container(
      child: ListView.builder(
        itemCount: exerciseList.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: EdgeInsets.all(1),
            child: Card(
              child: ListTile(
                leading: ClipOval(
                  child: SizedBox(
                    height: size.height * 0.26,
                    width: size.width * 0.15,
                    child: Image.asset(
                      exerciseList[index].image,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                title: Text(exerciseList[index].name),
                subtitle: Text(exerciseList[index].duration + 'seg'),
                trailing: Icon(Icons.info),
              ),
            ),
          );
        },
      ),
    );
  }
}
