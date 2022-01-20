import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ganbare/src/Models/todo.dart';
import 'package:ganbare/src/Services/Sqflite/repository_service_todo.dart';

class Habits extends StatefulWidget {
  @override
  _Habits createState() => _Habits();
}

class _Habits extends State<Habits> {
  final _formKey = GlobalKey<FormState>();
  Future<List<Todo>> future;
  String name;
  int id;
  bool _lunes, _martes, _miercoles, _jueves, _viernes, _sabado, _domingo;

  TimeOfDay _time;
  TimeOfDay picked;
  String fechaHoy;
  String hora;

  @override
  initState() {
    super.initState();
    future = RepositoryServiceTodo.getAllTodos();
    DateTime fechaHoyChafa = DateTime.now();
    fechaHoy = fechaHoyChafa.toUtc().toString();
    fechaHoy = fechaHoy.substring(0, 10);
  }

  void readData() async {
    final todo = await RepositoryServiceTodo.getTodo(id);
    print(todo.name);
  }

  updateTodo(Todo todo, String newName) async {
    todo.name = newName;
    await RepositoryServiceTodo.updateTodo(todo);
    setState(() {
      future = RepositoryServiceTodo.getAllTodos();
    });
  }

  cambiar2NoCompletado(Todo todo) async {
    List<String> actividadSplitted = todo.name.split("##");
    String actividad = actividadSplitted[0];
    String diasActividad = actividadSplitted[1];
    String horaActividad = actividadSplitted[2];
    String ultimoDiaCompletado = actividadSplitted[3];
    String fechaCreacion = actividadSplitted[5];
    String cantidadCompletadas = actividadSplitted[6];

    String newName = actividad +
        "##" +
        diasActividad +
        "##" +
        horaActividad +
        "##" +
        ultimoDiaCompletado +
        "##" +
        "NO" +
        "##" +
        fechaCreacion +
        "##" +
        cantidadCompletadas;

    updateTodo(todo, newName);
  }

  deleteTodo(Todo todo) async {
    await RepositoryServiceTodo.deleteTodo(todo);
    setState(() {
      id = null;
      future = RepositoryServiceTodo.getAllTodos();
    });
  }

  marcarCompletado(Todo todo) async {
    final DateTime now = DateTime.now();
    List<String> actividadSplitted = todo.name.split("##");
    String actividad = actividadSplitted[0];
    String diasActividad = actividadSplitted[1];
    String horaActividad = actividadSplitted[2];
    String fechaCreacion = actividadSplitted[5];
    String cantidadCompletadas = actividadSplitted[6];

    int cantidadNumero = int.parse(cantidadCompletadas);
    cantidadNumero = cantidadNumero + 1;
    cantidadCompletadas = cantidadNumero.toString();

    String newName = actividad +
        "##" +
        diasActividad +
        "##" +
        horaActividad +
        "##" +
        now.weekday.toString() +
        "##" +
        "SI" +
        "##" +
        fechaCreacion +
        "##" +
        cantidadCompletadas;

    updateTodo(todo, newName);
  }

  int restarFechas(String fecha1, String fecha2) {
    List<String> fecha1Splitted = fecha1.split("-");
    List<String> fecha2Splitted = fecha2.split("-");
    int difDias = int.parse(fecha2Splitted[2]) - int.parse(fecha1Splitted[2]);
    int difMeses = int.parse(fecha2Splitted[1]) - int.parse(fecha1Splitted[1]);
    int difAnos = int.parse(fecha2Splitted[0]) - int.parse(fecha1Splitted[0]);
    return ((difAnos * 365) + (difMeses * 30) + (difDias));
  }

  String calcularPorcentaje(
      String diasActividad, String fechaCreacion, String cantidadCompletadas) {
    int cantidadDiasSemana = 0;
    int cantidadDiasDesdeCreacion = restarFechas(fechaCreacion, fechaHoy);
    List<String> diasDeSemana = [
      "LUN",
      "MAR",
      "MIE",
      "JUE",
      "VIE",
      "SAB",
      "DOM"
    ];

    for (String dia in diasDeSemana) {
      if (diasActividad.contains(dia))
        cantidadDiasSemana = cantidadDiasSemana + 1;
    }
    double diasEfectivos =
        ((cantidadDiasDesdeCreacion / 7.0) * cantidadDiasSemana) + 28;
    return ((100 / diasEfectivos) * int.parse(cantidadCompletadas)).toString();
  }

  Card buildItem(Todo todo) {
    String actividad = todo.name;
    List<String> actividadSplitted = actividad.split("##");
    actividad = actividadSplitted[0];
    String diasActividad = actividadSplitted[1];
    String horaActividad = actividadSplitted[2];
    String ultimoDiaCompletado = actividadSplitted[3];
    String completadoActividad = actividadSplitted[4];
    String fechaCreacion = actividadSplitted[5];
    String cantidadCompletadas = actividadSplitted[6];
    String _seCompleto = ""; // "Marcar como hecho" o "Hecho :)"
    Color _colorCompletado = Colors.black;
    final DateTime now = DateTime.now();

    if (completadoActividad == "SI") {
      _seCompleto = "Hecho";
      _colorCompletado = Colors.blue[600];
      if (ultimoDiaCompletado != now.weekday.toString())
        cambiar2NoCompletado(todo);
    } else {
      _seCompleto = "Completar";
      _colorCompletado = Colors.blue[900];
    }

    String porcentajeSeguimiento =
        calcularPorcentaje(diasActividad, fechaCreacion, cantidadCompletadas);
    porcentajeSeguimiento = porcentajeSeguimiento.substring(
        0, porcentajeSeguimiento.indexOf(".") + 2);

    return Card(
      color: Colors.indigo[50],
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: <Widget>[
                Text(
                  '$actividad',
                  style: TextStyle(
                      fontSize: 30,
                      color: Colors.indigo,
                      fontWeight: FontWeight.w800),
                ),
                Spacer(),
                Container(
                  height: 30,
                  width: 40,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.indigo[200],
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black26,
                        offset: Offset(0, 2),
                        blurRadius: 8.0,
                      ),
                    ],
                  ),
                  child: Center(
                    child: FlatButton(
                      textColor: Colors.white,
                      onPressed: () => {
                        showDialog(
                            context: context,
                            barrierDismissible: false,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: new Text("Borrar hábito"),
                                content: new Text(
                                    "¿Estás seguro de que quieres \n borrar este hábito?"),
                                actions: <Widget>[
                                  new FlatButton(
                                      child: new Text("Si"),
                                      onPressed: () {
                                        deleteTodo(todo);
                                        Navigator.of(context).pop();
                                      }),
                                  new FlatButton(
                                    child: new Text("Cancelar"),
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                ],
                              );
                            }),
                      },
                      child: Text('X'),
                    ),
                  ),
                ),
              ],
            ),
            Text(
              'Programado para: \n$diasActividad',
              style: TextStyle(fontSize: 15),
            ),
            Text(
              'Horario: $horaActividad hrs',
              style: TextStyle(fontSize: 15),
            ),
            SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Container(
                  child: RaisedButton(
                    textColor: Colors.white,
                    color: Colors.green[700],
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    onPressed: () {},
                    child: Column(
                      children: <Widget>[
                        SizedBox(
                          height: 6,
                        ),
                        Text(
                          'Porcentaje de seguimiento \n del hábito:',
                          style: TextStyle(fontSize: 10),
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Text(porcentajeSeguimiento + " %"),
                      ],
                    ),
                  ),
                ),
                Spacer(),
                Container(
                  child: RaisedButton(
                    textColor: Colors.white,
                    color: _colorCompletado,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25.0),
                    ),
                    padding: EdgeInsets.all(15.0),
                    onPressed: () {
                      if (completadoActividad != "SI") marcarCompletado(todo);
                    },
                    child: Text(_seCompleto),
                  ),
                ),
                SizedBox(width: 8),
              ],
            )
          ],
        ),
      ),
    );
  }

  TextFormField buildTextFormField() {
    return TextFormField(
      decoration: InputDecoration(
        border: InputBorder.none,
        hintText: '¿Que habito iniciarás?',
        fillColor: Colors.white,
        filled: true,
      ),
      validator: (value) {
        if (value.isEmpty) {
          return 'Introduzca una actividad';
        }
      },
      onSaved: (value) => name = value,
    );
  }

  void createTodo() async {
    if (_formKey.currentState.validate() &&
        !(!_lunes &&
            !_martes &&
            !_miercoles &&
            !_jueves &&
            !_viernes &&
            !_sabado &&
            !_domingo)) {
      _formKey.currentState.save();

      String dias = "";

      if (_lunes) dias = dias + "LUN";
      if (_martes) dias = dias + ", MAR";
      if (_miercoles) dias = dias + ", MIE";
      if (_jueves) dias = dias + ", JUE";
      if (_viernes) dias = dias + ", VIE";
      if (_sabado) dias = dias + ", SAB";
      if (_domingo) dias = dias + ", DOM";

      if (dias[0] == ",") dias = dias.substring(2);

      name = name +
          "##" +
          dias +
          "##" +
          hora +
          "##" +
          "0" +
          "##" +
          "NO" +
          "##" +
          fechaHoy +
          "##" +
          "0";

      int count = await RepositoryServiceTodo.todosCount();
      final todo = Todo(count, name, "", false);
      await RepositoryServiceTodo.addTodo(todo);
      setState(() {
        id = todo.id;
        future = RepositoryServiceTodo.getAllTodos();
      });
      print(todo.id);
    }
  }

  String formatearHora(String horaChafa) {
    return horaChafa.substring(10, 15);
  }

  void _showBottom() {
    _lunes = false;
    _martes = false;
    _miercoles = false;
    _jueves = false;
    _viernes = false;
    _sabado = false;
    _domingo = false;
    _time = TimeOfDay.now();
    hora = formatearHora(_time.toString());

    showModalBottomSheet(
        backgroundColor: Colors.indigo[50],
        context: context,
        builder: (BuildContext context) {
          return new Container(
            padding: new EdgeInsets.all(15.0),
            child: StatefulBuilder(
              builder: (BuildContext context, StateSetter stateSetter) {
                Column semana1 = new Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text("Lunes"),
                    CupertinoSwitch(
                      value: _lunes,
                      onChanged: (val) {
                        stateSetter(() => _lunes = val);
                      },
                    ),
                    Text("Jueves"),
                    CupertinoSwitch(
                      value: _jueves,
                      onChanged: (val) {
                        stateSetter(() => _jueves = val);
                      },
                    ),
                  ],
                );
                Column semana2 = new Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text("Martes"),
                    CupertinoSwitch(
                      value: _martes,
                      onChanged: (val) {
                        stateSetter(() => _martes = val);
                      },
                    ),
                    Text("Viernes"),
                    CupertinoSwitch(
                      value: _viernes,
                      onChanged: (val) {
                        stateSetter(() => _viernes = val);
                      },
                    ),
                  ],
                );
                Column semana3 = new Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text("Miercoles"),
                    CupertinoSwitch(
                      value: _miercoles,
                      onChanged: (val) {
                        stateSetter(() => _miercoles = val);
                      },
                    ),
                    Text("Sabado"),
                    CupertinoSwitch(
                      value: _sabado,
                      onChanged: (val) {
                        stateSetter(() => _sabado = val);
                      },
                    ),
                  ],
                );
                Column semana4 = new Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text("Domingo"),
                    CupertinoSwitch(
                      value: _domingo,
                      onChanged: (val) {
                        stateSetter(() => _domingo = val);
                      },
                    ),
                  ],
                );
                Row semanas = new Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[semana1, semana2, semana3],
                );

                Future<Null> selectTime(BuildContext context) async {
                  picked = await showTimePicker(
                      context: context, initialTime: _time);
                  setState(() {
                    print(_time);
                    _time = picked;
                    stateSetter(() => hora = formatearHora(_time.toString()));
                  });
                }

                return new ListView(
                  children: <Widget>[
                    new Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[],
                    ),
                    Form(
                      key: _formKey,
                      child: buildTextFormField(),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    new Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        new Text(
                          "Que dias repetirás este habito",
                          style: new TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    new Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        semanas,
                        semana4,
                      ],
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    new Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        new Text(
                          "Asigna un horario a tu hábito.",
                          style: new TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    new Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        new RaisedButton(
                          color: Colors.blue[200],
                          textColor: Colors.black,
                          onPressed: () {
                            selectTime(context);
                          },
                          child: new Text(hora),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    Row(
                      children: <Widget>[
                        new RaisedButton(
                          color: Colors.red[900],
                          textColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          onPressed: () => Navigator.pop(context),
                          child: new Text("Cancelar"),
                        ),
                        Spacer(),
                        new RaisedButton(
                          color: Colors.green[600],
                          textColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          onPressed: () {
                            createTodo();
                            if (_formKey.currentState.validate() &&
                                !(!_lunes &&
                                    !_martes &&
                                    !_miercoles &&
                                    !_jueves &&
                                    !_viernes &&
                                    !_sabado &&
                                    !_domingo)) Navigator.pop(context);
                          },
                          child: new Text("Crear hábito"),
                        ),
                      ],
                    ),
                  ],
                );
              },
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: ListView(
        padding: EdgeInsets.only(bottom: 20),
        children: <Widget>[
          Positioned(
            top: 0,
            height: 0,
            left: 0,
            right: 0,
            child: ClipRRect(
              borderRadius: BorderRadius.vertical(
                bottom: Radius.circular(20),
              ),
              child: Container(
                padding: const EdgeInsets.all(50.0),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    colors: [
                      Colors.indigo[400],
                      Colors.indigo[200],
                    ],
                  ),
                ),
                child: Text(
                  'Tus hábitos',
                  style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[],
          ),
          FutureBuilder<List<Todo>>(
            future: future,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Column(
                    children:
                        snapshot.data.map((todo) => buildItem(todo)).toList());
              } else {
                return SizedBox();
              }
            },
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showBottom,
        tooltip: 'Agregar Hábito Nuevo',
        child: Icon(Icons.add),
      ),
    );
  }
}
