import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class RecuperarSenha extends StatelessWidget {
  RecuperarSenha({super.key});

  TextEditingController controlEmail = TextEditingController();

  void _recuperarSenha(BuildContext context) async {
    try {
      await FirebaseAuth.instance
          .sendPasswordResetEmail(email: controlEmail.text);
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Sucesso! Verifique seu e-mail.'),
        backgroundColor: Colors.purple,
      ));
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Error: $error'),
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
              MaterialButton(
                  onPressed: () {
                    _recuperarSenha(context);
                  },
                  child: const Text("Recuperar sua senha!"))
            ],
          ),
        ));
  }
}
