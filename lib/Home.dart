import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String _resultado = "";

  TextEditingController _controllerCep = TextEditingController();

  _recuperarCep() async {
    String cepDigitado = _controllerCep.text;
    String url = "https://viacep.com.br/ws/${cepDigitado}/json/";
    http.Response response;

    response = await http.get(Uri.parse(url));
    Map<String, dynamic> retorno = json.decode(response.body);
    String logradouro = retorno["logradouro"];
    String complemento = retorno["complemento"];
    String bairro = retorno["bairro"];
    String localidade = retorno["localidade"];

    setState(() {
      _resultado = "${logradouro}, ${complemento}, ${bairro},  ${localidade}";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Consumo de Serviço Web"),
      ),
      body: Container(
        padding: EdgeInsets.all(40),
        child: Column(children: [
          TextField(
            keyboardType: TextInputType.number,
            decoration:
                InputDecoration(labelText: "Digite o cep. EX: 21121400"),
            style: TextStyle(fontSize: 20),
            controller: _controllerCep,
          ),
          Padding(padding: EdgeInsets.only(top: 15)),
          ElevatedButton(
            onPressed: _recuperarCep,
            child: Text("Clique aqui"),
          ),
          Padding(padding: EdgeInsets.only(top: 15)),
          Text(
            _resultado,
            style: TextStyle(fontSize: 20),
          ),
        ]),
      ),
    );
  }
}
