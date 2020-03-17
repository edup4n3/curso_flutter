import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() async {
  runApp(MaterialApp(
    home: Home(),
    theme: ThemeData(
        hintColor: Colors.indigo,
        primaryColor: Colors.amberAccent,
        inputDecorationTheme: InputDecorationTheme(
          enabledBorder:
          OutlineInputBorder(borderSide: BorderSide(color: Colors.indigo)),
          focusedBorder:
          OutlineInputBorder(borderSide: BorderSide(color: Colors.amberAccent)),
          hintStyle: TextStyle(color: Colors.amber
          ),
        )),
  ));
}

const request ="https://api.hgbrasil.com/finance?format=json-cors&key=cc232204";

Future<Map> getData() async {
  http.Response response = await http.get(request);
  return json.decode(response.body);
}

class Home extends StatefulWidget {

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  double dolar;
  double euro;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text("\$CONVESOR\$"),
        backgroundColor: Colors.yellow,
        centerTitle: true,
      ),
      body: FutureBuilder<Map>(
        future: getData(),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
            case ConnectionState.waiting:
              return Center(
                  child: Text(
                "Carregando dados",
                style: TextStyle(color: Colors.black, fontSize: 25.0),
                textAlign: TextAlign.center,
              ));
            default:
              if (snapshot.hasError) {
                return Center(
                    child: Text(
                  "Erro ao carregar dados dados",
                  style: TextStyle(
                  color: Colors.orange, fontSize: 25.0),
                  textAlign: TextAlign.center,)
                );
              } else {

                dolar = snapshot.data["results"]["currencies"]["USD"]["buy"];
                euro = snapshot.data["results"]["currencies"]["EUR"]["buy"];

                return SingleChildScrollView(
                  padding: EdgeInsets.all(10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Icon(Icons.monetization_on, size: 100.0, color: Colors.amber),
                      buildTextFiel("Reais", "R\$"),
                      Divider(),
                      buildTextFiel("Dólar", "U\$\$"),
                      Divider(),
                      buildTextFiel("Euro", "EUR"),
                    ],
                  ),
                );
              }
          }
        },
      ),
    );
  }
}

Widget buildTextFiel(String label, String prefix){
  return  TextField(
    decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(color: Colors.amber),
        border: OutlineInputBorder(),
        prefixText: prefix,
    ),
    style: TextStyle(
        color: Colors.amber, fontSize: 25.0
    ),
  );

}
