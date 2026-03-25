import 'package:flutter/material.dart';
import 'about_page.dart';
import 'home_page.dart';

/// MainPage (StatefulWidget) com BottomNavigationBar 
class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const Drawer(),
      appBar: AppBar(
        title: const Text('Login'),
      ),

      // HomePage (Login)
      body: const HomePage(),

      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_balance),
            label: 'About',
          ),
        ],
        onTap: (index) async {
          // Se clicar na Home, só marca a aba
          if (index == 0) {
            setState(() {
              _currentIndex = 0;
            });
            return;
          }

          // Se clicar na About, abre uma nova tela com Navigator
          setState(() {
            _currentIndex = 1;
          });

          await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const AboutPage(),
            ),
          );

          // Quando voltar (pop), seleciona Home de novo
          setState(() {
            _currentIndex = 0;
          });
        },
      ),
    );
  }
}