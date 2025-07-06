import 'package:flutter/material.dart';
import 'Tela de calculo.dart';

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
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const WelcomeScreen(),
    );
  }
}

// Tela Inicial - Boas-vindas
class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.cyan,
      appBar: AppBar(
      backgroundColor: Colors.blue,

        title: const Text('Bem-vindo!'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Center(
              child: Text(
                'Bem-vindo à sua Calculadora de Sucessão Numérica!',
                style: TextStyle(fontSize: 24),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Navega para a tela de cálculo
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const CalculationScreen(),
                  ),
                );
              },
              child: const Text(
                'Iniciar Cálculo',
                 style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.blue,
                  fontSize: 15
                 )
              ),
            ),
          ],
        ),
      ),
    );
  }
}