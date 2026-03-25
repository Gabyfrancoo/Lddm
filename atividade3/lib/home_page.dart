import 'package:flutter/material.dart';
import 'cadastro_page.dart';

/// HomePage (StatefulWidget) - aqui está a sua tela de Login
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // imagem
  Widget _img() {
    return Image.asset(
      "assets/img1.jpg", // <-- caminho novo
      width: double.infinity,
      height: double.infinity,
      fit: BoxFit.cover,
    );
  }

  // corpo da imagem
  Widget _body() {
    return Container(
      color: Colors.white,
      child: SizedBox.expand(
        child: _img(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        _body(), // fundo
        conteudo(context), // conteúdo por cima
      ],
    );
  }

  /// Conteúdo por cima da imagem (campos + botões)
  Widget conteudo(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(height: 20),

          // Campo Email
          const TextField(
            decoration: InputDecoration(
              labelText: 'E-mail',
              border: OutlineInputBorder(),
              filled: true,
              fillColor: Colors.white,
            ),
          ),
          const SizedBox(height: 16),

          // Campo Password
          const TextField(
            obscureText: true, // esconde a senha
            decoration: InputDecoration(
              labelText: 'Password',
              border: OutlineInputBorder(),
              filled: true,
              fillColor: Colors.white,
            ),
          ),
          const SizedBox(height: 20),

          // Botão Enter
          ElevatedButton(
            onPressed: () {
              // ignore: avoid_print
              print("Botão pressionado");
            },
            child: const Text("Enter"),
          ),
          const SizedBox(height: 12),

          // Navigator: Login -> Cadastro
          TextButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const CadastroPage(),
                ),
              );
            },
            child: const Text("Create an account"),
          ),
        ],
      ),
    );
  }
}