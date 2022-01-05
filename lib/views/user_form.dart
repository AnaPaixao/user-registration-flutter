import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:user_registration/models/user.dart';
import 'package:user_registration/provider/users.dart';

class UserForm extends StatefulWidget {
  @override
  State<UserForm> createState() => _UserFormState();
}

class _UserFormState extends State<UserForm> {
  // const UserForm({Key? key}) : super(key: key);
  final _form = GlobalKey<FormState>();

  final Map<String, String> _formData = {};

  void _loadFormData(User user) {
    // ignore: unnecessary_null_comparison
    if (user != null) {
      _formData['id'] = user.id;
      _formData['cpf'] = user.cpf;
      _formData['userName'] = user.userName;
      _formData['mothersName'] = user.mothersName;
      _formData['birth'] = user.birth;
      _formData['gender'] = user.gender;
    }
  }

  @override
  void didChangeDependencies() {
    // ignore: todo
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();

    //get user
    final args = ModalRoute.of(context)!.settings.arguments;

    if (args != null) {
      final user = ModalRoute.of(context)?.settings.arguments as User;
      _loadFormData(user);
    }
  }

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
                initialValue: _formData['cpf'],
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
                initialValue: _formData['userName'],
                decoration: const InputDecoration(labelText: 'Nome'),
                onSaved: (value) => _formData['userName'] = value!,
              ),
              TextFormField(
                initialValue: _formData['mothersName'],
                decoration: const InputDecoration(labelText: 'Nome da Mãe'),
                onSaved: (value) => _formData['mothersName'] = value!,
              ),
              TextFormField(
                initialValue: _formData['birth'],
                decoration:
                    const InputDecoration(labelText: 'Data de Nascimento'),
                onSaved: (value) => _formData['birth'] = value!,
              ),
              TextFormField(
                initialValue: _formData['gender'],
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
