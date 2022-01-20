import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:shared_preferences/shared_preferences.dart';

class Water extends StatefulWidget {
  @override
  _Water createState() => _Water();
}

class ConsumoAgua {
  final String tipoAgua;
  final int cantidadAgua;
  final charts.Color color;

  ConsumoAgua(this.tipoAgua, this.cantidadAgua, Color color)
      : this.color = charts.Color(
            r: color.red, g: color.green, b: color.blue, a: color.alpha);
}

class _Water extends State<Water> {
  int _cantidadAguaConsumida = 0; // Sacar de la base de datos
  int _cantidadAguaMeta = 1750; // Sacar de la base de datos
  int _incrementoCantidadAgua = 15; // Sacar de la base de datos
  int _cantidadAguaRestante = 1750; // Sacar de la base de datos
  Color colorIncremento8 = Colors.blue[200];
  Color colorIncremento15 = Colors.blue[200];
  Color colorIncremento30 = Colors.blue[200];

  void _incrementCounter() {
    setState(() {
      _cantidadAguaConsumida += _incrementoCantidadAgua;
      if (_cantidadAguaConsumida > _cantidadAguaMeta) {
        _cantidadAguaConsumida = _cantidadAguaMeta;
      }

      _cantidadAguaRestante = _cantidadAguaMeta - _cantidadAguaConsumida;
    });

    guardarDatos();
  }

  @override
  initState() {
    super.initState();
    colorIncremento8 = Colors.blue[200];
    colorIncremento15 = Colors.blue[200];
    colorIncremento30 = Colors.blue[200];

    setState(() {
      obtenerDatos();
    });
  }

  void cambiarIncremento(int incremento) {
    setState(() {
      _incrementoCantidadAgua = incremento;
      colorIncremento15 = Colors.blue[200];
      colorIncremento8 = Colors.blue[200];
      colorIncremento30 = Colors.blue[200];
      if (_incrementoCantidadAgua == 15) colorIncremento15 = Colors.blue;
      if (_incrementoCantidadAgua == 8) colorIncremento8 = Colors.blue;
      if (_incrementoCantidadAgua == 30) colorIncremento30 = Colors.blue;
    });
    guardarDatos();
  }

  Future obtenerDatos() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.reload();
    setState(() {
      _cantidadAguaConsumida = preferences.getInt("aguaConsumida") ?? 0;
      _incrementoCantidadAgua = preferences.getInt("aguaIncremento") ?? 15;
    });
    _cantidadAguaRestante = _cantidadAguaMeta - _cantidadAguaConsumida;

    if (_incrementoCantidadAgua == 15) colorIncremento15 = Colors.blue;
    if (_incrementoCantidadAgua == 8) colorIncremento8 = Colors.blue;
    if (_incrementoCantidadAgua == 30) colorIncremento30 = Colors.blue;
  }

  Future guardarDatos() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    //preferences.reload();
    preferences.setInt("aguaConsumida", _cantidadAguaConsumida);
    preferences.setInt("aguaIncremento", _incrementoCantidadAgua);
  }

  @override
  Widget build(BuildContext context) {
    //Notifications notifications = new Notifications(context);

    var data = [
      ConsumoAgua('Consumida', _cantidadAguaConsumida, Colors.blue[300]),
      ConsumoAgua('Restante', _cantidadAguaRestante, Colors.blue[50]),
    ];

    var series = [
      charts.Series(
        domainFn: (ConsumoAgua clickData, _) => clickData.tipoAgua,
        measureFn: (ConsumoAgua clickData, _) => clickData.cantidadAgua,
        colorFn: (ConsumoAgua clickData, _) => clickData.color,
        id: 'Consumo',
        data: data,
      ),
    ];

    var chart = charts.PieChart(
      series,
      animate: true,
      animationDuration: Duration(seconds: 1),
      //defaultRenderer: new charts.ArcRendererConfig(arcWidth: 40)
    );

    var chartWidget = Padding(
      padding: EdgeInsets.all(10.0),
      child: SizedBox(
        height: 350.0,
        //child: chart,

        child: new Stack(
          children: <Widget>[
            chart,
            Center(
              child: ClipOval(
                child: Material(
                  color: Colors.white, // button color
                  child: InkWell(
                    splashColor: Colors.grey[300], // inkwell color
                    child: SizedBox(
                        width: 250,
                        height: 250,
                        child: Padding(
                          padding: EdgeInsets.all(20.0),
                          child: Image.asset("assets/images/gota.png"),
                        )),
                    onTap: () {
                      _incrementCounter();
                    },
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(' '),
            Text(' '),
            Text('Hoy haz consumido:'),
            Text('$_cantidadAguaConsumida' + ' ml',
                style: Theme.of(context).textTheme.headline4),
            chartWidget,
            Text('Consumo meta: ' + "$_cantidadAguaMeta" + " ml"),
            Text('Te Faltan: ' +
                "$_cantidadAguaRestante" +
                " ml para llegar a la meta"),
            Text(" "),
            Text("Selecciona la cantidad de agua a incrementar por tap:"),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                RaisedButton(
                  onPressed: () => cambiarIncremento(8),
                  child: Text('8 ml', style: TextStyle(color: Colors.white)),
                  color: colorIncremento8,
                ),
                RaisedButton(
                  onPressed: () => cambiarIncremento(15),
                  child: Text('15 ml', style: TextStyle(color: Colors.white)),
                  color: colorIncremento15,
                ),
                RaisedButton(
                  onPressed: () => cambiarIncremento(30),
                  child: Text('30 ml', style: TextStyle(color: Colors.white)),
                  color: colorIncremento30,
                ),
              ],
            ),
          ],
        ),
      ),
      //floatingActionButton: FloatingActionButton(
      //  onPressed: notifications.showNotification,
      //  tooltip: 'Increment',
      //  child: Icon(Icons.add),
      //),
    );
  }
}
