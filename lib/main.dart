import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fire Base Connection',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.purple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Fire Base Connection'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String msg = "Tente se Conectar.";
  TextEditingController controlLogin = TextEditingController();
  TextEditingController controlSenha = TextEditingController();

  Future<void> _logar() async {
    final response = await http
        .post(Uri.parse("http://localhost/flutterconn/login.php"), body: {
      "username": controlLogin.text,
      "senha": controlSenha.text
    }, headers: {
      "Access-Control-Allow-Origin": "*", // Required for CORS support to work
      "Access-Control-Allow-Credentials":
          "true", // Required for cookies, authorization headers with HTTPS
      "Access-Control-Allow-Headers":
          "Origin,Content-Type,X-Amz-Date,Authorization,X-Api-Key,X-Amz-Security-Token,locale",
      "Access-Control-Allow-Methods": "POST, OPTIONS"
    });

    var data = json.decode(response.body);

    if (data.length != 0) {
      var id = int.parse(data[0]["idlogin"]);
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => Perfil(idlogin: id)),
      );
    } else {
      setState(() {
        msg = "Login Invalido!";
      });
    }
  }

  void _registrar() {}

  void _recuperarSenha() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.purple[300],
          title: Text(
            widget.title,
            style: TextStyle(color: Colors.white),
          ),
        ),
        body: Container(
          child: Column(
            children: [
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text("E-mail"),
              ),
              TextFormField(
                controller: controlLogin,
              ),
              const Text("Senha"),
              TextFormField(
                obscureText: true,
                controller: controlSenha,
              ),
              const SizedBox(
                height: 25,
              ),
              MaterialButton(
                  onPressed: () {
                    _logar();
                  },
                  child: const Text("Logar")),
              MaterialButton(
                  onPressed: () {
                    _recuperarSenha();
                  },
                  child: const Text("Esqueceu sua Senha?")),
              MaterialButton(
                  onPressed: () {
                    _registrar();
                  },
                  child: const Text("Deseja Criar uma Conta?")),
              const SizedBox(
                height: 25,
              ),
              Text("LOG: " + msg)
            ],
          ),
        ));
  }
}
