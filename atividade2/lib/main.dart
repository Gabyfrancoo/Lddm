import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
} 

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, // remove DEBUG
      title: 'Cadastro',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color.fromARGB(255, 170, 34, 134),
        ),
      ),
      home: const MyHomePage(title: 'Cadastro'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

// enum para escolha unica 
enum Genero { masculino, feminino }

class _MyHomePageState extends State<MyHomePage> {

  // Variaveis de estado
  bool mostrarSenha = false;

  Genero? generoSelecionado;

  bool notifEmail = false;
  bool notifTelefone = false;

  double tamanhoFonte = 16;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),

      drawer: const Drawer(),

      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Minha conta',
          ),
        ],
      ),

      body: conteudo(),
    );
  }

  Widget conteudo() {
    return Padding(
      padding: const EdgeInsets.all(16.0),

      child: ListView(
        children: [
          const SizedBox(height: 20),
          // Nome
          TextField(
            maxLength: 30,
            style: TextStyle(fontSize: tamanhoFonte),
            decoration: const InputDecoration(
              labelText: 'Nome',
              border: OutlineInputBorder(),
            ),
          ),

          const SizedBox(height: 10),

          // Data de nascimento
          TextField(
            keyboardType: TextInputType.datetime,
            style: TextStyle(fontSize: tamanhoFonte),
            decoration: const InputDecoration(
              labelText: 'Data de nascimento',
              border: OutlineInputBorder(),
            ),
          ),

          const SizedBox(height: 10),

          // Telefone
          TextField(
            maxLength: 15,
            keyboardType: TextInputType.phone,
            style: TextStyle(fontSize: tamanhoFonte),
            decoration: const InputDecoration(
              labelText: 'Telefone',
              border: OutlineInputBorder(),
            ),
          ),

          const SizedBox(height: 10),

          // Email
          TextField(
            keyboardType: TextInputType.emailAddress,
            style: TextStyle(fontSize: tamanhoFonte),
            decoration: const InputDecoration(
              labelText: 'E-mail',
              border: OutlineInputBorder(),
            ),
          ),

          const SizedBox(height: 10),

          // Senha
          TextField(
            maxLength: 20,
            obscureText: !mostrarSenha,
            style: TextStyle(fontSize: tamanhoFonte),
            decoration: InputDecoration(
              labelText: 'Senha',
              border: const OutlineInputBorder(),
              suffixIcon: IconButton(
                icon: Icon(
                  mostrarSenha ? Icons.visibility : Icons.visibility_off,
                ),
                onPressed: () {
                  setState(() {
                    mostrarSenha = !mostrarSenha;
                  });
                },
              ),
            ),
          ),

          const SizedBox(height: 10),

          // Genero
          const Text("Gênero"),

          RadioListTile<Genero>(
            title: const Text("Masculino"),
            value: Genero.masculino,
            groupValue: generoSelecionado,
            onChanged: (value) {
              setState(() {
                generoSelecionado = value;
              });
            },
          ),

          RadioListTile<Genero>(
            title: const Text("Feminino"),
            value: Genero.feminino,
            groupValue: generoSelecionado,
            onChanged: (value) {
              setState(() {
                generoSelecionado = value;
              });
            },
          ),

          const SizedBox(height: 10),

          // Notificacoes
          const Text("Notificações"),

          SwitchListTile(
            title: const Text("E-mail"),
            value: notifEmail,
            onChanged: (value) {
              setState(() {
                notifEmail = value;
              });
            },
          ),

          SwitchListTile(
            title: const Text("Telefone"),
            value: notifTelefone,
            onChanged: (value) {
              setState(() {
                notifTelefone = value;
              });
            },
          ),

          const SizedBox(height: 10),

          // Slider
          const Text("Tamanho da fonte"),

          Slider(
            value: tamanhoFonte,
            min: 12,
            max: 24,
            divisions: 6,
            label: tamanhoFonte.toStringAsFixed(0),
            onChanged: (value) {
              setState(() {
                tamanhoFonte = value;
              });
            },
          ),

          const SizedBox(height: 20),

          // Botao
          ElevatedButton(
            onPressed: () {
              print("Cadastro realizado!");
            },
            child: const Text("Cadastrar"),
          ),
        ],
      ),
    );
  }
}