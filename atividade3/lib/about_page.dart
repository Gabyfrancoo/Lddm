import 'package:flutter/material.dart';

/// AboutPage (StatelessWidget)
/// Scaffold + AppBar
class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Segunda Tela'),
      ),
      body: Container(
        color: const Color.fromARGB(255, 168, 38, 82),
        padding: const EdgeInsets.all(16),
        child: const Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Text(
              "VOCÊ ESTÁ NA SEGUNDA TELA!!",
              style: TextStyle(fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }
}