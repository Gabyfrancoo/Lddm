import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
} 

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color.fromARGB(255, 170, 34, 134),
        ),
      ),
      home: const MyHomePage(title: 'Login'),
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
  // imagem
  Widget _img() {
    return Image.asset(
      "assets/images/img1.jpg",
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
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ), // cabecalho

      drawer: const Drawer(), // icone do menu

      // botoes de navegacao
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home', // botao home
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Minha conta', // botao minha conta
          ),
        ],
      ),

      // imagem como plano de fundo e conteúdo por cima
      body: Stack(
        children: [
          _body(), // fundo
          newMethod(), // conteúdo por cima
        ],
      ),
    );
  }

  Padding newMethod() {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(height: 20),

          // Campo Email
          TextField(
            decoration: InputDecoration(
              labelText: 'E-mail',
              border: OutlineInputBorder(),
            ),
          ),

          const SizedBox(height: 16),

          // Campo Password
          TextField(
            obscureText: true, // esconde a senha
            decoration: InputDecoration(
              labelText: 'Password',
              border: OutlineInputBorder(),
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

          const SizedBox(height: 16),
        ],
      ),
    );
  }
}