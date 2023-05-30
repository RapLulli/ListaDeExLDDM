import 'package:exercicioslddm/Exercicios%201-3/login.dart';
import 'package:exercicioslddm/Exercicios%202/cadastro.dart';
import 'package:exercicioslddm/Exercicios%203-4-5/menu.dart';
import 'package:flutter/material.dart';

void main() => runApp(const CaminhosEx());

class CaminhosEx extends StatelessWidget {
  const CaminhosEx({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      routes: {
        '/': (context) => const PaginaInicial(),
        '/ex1': (context) => const TelaDeLogin(),
        '/ex2': (context) => const TelaDeCadastro(),
        '/ex3': (context) => const TelaMenuNavegacaoInferior()
      },
      theme: ThemeData(
        primarySwatch: Colors.deepOrange,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
    );
  }
}

class PaginaInicial extends StatelessWidget {
  const PaginaInicial({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Escolha de Exercício'),
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/imagemMain.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/ex1');
                },
                child: const Text('Tela De Login (Ex: 1, 3-parte)'),
              ),
              const SizedBox(height: 20.0),
              ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/ex2');
                },
                child: const Text('Tela De Cadastro (Ex: 2)'),
              ),
              const SizedBox(height: 20.0),
              ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/ex3');
                },
                child: const Text('Tela Menu (Ex: 3-parte, 4, 5)'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
