import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ganbare/src/UI/Home/Home_screen.dart';
import 'package:ganbare/src/Shared/Loading.dart';
import 'dart:async';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart';

class UpdateUserData extends StatefulWidget {
  @override
  _UpdateUserDataState createState() => _UpdateUserDataState();
}

class _UpdateUserDataState extends State<UpdateUserData> {
  final CollectionReference coleccion =
      FirebaseFirestore.instance.collection('Users');
  final user = FirebaseAuth.instance.currentUser;
  final _formKey = GlobalKey<FormState>();
  final picker = ImagePicker();
  File _image;
  bool loading = false;
  final List<String> sex = ['Hombre', 'Mujer'];
  String _currentName;
  String _currentAge;
  String _currentHeight;
  String _currentWeigth;
  String _currentSex;
  TextEditingController searchEditor = TextEditingController();

  String validateHeight(String value) {
    String pattern = r'^[1-2]{1}.[0-9]{2}$';
    RegExp regExp = new RegExp(pattern);
    if (value.length == 0) {
      return "Ingresa tu estatura";
    } else if (!regExp.hasMatch(value)) {
      return "Ingresa tu estatura en metros";
    } else {
      return null;
    }
  }

  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return loading
        ? Loading()
        : Scaffold(
            appBar: AppBar(
              title: Text('Actualiza tu información'),
              centerTitle: true,
            ),
            body: Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(0),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(50),
                            topRight: Radius.circular(50),
                          ),
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(0),
                          child: SingleChildScrollView(
                            child: Column(
                              children: <Widget>[
                                SizedBox(
                                  height: size.height * 0.01,
                                ),
                                //-----------------
                                Padding(
                                  padding: EdgeInsets.all(20.0),
                                  child: Form(
                                    key: _formKey,
                                    child: Column(
                                      children: <Widget>[
                                        StreamBuilder(
                                            stream: coleccion
                                                .doc(user.uid)
                                                .snapshots(),
                                            builder: (BuildContext context,
                                                AsyncSnapshot snapshot) {
                                              if (snapshot.connectionState ==
                                                  ConnectionState.active) {
                                                return Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: <Widget>[
                                                    Align(
                                                      alignment:
                                                          Alignment.center,
                                                      child: CircleAvatar(
                                                        radius: 80,
                                                        backgroundColor:
                                                            Colors.grey[400],
                                                        child: ClipOval(
                                                          child: SizedBox(
                                                            height: 150,
                                                            width: 150,
                                                            child: (snapshot.data
                                                                            .data()[
                                                                        'pic'] !=
                                                                    null)
                                                                ? Image.network(
                                                                    '${snapshot.data.data()['pic']}',
                                                                    fit: BoxFit
                                                                        .cover,
                                                                  )
                                                                : Image.asset(
                                                                    'assets/images/silueta.png'),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding: EdgeInsets.only(
                                                          top: 20.0),
                                                      child: IconButton(
                                                        icon: Icon(
                                                          Icons.camera_alt,
                                                          size: 30.0,
                                                        ),
                                                        onPressed: () async {
                                                          var image = await picker
                                                              .getImage(
                                                                  source: ImageSource
                                                                      .gallery);
                                                          setState(() async {
                                                            if (image != null) {
                                                              _image = File(
                                                                  image.path);
                                                              String fileName =
                                                                  basename(_image
                                                                      .path);
                                                              var imagePath =
                                                                  '/users/${user.uid}/$fileName';
                                                              final StorageReference
                                                                  storageReference =
                                                                  FirebaseStorage()
                                                                      .ref()
                                                                      .child(
                                                                          imagePath);
                                                              final StorageUploadTask
                                                                  uploadTask =
                                                                  storageReference
                                                                      .putFile(
                                                                          _image);
                                                              final StreamSubscription<
                                                                      StorageTaskEvent>
                                                                  streamSubscription =
                                                                  uploadTask
                                                                      .events
                                                                      .listen(
                                                                          (event) {});
                                                              await uploadTask
                                                                  .onComplete;
                                                              streamSubscription
                                                                  .cancel();
                                                              setState(
                                                                  () async {
                                                                await coleccion
                                                                    .doc(user
                                                                        .uid)
                                                                    .update({
                                                                  'pic': (await storageReference
                                                                          .getDownloadURL())
                                                                      .toString()
                                                                });
                                                              });
                                                            } else {
                                                              print(
                                                                  'No image selected.');
                                                            }
                                                          });
                                                        },
                                                      ),
                                                    ),
                                                  ],
                                                );
                                              } else {
                                                return CircularProgressIndicator();
                                              }
                                            }),
                                        Container(
                                          alignment: Alignment.centerLeft,
                                          padding: EdgeInsets.all(8.0),
                                          decoration: BoxDecoration(
                                            border: Border(
                                              bottom: BorderSide(
                                                  color: Colors.grey[100]),
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Container(
                                          alignment: Alignment.centerLeft,
                                          padding: EdgeInsets.all(2.0),
                                          decoration: BoxDecoration(
                                            border: Border(
                                              bottom: BorderSide(
                                                  color: Colors.grey[100]),
                                            ),
                                          ),
                                          child: TextFormField(
                                            decoration: InputDecoration(
                                              icon: Icon(Icons.person),
                                              border: InputBorder.none,
                                              hintText: 'Nombre de usuario',
                                              hintStyle: TextStyle(
                                                  color: Colors.grey[400]),
                                            ),
                                            validator: (value) => value.isEmpty
                                                ? 'Ingresa un nombre de usuario'
                                                : null,
                                            onChanged: (value) {
                                              setState(
                                                  () => _currentName = value);
                                            },
                                          ),
                                        ),
                                        Container(
                                          alignment: Alignment.centerLeft,
                                          padding: EdgeInsets.all(2.0),
                                          decoration: BoxDecoration(
                                            border: Border(
                                              bottom: BorderSide(
                                                  color: Colors.grey[100]),
                                            ),
                                          ),
                                          child: TextFormField(
                                            decoration: InputDecoration(
                                              icon: Icon(Icons.person),
                                              border: InputBorder.none,
                                              hintText: 'Edad',
                                              hintStyle: TextStyle(
                                                  color: Colors.grey[400]),
                                            ),
                                            validator: (value) => value.isEmpty
                                                ? 'Ingresa tu edad'
                                                : null,
                                            onChanged: (value) {
                                              setState(
                                                  () => _currentAge = value);
                                            },
                                          ),
                                        ),
                                        Container(
                                          alignment: Alignment.centerLeft,
                                          padding: EdgeInsets.all(2.0),
                                          decoration: BoxDecoration(
                                            border: Border(
                                              bottom: BorderSide(
                                                  color: Colors.grey[100]),
                                            ),
                                          ),
                                          child: TextFormField(
                                            decoration: InputDecoration(
                                              icon: Icon(Icons.person),
                                              border: InputBorder.none,
                                              hintText: 'Altura',
                                              hintStyle: TextStyle(
                                                  color: Colors.grey[400]),
                                            ),
                                            validator: validateHeight,
                                            onChanged: (value) {
                                              setState(
                                                  () => _currentHeight = value);
                                            },
                                          ),
                                        ),
                                        Container(
                                          alignment: Alignment.centerLeft,
                                          padding: EdgeInsets.all(2.0),
                                          decoration: BoxDecoration(
                                            border: Border(
                                              bottom: BorderSide(
                                                  color: Colors.grey[100]),
                                            ),
                                          ),
                                          child: TextFormField(
                                            decoration: InputDecoration(
                                              icon: Icon(Icons.person),
                                              border: InputBorder.none,
                                              hintText: 'Peso',
                                              hintStyle: TextStyle(
                                                  color: Colors.grey[400]),
                                            ),
                                            validator: (value) => value.isEmpty
                                                ? 'Ingresa tu peso'
                                                : null,
                                            onChanged: (value) {
                                              setState(
                                                  () => _currentWeigth = value);
                                            },
                                          ),
                                        ),
                                        Container(
                                          alignment: Alignment.centerLeft,
                                          padding: EdgeInsets.all(2.0),
                                          decoration: BoxDecoration(
                                            border: Border(
                                              bottom: BorderSide(
                                                  color: Colors.grey[100]),
                                            ),
                                          ),
                                          child: DropdownButtonFormField(
                                            value: 'Hombre' ?? 'Hombre',
                                            items: sex.map((sexo) {
                                              return DropdownMenuItem(
                                                value: sexo,
                                                child: Text('$sexo'),
                                              );
                                            }).toList(),
                                            validator: (val) => val.isEmpty
                                                ? 'Ingresa tu sexo'
                                                : null,
                                            onChanged: ((value) => setState(
                                                () => _currentSex = value)),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: size.height * 0.01,
                                ),
                                Container(
                                  height: 60.0,
                                  width: 160,
                                  padding: EdgeInsets.symmetric(
                                    vertical: 10.0,
                                  ),
                                  child: RaisedButton(
                                    elevation: 5.0,
                                    onPressed: () async {
                                      if (_formKey.currentState.validate()) {
                                        setState(() => loading = true);
                                        await coleccion
                                            .doc(user.uid)
                                            .update({'name': _currentName});
                                        await coleccion.doc(user.uid).update(
                                            {'age': double.parse(_currentAge)});
                                        await coleccion.doc(user.uid).update({
                                          'height': double.parse(_currentHeight)
                                        });
                                        await coleccion.doc(user.uid).update({
                                          'weigth': double.parse(_currentWeigth)
                                        });
                                        await coleccion.doc(user.uid).update({
                                          'IMC': (double.parse(_currentWeigth) /
                                              (double.parse(_currentHeight) *
                                                  double.parse(_currentHeight)))
                                        });
                                        await coleccion.doc(user.uid).update({
                                          'initialWeigth':
                                              double.parse(_currentWeigth)
                                        });
                                        await coleccion
                                            .doc(user.uid)
                                            .update({'sex': _currentSex});
                                        if (_currentSex == 'Hombre') {
                                          await coleccion.doc(user.uid).update({
                                            'idealWeight': ((double.parse(
                                                            _currentHeight) *
                                                        double.parse(
                                                            _currentHeight)) *
                                                    23)
                                                .round()
                                          });
                                        } else if (_currentSex == 'Mujer') {
                                          await coleccion.doc(user.uid).update({
                                            'idealWeight': ((double.parse(
                                                            _currentHeight) *
                                                        double.parse(
                                                            _currentHeight)) *
                                                    22)
                                                .round()
                                          });
                                        }
                                        setState(() => loading = false);
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    HomeScreen()));
                                      }
                                    },
                                    padding: EdgeInsets.all(0.0),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(30.0),
                                    ),
                                    color: Color.fromRGBO(50, 150, 50, 1),
                                    child: Text(
                                      'Actualizar',
                                      style: TextStyle(
                                          color: Colors.white,
                                          letterSpacing: 1.5,
                                          fontSize: 18.0,
                                          fontWeight: FontWeight.bold,
                                          fontStyle: FontStyle.italic),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
  }
}
