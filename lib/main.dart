import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Home(),
    );
  }
}

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController pesoController = TextEditingController();
  TextEditingController alturaController = TextEditingController();

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String _infoText = "Informe seus dados!";

  void _resetCampos() {
    pesoController.text = "";
    alturaController.text = "";
    setState(() {
      _infoText = "Informe seus dados!";
      _formKey = GlobalKey<FormState>();
    });
  }

  void _calcular_imc() {
    setState(() {
      double peso = double.parse(pesoController.text);
      double altura = double.parse(alturaController.text) / 100;
      double imc = peso / (altura * altura);

      if (imc < 18.6) {
        _infoText = "Abaixo do peso (${imc.toStringAsPrecision(4)})";
      } else if (imc >= 18.6 && imc < 24.9) {
        _infoText = "Peso ideal (${imc.toStringAsPrecision(4)})";
      } else if (imc >= 24.9 && imc < 29.9) {
        _infoText = "Levemente acima do peso (${imc.toStringAsPrecision(4)})";
      } else if (imc >= 29.9 && imc < 34.9) {
        _infoText = "Obesidade grau I (${imc.toStringAsPrecision(4)})";
      } else if (imc >= 34.9 && imc < 39.9) {
        _infoText = "Obesidade grau II (${imc.toStringAsPrecision(4)})";
      } else if (imc >= 40) {
        _infoText = "Obesidade grau III (${imc.toStringAsPrecision(4)})";
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Calculadora de IMC"),
          backgroundColor: Colors.blue,
          actions: <Widget>[
            IconButton(
              onPressed: _resetCampos,
              icon: const Icon(Icons.refresh),
            ),
          ],
        ),
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(10.0, 80.0, 10.0, 0.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  const Icon(
                    Icons.person,
                    size: 120.0,
                    color: Colors.blue,
                  ),
                  TextFormField(
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: "Peso (KG)",
                      contentPadding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                      labelStyle: TextStyle(color: Colors.blue, fontSize: 15.0),
                    ),
                    textAlign: TextAlign.center,
                    style: const TextStyle(color: Colors.blue, fontSize: 25.0),
                    controller: pesoController,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Insira seu peso!";
                      }
                    },
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: "Altura (CM)",
                      contentPadding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                      labelStyle: TextStyle(color: Colors.blue, fontSize: 15.0),
                    ),
                    textAlign: TextAlign.center,
                    style: const TextStyle(color: Colors.blue, fontSize: 25.0),
                    controller: alturaController,
                    validator: (texto) {
                      if (texto!.isEmpty) {
                        return "Insira sua altura!";
                      }
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 15.0, bottom: 15.0),
                    child: SizedBox(
                      height: 50.0,
                      child: ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            _calcular_imc();
                          }
                        },
                        child: const Text(
                          'Calcular',
                          style: TextStyle(color: Colors.white, fontSize: 20.0),
                        ),
                      ),
                    ),
                  ),
                  Text(
                    _infoText,
                    textAlign: TextAlign.center,
                    style: const TextStyle(color: Colors.blue, fontSize: 20.0),
                  ),
                ],
              ),
            )));
  }
}
