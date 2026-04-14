import 'package:flutter/material.dart';
import 'primeira_tela.dart';
import 'segunda_tela.dart';

void main() {
  runApp(MyApp()); 
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, // remove a faixa debug
      initialRoute: "/", // rota tela de login
      routes: {
        "/": (context) => const PrimeiraTela(),
        "/segunda": (context) => const SegundaTela(), // tela da lista
      },
    );
  }
}