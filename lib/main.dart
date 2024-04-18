import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/Model/Perfil.dart';
import 'package:flutter_application_1/View/RecuperarSenha.dart';
import 'package:flutter_application_1/View/Registrar.dart';
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
      home: const MyHomePage(title: 'Fire Base - Home '),
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
  TextEditingController controlEmail = TextEditingController();
  TextEditingController controlSenha = TextEditingController();

  void _logar(BuildContext context) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: controlEmail.text, password: controlSenha.text);

      Navigator.push(
          context, MaterialPageRoute(builder: (context) => Perfil()));
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Error: $error'),
        backgroundColor: Colors.purple,
      ));
    }
  }

  void _registrar() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => Registrar()));
  }

  void _recuperarSenha() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => RecuperarSenha()));
  }

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
              const SizedBox(
                height: 20,
              ),
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text("E-mail"),
              ),
              TextFormField(
                controller: controlEmail,
              ),
              const SizedBox(
                height: 20,
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
                    _logar(context);
                  },
                  child: const Text("Logar")),
              const SizedBox(
                height: 25,
              ),
              MaterialButton(
                  onPressed: () {
                    _recuperarSenha();
                  },
                  child: const Text("Esqueceu sua Senha?")),
              const SizedBox(
                height: 25,
              ),
              MaterialButton(
                  onPressed: () {
                    _registrar();
                  },
                  child: const Text("Deseja Criar uma Conta?")),
              const SizedBox(
                height: 25,
              ),
            ],
          ),
        ));
  }
}
