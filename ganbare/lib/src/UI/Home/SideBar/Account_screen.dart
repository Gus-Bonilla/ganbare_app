import 'dart:async';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:ganbare/src/UI/Home/SideBar/Drawer.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart';

class AccountScreen extends StatefulWidget {
  @override
  _AccountScreenState createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  File _image;
  final picker = ImagePicker();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final CollectionReference coleccion =
      FirebaseFirestore.instance.collection('Users');
  final user = FirebaseAuth.instance.currentUser;
  final List<String> sex = ['Hombre', 'Mujer'];

  String _currentName;
  String _currentAge;
  String _currentHeight;
  String _currentWeigth;
  String _currentSex;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      key: _scaffoldKey,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text('Actualiza tu información'),
        centerTitle: true,
        backgroundColor: Colors.blue[300],
      ),
      drawer: MyDrawer(),
      body: StreamBuilder(
          stream: coleccion.doc(user.uid).snapshots(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.connectionState == ConnectionState.active) {
              return Container(
                  child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(
                      height: size.height * 0.15,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Align(
                          alignment: Alignment.center,
                          child: CircleAvatar(
                            radius: 100,
                            backgroundColor: Colors.grey[400],
                            child: ClipOval(
                              child: SizedBox(
                                height: size.height * 0.26,
                                width: size.height * 0.26,
                                child: (snapshot.data.data()['pic'] != null)
                                    ? Image.network(
                                        '${snapshot.data.data()['pic']}',
                                        fit: BoxFit.cover,
                                      )
                                    : Image.asset('assets/images/silueta.png'),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 60.0),
                          child: IconButton(
                            icon: Icon(
                              Icons.camera_alt,
                              size: 30.0,
                            ),
                            onPressed: () async {
                              var image = await picker.getImage(
                                  source: ImageSource.gallery);
                              setState(() async {
                                if (image != null) {
                                  _image = File(image.path);
                                  String fileName = basename(_image.path);
                                  var imagePath =
                                      '/users/${user.uid}/$fileName';
                                  final StorageReference storageReference =
                                      FirebaseStorage().ref().child(imagePath);
                                  final StorageUploadTask uploadTask =
                                      storageReference.putFile(_image);
                                  final StreamSubscription<StorageTaskEvent>
                                      streamSubscription =
                                      uploadTask.events.listen((event) {});
                                  await uploadTask.onComplete;
                                  streamSubscription.cancel();
                                  setState(() async {
                                    await coleccion.doc(user.uid).update({
                                      'pic': (await storageReference
                                              .getDownloadURL())
                                          .toString()
                                    });
                                    _scaffoldKey.currentState.showSnackBar(
                                        SnackBar(
                                            backgroundColor: Colors.green[400],
                                            content: Text('Foto actializada')));
                                  });
                                } else {
                                  print('No image selected.');
                                }
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: size.height * 0.1,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          alignment: Alignment.center,
                          child: Column(
                            children: <Widget>[
                              Column(
                                children: <Widget>[
                                  Container(
                                    alignment: Alignment.center,
                                    child: Text(
                                      'Nombre de usuario',
                                      style: TextStyle(
                                          color: Colors.blueGrey,
                                          fontSize: 18.0),
                                    ),
                                  ),
                                  Container(
                                    alignment: Alignment.center,
                                    child: Text(
                                      '${snapshot.data.data()['name']}',
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 20.0,
                                          fontWeight: FontWeight.w400),
                                    ),
                                  ),
                                ],
                              ),
                              Column(
                                children: <Widget>[
                                  Container(
                                    alignment: Alignment.center,
                                    child: Text(
                                      'Edad',
                                      style: TextStyle(
                                          color: Colors.blueGrey,
                                          fontSize: 18.0),
                                    ),
                                  ),
                                  Container(
                                    alignment: Alignment.center,
                                    child: Text(
                                      '${snapshot.data.data()['age']}',
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 20.0,
                                          fontWeight: FontWeight.w400),
                                    ),
                                  ),
                                ],
                              ),
                              Column(
                                children: <Widget>[
                                  Container(
                                    alignment: Alignment.center,
                                    child: Text(
                                      'Altura',
                                      style: TextStyle(
                                          color: Colors.blueGrey,
                                          fontSize: 18.0),
                                    ),
                                  ),
                                  Container(
                                    alignment: Alignment.center,
                                    child: Text(
                                      '${snapshot.data.data()['height']}',
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 20.0,
                                          fontWeight: FontWeight.w400),
                                    ),
                                  ),
                                ],
                              ),
                              Column(
                                children: <Widget>[
                                  Container(
                                    alignment: Alignment.center,
                                    child: Text(
                                      'Peso',
                                      style: TextStyle(
                                          color: Colors.blueGrey,
                                          fontSize: 18.0),
                                    ),
                                  ),
                                  Container(
                                    alignment: Alignment.center,
                                    child: Text(
                                      '${snapshot.data.data()['weigth'].toStringAsFixed(2)}',
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 20.0,
                                          fontWeight: FontWeight.w400),
                                    ),
                                  ),
                                ],
                              ),
                              Column(
                                children: <Widget>[
                                  Container(
                                    alignment: Alignment.center,
                                    child: Text(
                                      'Sexo',
                                      style: TextStyle(
                                          color: Colors.blueGrey,
                                          fontSize: 18.0),
                                    ),
                                  ),
                                  Container(
                                    alignment: Alignment.center,
                                    child: Text(
                                      '${snapshot.data.data()['sex']}',
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 20.0,
                                          fontWeight: FontWeight.w400),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          width: size.width * 0.1,
                        ),
                        Container(
                          child: Column(
                            children: <Widget>[
                              Container(
                                alignment: Alignment.center,
                                child: Container(
                                  child: IconButton(
                                    icon: Icon(Icons.edit,
                                        color: Colors.blue[300]),
                                    onPressed: () {
                                      showDialog(
                                        context: context,
                                        barrierDismissible: false,
                                        builder: (BuildContext context) {
                                          return AlertDialog(
                                            title: Text('Actualiza tu nombre'),
                                            content: TextFormField(
                                              decoration: InputDecoration(
                                                border: InputBorder.none,
                                                hintText: 'Nombre',
                                                hintStyle: TextStyle(
                                                    color: Colors.grey[400]),
                                              ),
                                              validator: (val) => val.isEmpty
                                                  ? 'Ingresa un nombre'
                                                  : null,
                                              onChanged: ((val) => setState(
                                                  () => _currentName = val)),
                                            ),
                                            actions: <Widget>[
                                              MaterialButton(
                                                  elevation: 5.0,
                                                  child: Text('Cancelar'),
                                                  onPressed: () {
                                                    Navigator.of(context).pop();
                                                  }),
                                              MaterialButton(
                                                elevation: 5.0,
                                                child: Text('Actualizar'),
                                                onPressed: () async {
                                                  await coleccion
                                                      .doc(user.uid)
                                                      .update({
                                                    'name': _currentName
                                                  });
                                                  _scaffoldKey.currentState
                                                      .showSnackBar(
                                                    SnackBar(
                                                      elevation: 5.0,
                                                      duration:
                                                          Duration(seconds: 3),
                                                      backgroundColor:
                                                          Colors.green[400],
                                                      content: Row(
                                                        children: <Widget>[
                                                          Icon(Icons.thumb_up),
                                                          SizedBox(
                                                            width: size.width *
                                                                0.02,
                                                          ),
                                                          Text(
                                                              'Nombre actualizado!')
                                                        ],
                                                      ),
                                                    ),
                                                  );
                                                  Navigator.of(context).pop();
                                                },
                                              ),
                                            ],
                                          );
                                        },
                                      );
                                    },
                                  ),
                                ),
                              ),
                              Container(
                                alignment: Alignment.center,
                                child: Container(
                                  child: IconButton(
                                    icon: Icon(Icons.edit,
                                        color: Colors.blue[300]),
                                    onPressed: () {
                                      showDialog(
                                        context: context,
                                        barrierDismissible: false,
                                        builder: (BuildContext context) {
                                          return AlertDialog(
                                            title: Text('Actualiza tu edad'),
                                            content: TextFormField(
                                              decoration: InputDecoration(
                                                border: InputBorder.none,
                                                hintText: 'Edad',
                                                hintStyle: TextStyle(
                                                    color: Colors.grey[400]),
                                              ),
                                              validator: (val) => val.isEmpty
                                                  ? 'Ingresa tu edad'
                                                  : null,
                                              onChanged: ((val) => setState(
                                                  () => _currentAge = val)),
                                            ),
                                            actions: <Widget>[
                                              MaterialButton(
                                                  elevation: 5.0,
                                                  child: Text('Cancelar'),
                                                  onPressed: () {
                                                    Navigator.of(context).pop();
                                                  }),
                                              MaterialButton(
                                                elevation: 5.0,
                                                child: Text('Actualizar'),
                                                onPressed: () async {
                                                  await coleccion
                                                      .doc(user.uid)
                                                      .update({
                                                    'age': double.parse(
                                                        _currentAge)
                                                  });
                                                  _scaffoldKey.currentState
                                                      .showSnackBar(
                                                    SnackBar(
                                                      elevation: 5.0,
                                                      duration:
                                                          Duration(seconds: 3),
                                                      backgroundColor:
                                                          Colors.green[400],
                                                      content: Row(
                                                        children: <Widget>[
                                                          Icon(Icons.thumb_up),
                                                          SizedBox(
                                                            width: size.width *
                                                                0.02,
                                                          ),
                                                          Text(
                                                              'Edad actualizada!')
                                                        ],
                                                      ),
                                                    ),
                                                  );
                                                  Navigator.of(context).pop();
                                                },
                                              ),
                                            ],
                                          );
                                        },
                                      );
                                    },
                                  ),
                                ),
                              ),
                              Container(
                                alignment: Alignment.center,
                                child: Container(
                                  child: IconButton(
                                    icon: Icon(Icons.edit,
                                        color: Colors.blue[300]),
                                    onPressed: () {
                                      showDialog(
                                        context: context,
                                        barrierDismissible: false,
                                        builder: (BuildContext context) {
                                          return AlertDialog(
                                            title: Text('Actualiza tu altura'),
                                            content: TextFormField(
                                              decoration: InputDecoration(
                                                border: InputBorder.none,
                                                hintText: 'Altura',
                                                hintStyle: TextStyle(
                                                    color: Colors.grey[400]),
                                              ),
                                              validator: (val) => val.isEmpty
                                                  ? 'Ingresa tu altura'
                                                  : null,
                                              onChanged: ((val) => setState(
                                                  () => _currentHeight = val)),
                                            ),
                                            actions: <Widget>[
                                              MaterialButton(
                                                  elevation: 5.0,
                                                  child: Text('Cancelar'),
                                                  onPressed: () {
                                                    Navigator.of(context).pop();
                                                  }),
                                              MaterialButton(
                                                elevation: 5.0,
                                                child: Text('Actualizar'),
                                                onPressed: () async {
                                                  await coleccion
                                                      .doc(user.uid)
                                                      .update({
                                                    'height': double.parse(
                                                        _currentHeight)
                                                  });
                                                  _scaffoldKey.currentState
                                                      .showSnackBar(
                                                    SnackBar(
                                                      elevation: 5.0,
                                                      duration:
                                                          Duration(seconds: 3),
                                                      backgroundColor:
                                                          Colors.green[400],
                                                      content: Row(
                                                        children: <Widget>[
                                                          Icon(Icons.thumb_up),
                                                          SizedBox(
                                                            width: size.width *
                                                                0.02,
                                                          ),
                                                          Text(
                                                              'Altura actualizada!')
                                                        ],
                                                      ),
                                                    ),
                                                  );
                                                  Navigator.of(context).pop();
                                                },
                                              ),
                                            ],
                                          );
                                        },
                                      );
                                    },
                                  ),
                                ),
                              ),
                              Container(
                                alignment: Alignment.center,
                                child: Container(
                                  child: IconButton(
                                    icon: Icon(Icons.edit,
                                        color: Colors.blue[300]),
                                    onPressed: () {
                                      showDialog(
                                        context: context,
                                        barrierDismissible: false,
                                        builder: (BuildContext context) {
                                          return AlertDialog(
                                            title: Text('Actualiza tu peso'),
                                            content: TextFormField(
                                              decoration: InputDecoration(
                                                border: InputBorder.none,
                                                hintText: 'Peso',
                                                hintStyle: TextStyle(
                                                    color: Colors.grey[400]),
                                              ),
                                              validator: (val) => val.isEmpty
                                                  ? 'Ingresa tu peso'
                                                  : null,
                                              onChanged: ((val) => setState(
                                                  () => _currentWeigth = val)),
                                            ),
                                            actions: <Widget>[
                                              MaterialButton(
                                                  elevation: 5.0,
                                                  child: Text('Cancelar'),
                                                  onPressed: () {
                                                    Navigator.of(context).pop();
                                                  }),
                                              MaterialButton(
                                                elevation: 5.0,
                                                child: Text('Actualizar'),
                                                onPressed: () async {
                                                  await coleccion
                                                      .doc(user.uid)
                                                      .update({
                                                    'weigth': double.parse(
                                                        _currentWeigth)
                                                  });
                                                  await coleccion
                                                      .doc(user.uid)
                                                      .update({
                                                    'IMC': (double.parse(
                                                            _currentWeigth) /
                                                        ((snapshot.data.data()[
                                                                    'height'])
                                                                .toDouble() *
                                                            (snapshot.data
                                                                        .data()[
                                                                    'height'])
                                                                .toDouble()))
                                                  });
                                                  _scaffoldKey.currentState
                                                      .showSnackBar(
                                                    SnackBar(
                                                      elevation: 5.0,
                                                      duration:
                                                          Duration(seconds: 3),
                                                      backgroundColor:
                                                          Colors.green[400],
                                                      content: Row(
                                                        children: <Widget>[
                                                          Icon(Icons.thumb_up),
                                                          SizedBox(
                                                            width: size.width *
                                                                0.02,
                                                          ),
                                                          Text(
                                                              'Peso actualizado!')
                                                        ],
                                                      ),
                                                    ),
                                                  );
                                                  Navigator.of(context).pop();
                                                },
                                              ),
                                            ],
                                          );
                                        },
                                      );
                                    },
                                  ),
                                ),
                              ),
                              Container(
                                alignment: Alignment.center,
                                child: Container(
                                  child: IconButton(
                                    icon: Icon(Icons.edit,
                                        color: Colors.blue[300]),
                                    onPressed: () {
                                      showDialog(
                                        context: context,
                                        barrierDismissible: false,
                                        builder: (BuildContext context) {
                                          return AlertDialog(
                                            title: Text('Actualiza tu sexo'),
                                            content: DropdownButtonFormField(
                                              value: _currentSex ??
                                                  '${snapshot.data.data()['sex']}',
                                              items: sex.map((sexo) {
                                                return DropdownMenuItem(
                                                  value: sexo,
                                                  child: Text('$sexo'),
                                                );
                                              }).toList(),
                                              validator: (val) => val.isEmpty
                                                  ? 'Ingresa tu sexo'
                                                  : null,
                                              onChanged: ((val) => setState(
                                                  () => _currentSex = val)),
                                            ),
                                            actions: <Widget>[
                                              MaterialButton(
                                                  elevation: 5.0,
                                                  child: Text('Cancelar'),
                                                  onPressed: () {
                                                    Navigator.of(context).pop();
                                                  }),
                                              MaterialButton(
                                                  elevation: 5.0,
                                                  child: Text('Actualizar'),
                                                  onPressed: () async {
                                                    await coleccion
                                                        .doc(user.uid)
                                                        .update({
                                                      'sex': _currentSex
                                                    });
                                                    _scaffoldKey.currentState
                                                        .showSnackBar(
                                                      SnackBar(
                                                        elevation: 5.0,
                                                        duration: Duration(
                                                            seconds: 3),
                                                        backgroundColor:
                                                            Colors.green[400],
                                                        content: Row(
                                                          children: <Widget>[
                                                            Icon(
                                                                Icons.thumb_up),
                                                            SizedBox(
                                                              width:
                                                                  size.width *
                                                                      0.02,
                                                            ),
                                                            Expanded(
                                                                child: Text(
                                                                    'Sexo actualizado!'))
                                                          ],
                                                        ),
                                                      ),
                                                    );
                                                    Navigator.of(context).pop();
                                                  }),
                                            ],
                                          );
                                        },
                                      );
                                    },
                                  ),
                                ),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ));
            } else {
              return CircularProgressIndicator();
            }
          }),
    );
  }

  Future firebaseiniciacion() async {
    FirebaseApp initialization = await Firebase.initializeApp();
    return initialization;
  }

  Future firebaseUsuario() async {
    final usuario = await FirebaseAuth.instance.currentUser.email;
    return usuario;
  }
}
