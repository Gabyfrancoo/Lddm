import 'package:flutter/material.dart';
import 'package:local_auth/local_auth.dart'; 

void main() {
  runApp(const MeuApp());
}

class MeuApp extends StatelessWidget {
  const MeuApp({super.key});
 
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false, 
      home: TelaPrincipal(), 
    );
  }
}

class TelaPrincipal extends StatefulWidget {
  const TelaPrincipal({super.key});

  @override
  State<TelaPrincipal> createState() => _TelaPrincipalState();
}

class _TelaPrincipalState extends State<TelaPrincipal> {
  final LocalAuthentication autenticador = LocalAuthentication();
  
  bool acessoLiberado = false;

  Future<void> verificarBiometria() async {
    bool deuCerto = false;

    try {
      deuCerto = await autenticador.authenticate(
        localizedReason: 'Por favor, coloque o dedo no sensor',
      );
    } catch (erro) {
      print("Ops, deu erro: $erro");
    }

    setState(() {
      acessoLiberado = deuCerto; 
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("App de Biometria"),
      ),
      body: Center( 
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center, 
          children: [
            Icon(
              acessoLiberado == true ? Icons.lock_open : Icons.lock,
              color: acessoLiberado == true ? Colors.green : Colors.red,
              size: 100,
            ),
            const SizedBox(height: 20), 
            Text(
              acessoLiberado == true ? "Acesso Liberado!" : "Acesso Restrito",
              style: TextStyle(
                fontSize: 25,
                color: acessoLiberado == true ? Colors.green : Colors.red,
              ),
            ),
            const SizedBox(height: 40), 
            ElevatedButton(
              onPressed: verificarBiometria, 
              child: const Text("Acessar Conta"),
            ),
          ],
        ),
      ),
    );
  }
}