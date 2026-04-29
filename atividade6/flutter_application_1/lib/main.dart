import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Home(),
    );
  }
}

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  // Método para recuperar ou abrir o banco de dados
  _recuperarBD() async {
    // Obtém o caminho onde o banco de dados será salvo no dispositivo
    final caminho = await getDatabasesPath();
    final local = join(caminho, "bancodados.db");

    // Abre o banco de dados e cria a tabela 'usuarios' se ainda não existir
    var retorno = await openDatabase(
      local,
      version: 1,
      onCreate: (db, dbVersaoRecente) {
        // SQL para criar a tabela 'usuarios' com colunas de ID, nome e idade
        String sql = "CREATE TABLE usuarios ("
            "matricula TEXT PRIMARY KEY , "
            "nome TEXT, curso TEXT)";
        db.execute(sql);
      },
    );

    print("Aberto ${retorno.isOpen.toString()}");

    return retorno;
  }

  // Método para inserir um novo usuário no banco de dados
  _salvarDados(BuildContext context, String matricula, String nome, String curso) async {
    Database db = await _recuperarBD();

    // Dados a serem inseridos, representados como um mapa
    Map<String, dynamic> dadosUsuario = {
      "matricula": matricula,
      "nome": nome,
      "curso": curso,
    };

    // Insere os dados na tabela 'usuarios' e retorna o ID do novo registro
    //int id = await db.insert("usuarios", dadosUsuario);
    await db.insert("usuarios", dadosUsuario);
    //print("Salvo $id");

    // Exibe um diálogo para o usuário confirmar que o registro foi salvo
    _mostrarDialogo(context, "Usuário salvo com sucesso!");
  }

  // Método para exibir diálogos de confirmação e mensagens
  _mostrarDialogo(BuildContext context, String mensagem) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Resultado"),
          content: Text(mensagem),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text("OK"),
            ),
          ],
        );
      },
    );
  }

  // Método para listar todos os usuários armazenados no banco de dados
  _listarUsuarios() async {
    Database db = await _recuperarBD();
    String sql = "SELECT * FROM usuarios";
    List usuarios = await db.rawQuery(sql);

    // Imprime os dados de cada usuário listado no banco
    for (var usu in usuarios) {
      print(
          " matricula: ${usu['matricula'].toString()} nome: ${usu['nome']} curso: ${usu['curso']}");
    }
  }

  // Método para listar um usuário específico com base no ID
  _listarUmUsuario(BuildContext context, String matricula) async {
    Database db = await _recuperarBD();

    // Faz a consulta na tabela 'usuarios' com o ID fornecido
    List usuarios = await db.query(
      "usuarios",
      columns: ["matricula", "nome", "curso"],
      where: "matricula = ?",
      whereArgs: [matricula],
    );

    // Verifica se o usuário existe e exibe um diálogo com as informações
    if (usuarios.isNotEmpty) {
      var usuario = usuarios.first;
      _mostrarDialogo(context,
          "Matrícula: ${usuario['matricula']} \nNome: ${usuario['nome']} \nCurso: ${usuario['curso']}");
    } else {
      _mostrarDialogo(context, "Usuário com matricula $matricula não encontrado.");
    }
  }

  // Método para excluir um usuário com base no ID
  _excluirUsuario(BuildContext context, String matricula) async {
    Database db = await _recuperarBD();

    // Exclui o registro de acordo com o ID fornecido
    int retorno = await db.delete(
      "usuarios",
      where: "matricula = ?",
      whereArgs: [matricula],
    );

    print("Itens excluídos: $retorno");

    // Exibe um diálogo para confirmar a exclusão
    _mostrarDialogo(context, "Usuário com matrícula $matricula excluído com sucesso.");
  }

  // Método para atualizar informações de um usuário existente
  _atualizarUsuario(
      BuildContext context, String matricula ,String? nome, String? curso) async {
    Database db = await _recuperarBD();

    // Cria um mapa para atualizar os dados somente dos campos não nulos
    Map<String, dynamic> dadosUsuario = {};
    if (nome != null && nome.isNotEmpty) {
      dadosUsuario["nome"] = nome;
    }
    if (curso != null && curso.isNotEmpty) {
      dadosUsuario["curso"] = curso;
    }

    // Realiza a atualização caso existam campos para modificar
    if (dadosUsuario.isNotEmpty) {
      int retorno = await db.update(
        "usuarios",
        dadosUsuario,
        where: "matricula = ?",
        whereArgs: [matricula],
      );

      print("Itens atualizados: $retorno");
      _mostrarDialogo(context, "Usuário com matrícula $matricula atualizado com sucesso.");
    } else {
      _mostrarDialogo(context, "Nenhuma informação para atualizar.");
    }
  }


final TextEditingController _matriculaController = TextEditingController();
final TextEditingController _nomeController = TextEditingController();
final TextEditingController _cursoController = TextEditingController();
final TextEditingController _matriculaBuscaController = TextEditingController();

@override
Widget build(BuildContext context) {
  return Scaffold(
    body: Container(
      alignment: Alignment.center,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // MATRÍCULA
          Container(
            width: 300,
            child: TextField(
              controller: _matriculaController,
              decoration: const InputDecoration(
                label: Text("Digite a matrícula:"),
              ),
            ),
          ),

          const SizedBox(height: 10),

          // NOME
          Container(
            width: 300,
            child: TextField(
              controller: _nomeController,
              decoration: const InputDecoration(
                label: Text("Digite o nome:"),
              ),
            ),
          ),

          const SizedBox(height: 10),

          // CURSO
          Container(
            width: 300,
            child: TextField(
              controller: _cursoController,
              decoration: const InputDecoration(
                label: Text("Digite o curso:"),
              ),
            ),
          ),

          const SizedBox(height: 10),

          // BOTÃO SALVAR
          ElevatedButton(
            onPressed: () {
              _salvarDados(
                context,
                _matriculaController.text,
                _nomeController.text,
                _cursoController.text,
              );
            },
            child: const Text("Salvar um usuário"),
          ),

          const SizedBox(height: 10),

          ElevatedButton(
            onPressed: _listarUsuarios,
            child: const Text("Listar todos usuários"),
          ),

          const SizedBox(height: 10),

          // CAMPO DE BUSCA (matrícula)
          Container(
            width: 300,
            child: TextField(
              controller: _matriculaBuscaController,
              decoration: const InputDecoration(
                label: Text("Digite a matrícula para buscar/excluir/atualizar:"),
              ),
            ),
          ),

          const SizedBox(height: 10),

          // LISTAR UM
          ElevatedButton(
            onPressed: () {
              String matricula = _matriculaBuscaController.text;

              if (matricula.isNotEmpty) {
                _listarUmUsuario(context, matricula);
              } else {
                _mostrarDialogo(context, "Digite uma matrícula válida.");
              }
            },
            child: const Text("Listar um usuário"),
          ),

          const SizedBox(height: 10),

          // EXCLUIR
          ElevatedButton(
            onPressed: () {
              String matricula = _matriculaBuscaController.text;

              if (matricula.isNotEmpty) {
                _excluirUsuario(context, matricula);
              } else {
                _mostrarDialogo(context, "Digite uma matrícula válida.");
              }
            },
            child: const Text("Excluir usuário"),
          ),

          const SizedBox(height: 10),

          // ATUALIZAR
          ElevatedButton(
            onPressed: () {
              String matricula = _matriculaBuscaController.text;

              if (matricula.isNotEmpty) {
                String? nome = _nomeController.text.isNotEmpty
                    ? _nomeController.text
                    : null;

                String? curso = _cursoController.text.isNotEmpty
                    ? _cursoController.text
                    : null;

                _atualizarUsuario(context, matricula, nome, curso);
              } else {
                _mostrarDialogo(context, "Digite uma matrícula válida.");
              }
            },
            child: const Text("Atualizar usuário"),
          ),
        ],
      ),
    ),
  );
}
}