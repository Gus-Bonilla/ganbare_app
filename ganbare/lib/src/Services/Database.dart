import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseServices {
  final String uid;
  DatabaseServices({this.uid});

  //Referencia a la coleccion
  final CollectionReference userCollection =
      FirebaseFirestore.instance.collection('Users');

  //Actualizar info
  Future updateUserData(
      String name, double age, double height, double weigth, String sex,double initialWeigth, double idealWeight, double imc) async {
    return await userCollection.doc(uid).set({
      'name': name,
      'age': age,
      'height': height,
      'weigth': weigth,
      'sex': sex,
      'idealWeight': idealWeight,
      'IMC': imc,
    });
  }

  Future newExerciseData(String category, double value, int exercises) async {
    return await userCollection.doc(uid).collection('Calories').doc().set({
      'category': category,
      'exercise': exercises,
      'day': DateTime.now().day,
      'month': DateTime.now().month,
      'value': value,
    });
  }

  Stream<DocumentSnapshot> get userData {
    return userCollection.doc(uid).snapshots();
  }
}
