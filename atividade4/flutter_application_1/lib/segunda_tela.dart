import 'package:flutter/material.dart';

class SegundaTela extends StatefulWidget {
  const SegundaTela({super.key});

  @override
  State<SegundaTela> createState() => _SegundaTelaState();
}

class _SegundaTelaState extends State<SegundaTela> {
  List _itens = [];

  void _carregarItens() {
    _itens = [];
    for (int i = 0; i < 20; i++) {
      _itens.add({
        "titulo": "Título $i da lista",
        "descricao": "Descrição $i da lista",
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _carregarItens();
  }

  @override
  Widget build(BuildContext context) {
    // argumento enviado pela PrimeiraTela
    final args = ModalRoute.of(context)?.settings.arguments;

    final String nome = (args is String && args.trim().isNotEmpty)
        ? args.trim()
        : "Usuário";

    return Scaffold(
      appBar: AppBar(
        title: Text("Bem vindo(a), $nome"),
      ),
      body: Container(
        padding: const EdgeInsets.all(20),
        child: ListView.builder(
          itemCount: _itens.length,
          itemBuilder: (context, indice) {
            return ListTile(
              onTap: () {
                print("Clique com onTap $indice");

                // AlertDialog com título 
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: const Text("Alerta"),
                    content: Text("Você clicou no item $indice"),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: const Text("Sim"),
                      ),
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: const Text("Não"),
                      ),
                    ],
                  ),
                );
              },
              onLongPress: () {
                print("Clique com onLongPress $indice");
              },
              title: Text(_itens[indice]["titulo"]),
              subtitle: Text(_itens[indice]["descricao"]),
            );
          },
        ),
      ),
    );
  }
}