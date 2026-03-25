import 'package:flutter/material.dart';

/// enum para escolha unica
enum Genero { masculino, feminino }

/// Tela de Cadastro
class CadastroPage extends StatefulWidget {
  const CadastroPage({super.key});

  @override
  State<CadastroPage> createState() => _CadastroPageState();
}

class _CadastroPageState extends State<CadastroPage> {
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
        title: const Text('Cadastro'),
      ),
      drawer: const Drawer(),
      body: conteudo(),
    );
  }

  Widget conteudo() {
    Icon iconeVisibilidade;

    if (mostrarSenha == true) {
      iconeVisibilidade = const Icon(Icons.visibility);
    } else {
      iconeVisibilidade = const Icon(Icons.visibility_off);
    }

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
                icon: iconeVisibilidade,
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
              // ignore: avoid_print
              print("Cadastro realizado!");
            },
            child: const Text("Cadastrar"),
          ),
        ],
      ),
    );
  }
}