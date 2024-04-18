import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Registrar extends StatelessWidget {
  Registrar({super.key});

  TextEditingController controlEmail = TextEditingController();
  TextEditingController controlSenha = TextEditingController();

  void _registrarUsuario(BuildContext context) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
              email: controlEmail.text, password: controlSenha.text);

      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Sucesso! Realize seu login.'),
        backgroundColor: Colors.purple,
      ));
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Error: $error'),
        backgroundColor: Colors.purple,
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.purple[300],
          title: const Text(
            "FireBase - Recuperar Senha",
            style: TextStyle(color: Colors.white),
          ),
        ),
        body: Container(
          child: Column(
            children: [
              const SizedBox(
                height: 25,
              ),
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text("E-mail"),
              ),
              TextFormField(
                controller: controlEmail,
              ),
              const SizedBox(
                height: 25,
              ),
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text("Senha"),
              ),
              TextFormField(
                obscureText: true,
                controller: controlSenha,
              ),
              const SizedBox(
                height: 25,
              ),
              MaterialButton(
                  onPressed: () {
                    _registrarUsuario(context);
                  },
                  child: const Text("Registrar sua Conta!"))
            ],
          ),
        ));
  }
}
