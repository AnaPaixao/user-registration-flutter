import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:user_registration/models/user.dart';
import 'package:user_registration/provider/users.dart';

class UserForm extends StatelessWidget {
  // const UserForm({Key? key}) : super(key: key);

  final _form = GlobalKey<FormState>();
  final Map<String, String> _formData = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cadastro de Usuário'),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.save),
            onPressed: () {
              final isValid = _form.currentState!.validate();

              if (isValid) {
                _form.currentState?.save();

                Provider.of<Users>(context, listen: false).put(
                  User(
                    id: _formData['id'],
                    cpf: _formData['cpf']!,
                    userName: _formData['userName']!,
                    mothersName: _formData['mothersName']!,
                    birth: _formData['birth']!,
                    gender: _formData['gender']!,
                  ),
                );

                Navigator.of(context).pop();
              }
            },
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Form(
          key: _form,
          child: Column(
            children: <Widget>[
              TextFormField(
                decoration: const InputDecoration(labelText: 'CPF'),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Campo Obrigatório';
                  }

                  if (value.trim().length < 11 || value.trim().length > 11) {
                    return 'CPF Inválido';
                  }

                  return null;
                },
                onSaved: (value) => _formData['cpf'] = value!,
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Nome'),
                onSaved: (value) => _formData['userName'] = value!,
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Nome da Mãe'),
                onSaved: (value) => _formData['mothersName'] = value!,
              ),
              TextFormField(
                decoration:
                    const InputDecoration(labelText: 'Data de Nascimento'),
                onSaved: (value) => _formData['birth'] = value!,
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Gênero'),
                onSaved: (value) => _formData['gender'] = value!,
              )
            ],
          ),
        ),
      ),
    );
  }
}
