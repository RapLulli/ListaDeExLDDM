import 'package:exercicioslddm/Exercicios%202/cadastro.dart';
import 'package:exercicioslddm/Exercicios%203-4-5/menu.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';

class TelaDeLogin extends StatefulWidget {
  const TelaDeLogin({super.key});
  @override
  // ignore: library_private_types_in_public_api
  _TelaDeLoginState createState() => _TelaDeLoginState();
}

class _TelaDeLoginState extends State<TelaDeLogin> {
  bool _lembreDeMim = false;
  bool _mostrarSenha = false;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _senhaController = TextEditingController();

  void _tornarSenhaVisivel() {
    setState(() {
      _mostrarSenha = !_mostrarSenha;
    });
  }

  void _vaiParaCadastro() {
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return const TelaDeCadastro();
    }));
  }

  Future<bool> _loginPreferencias() async {
    final String email = _emailController.text.trim();
    final String senha = _senhaController.text.trim();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? registeredEmail = prefs.getString('email');
    final String? registeredSenha = prefs.getString('senha');

    return email == registeredEmail && senha == registeredSenha;
  }

  Future<void> _login() async {
    if (await _loginPreferencias()) {
      // ignore: use_build_context_synchronously
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Dados Invalidos!'),
            content: const Text('Email ou senha incorreta!'),
            actions: [
              TextButton(
                child: const Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    } else {
      // ignore: use_build_context_synchronously
      Navigator.push(context, MaterialPageRoute(builder: (context) {
        return const TelaMenuNavegacaoInferior();
      }));
    }
  }

  @override
  Widget build(BuildContext context) {
    _emailController.text = "";
    _senhaController.text = "";

    return Scaffold(
      appBar: AppBar(
        title: const Text("Login"),
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/imagemLogin.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                keyboardType: TextInputType.emailAddress,
                controller: _emailController,
                decoration: InputDecoration(
                  hintText: "Digite seu e-mail",
                  filled: true,
                  fillColor: Colors.white.withOpacity(0.8),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
              ),
              const SizedBox(height: 8.0),
              TextField(
                obscureText: !_mostrarSenha,
                controller: _senhaController,
                decoration: InputDecoration(
                  hintText: "Digite sua senha",
                  filled: true,
                  fillColor: Colors.white.withOpacity(0.8),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  suffixIcon: IconButton(
                    icon: Icon(_mostrarSenha
                        ? Icons.visibility_off
                        : Icons.visibility),
                    onPressed: _tornarSenhaVisivel,
                  ),
                ),
              ),
              const SizedBox(height: 12.0),
              Row(
                children: [
                  Checkbox(
                    value: _lembreDeMim,
                    onChanged: (bool? value) {
                      setState(() {
                        _lembreDeMim = value!;
                      });
                    },
                  ),
                  const Text(
                    'Lembrar dados do usuário',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24.0),
              SizedBox(
                width: double.infinity,
                height: 40,
                child: FractionallySizedBox(
                  widthFactor: 0.3,
                  child: ElevatedButton(
                    onPressed: () async {
                      _login();
                    },
                    child: const Text(
                      "Entrar",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 12.0),
              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Novo aqui?",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 13,
                      ),
                    ),
                    TextButton(
                      onPressed: _vaiParaCadastro,
                      child: const Text(
                        "Criar uma conta",
                        style: TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.bold,
                          fontSize: 13,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
