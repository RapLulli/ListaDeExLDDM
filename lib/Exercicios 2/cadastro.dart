import 'package:exercicioslddm/Exercicios%201-3/login.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TelaDeCadastro extends StatefulWidget {
  const TelaDeCadastro({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _TelaDeCadastroState createState() => _TelaDeCadastroState();
}

class _TelaDeCadastroState extends State<TelaDeCadastro> {
  bool _generoSelecionado = false;
  bool _mostrarSenha = false;
  bool _notificarCelular = false;
  bool _notificarEmail = false;
  double _tamanhoFonte = 16.0;
  final TextEditingController _telefoneController = TextEditingController();
  final TextEditingController _nomeController = TextEditingController();
  final TextEditingController _senhaController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _dataNascimentoController =
      TextEditingController();

  @override
  void dispose() {
    _dataNascimentoController.dispose();
    _senhaController.dispose();
    _telefoneController.dispose();
    _nomeController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  void _registrarPreferencias() async {
    final String telefone = _telefoneController.text.trim();
    final String email = _emailController.text.trim();
    final String dataNas = _dataNascimentoController.text.trim();
    final String senha = _senhaController.text.trim();
    final String nome = _nomeController.text.trim();

    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('nome', nome);
    await prefs.setString('dataNas', dataNas);
    await prefs.setString('telefone', telefone);
    await prefs.setString('email', email);
    await prefs.setString('senha', senha);

    // ignore: use_build_context_synchronously
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return const TelaDeLogin();
    }));
  }

  void _selecaoGenero(bool value) {
    setState(() {
      _generoSelecionado = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Cadastro"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextField(
                decoration: InputDecoration(
                    labelText: "Nome",
                    labelStyle: TextStyle(fontSize: _tamanhoFonte)),
                style: TextStyle(fontSize: _tamanhoFonte),
                maxLength: 50,
              ),
              const SizedBox(height: 12.0),
              TextField(
                decoration: InputDecoration(
                    labelText: "Data de Nascimento",
                    labelStyle: TextStyle(fontSize: _tamanhoFonte)),
                style: TextStyle(fontSize: _tamanhoFonte),
                keyboardType: TextInputType.datetime,
              ),
              const SizedBox(height: 12.0),
              TextField(
                decoration: InputDecoration(
                    labelText: "Telefone",
                    labelStyle: TextStyle(fontSize: _tamanhoFonte)),
                style: TextStyle(fontSize: _tamanhoFonte),
                keyboardType: TextInputType.phone,
                maxLength: 15,
              ),
              const SizedBox(height: 12.0),
              TextField(
                decoration: InputDecoration(
                    labelText: "E-Mail",
                    labelStyle: TextStyle(fontSize: _tamanhoFonte)),
                style: TextStyle(fontSize: _tamanhoFonte),
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(height: 12.0),
              TextField(
                obscureText: !_mostrarSenha,
                style: TextStyle(fontSize: _tamanhoFonte),
                decoration: InputDecoration(
                  labelText: "Senha",
                  labelStyle: TextStyle(fontSize: _tamanhoFonte),
                  suffixIcon: IconButton(
                    icon: Icon(_mostrarSenha
                        ? Icons.visibility_off
                        : Icons.visibility),
                    onPressed: () {
                      setState(() {
                        _mostrarSenha = !_mostrarSenha;
                      });
                    },
                  ),
                ),
              ),
              const SizedBox(height: 12.0),
              CheckboxListTile(
                title: const Text('Male'),
                value: _generoSelecionado,
                onChanged: (value) => _selecaoGenero(true),
              ),
              CheckboxListTile(
                title: const Text('Female'),
                value: !_generoSelecionado,
                onChanged: (value) => _selecaoGenero(false),
              ),
              const SizedBox(height: 12.0),
              Row(
                children: [
                  Switch(
                    value: _notificarEmail,
                    onChanged: (bool value) {
                      setState(() {
                        _notificarEmail = value;
                      });
                    },
                  ),
                  const Text("Notificações via E-mail"),
                ],
              ),
              const SizedBox(height: 12.0),
              Row(
                children: [
                  Switch(
                    value: _notificarCelular,
                    onChanged: (bool value) {
                      setState(() {
                        _notificarCelular = value;
                      });
                    },
                  ),
                  const Text("Notificações via Telefone"),
                ],
              ),
              const SizedBox(height: 24.0),
              ElevatedButton(
                onPressed: () async {
                  _registrarPreferencias();
                },
                child: const Text("Cadastrar"),
              ),
              const SizedBox(height: 12.0),
              Slider(
                label: _tamanhoFonte.round().toString(),
                divisions: 12,
                value: _tamanhoFonte,
                min: 12.0,
                max: 24.0,
                onChanged: (value) {
                  setState(() {
                    _tamanhoFonte = value;
                  });
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
