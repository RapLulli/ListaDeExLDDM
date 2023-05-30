import 'package:exercicioslddm/Exercicios%204-5/lista.dart';
import 'package:flutter/material.dart';

class TelaMenuNavegacaoInferior extends StatefulWidget {
  const TelaMenuNavegacaoInferior({super.key});
  @override
  // ignore: library_private_types_in_public_api
  _TelaMenuNavegacaoInferiorState createState() =>
      _TelaMenuNavegacaoInferiorState();
}

class _TelaMenuNavegacaoInferiorState extends State<TelaMenuNavegacaoInferior> {
  int _indice = 0;

  void _selecionaIndice(int value) {
    setState(() {
      _indice = value;
    });
  }

  Widget _gerarPagina(int index) {
    switch (index) {
      case 0:
        return const Noticias();

      case 1:
        return TelaDeLista();

      case 2:
        return const Perfil();

      default:
        return const Noticias();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Menu'),
      ),
      body: Center(
        child: _gerarPagina(_indice),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.newspaper),
            label: 'Notícias',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            label: 'Lista',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Perfil',
          ),
        ],
        currentIndex: _indice,
        onTap: _selecionaIndice,
      ),
    );
  }
}

class Noticias extends StatelessWidget {
  const Noticias({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('Notícias'),
    );
  }
}

class Perfil extends StatelessWidget {
  const Perfil({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('Perfil'),
    );
  }
}
