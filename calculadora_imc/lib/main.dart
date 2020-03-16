import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: Home(),
  ));
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController weightController = TextEditingController();
  TextEditingController heightController = TextEditingController();

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String _infoText = "informe seus daods";
  void _resetFields(){
    weightController.text = "";
    heightController.text = "";
    setState(() {
      _infoText = "Informe seus dados!";
      _formKey = GlobalKey<FormState>();    // ADICIONE ESTA LINHA!
    });
  }

  void _calculate() {
    setState(() {
      double weight = double.parse(weightController.text);
      double height = double.parse(heightController.text) / 100;
      double imc = weight/(height*height);
      print(imc);
      if (imc < 18.6){
        _infoText = "Abaixo do peso(${imc.toStringAsPrecision(3)})";
      }
      else if (imc >= 24.9 && imc < 24.9){
        _infoText = "Peso ideal(${imc.toStringAsPrecision(3)})";
      }
      else if (imc >= 24.9 && imc < 29.9){
        _infoText = "Levemente acima do peso(${imc.toStringAsPrecision(3)})";
      }
      else if (imc >= 29.9 && imc < 34.9){
        _infoText = "Obesidade 1(${imc.toStringAsPrecision(3)})";
      }
      else if (imc >=34.9 && imc < 39.9){
        _infoText = "Obesidade 1(${imc.toStringAsPrecision(3)})";
      }
      else if (imc > 40){
        _infoText = "Vá se cuidar(${imc.toStringAsPrecision(3)})";
      }

    });

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Calculadora de IMC"),
          centerTitle: true,
          backgroundColor: Colors.orange,
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.refresh),
              onPressed:  _resetFields,
            )
          ],
        ),
        backgroundColor: Colors.blue,
        body: SingleChildScrollView(
          padding: EdgeInsets.fromLTRB(5.0, 0.0, 5.0, 0.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Icon(Icons.person_outline, size: 130, color: Colors.orange),
                TextFormField(
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                      labelText: "Peso em KG",
                      labelStyle: TextStyle(color: Colors.white)),
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.orange, fontSize: 25.0),
                  controller: weightController,
                  validator: (value) {
                    if(value.isEmpty){
                      return "Insira seu peso";
                    }
                  },
                ),
                TextFormField(
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                      labelText: "Altura em KG",
                      labelStyle: TextStyle(color: Colors.white)),
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.orange, fontSize: 25.0),
                  controller: heightController,
                  validator: (value) {
                    if(value.isEmpty){
                      return "Insira sua altura";
                    }
                  },
                ),
                Padding(
                  padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                  child: Container(
                    height: 50.0,
                    child: RaisedButton(
                      onPressed: (){
                      if(_formKey.currentState.validate()){
                        _calculate();
    }                   },
                      child: Text(
                        "Calcular",
                        style: TextStyle(color: Colors.black, fontSize: 20.0),
                      ),
                      color: Colors.orange,
                    ),
                  ),
                ),
                Text(
                  _infoText,
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.orange, fontSize: 25.00),
                ),
              ],
            ),
          )
        ));
  }
}
