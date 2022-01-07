import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:user_registration/models/user.dart';
import 'package:user_registration/provider/users.dart';

class UserForm extends StatefulWidget {
  const UserForm({Key? key}) : super(key: key);

  @override
  State<UserForm> createState() => _UserFormState();
}

class _UserFormState extends State<UserForm> {
  final _form = GlobalKey<FormState>();
  bool _isLoading = false;

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

  String radioBtnValue = "n";

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
            onPressed: () async {
              final isValid = _form.currentState!.validate();

              if (isValid) {
                _form.currentState?.save();

                setState(() {
                  _isLoading = true;
                });

                await Provider.of<Users>(context, listen: false).put(
                  User(
                    id: _formData['id'],
                    cpf: _formData['cpf']!,
                    userName: _formData['userName']!,
                    mothersName: _formData['mothersName']!,
                    birth: _formData['birth']!,
                    gender: _formData['gender']!,
                  ),
                );

                setState(() {
                  _isLoading = false;
                });

                Navigator.of(context).pop();
              }
            },
          )
        ],
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(15),
              child: Form(
                key: _form,
                child: Column(
                  children: <Widget>[
                    TextFormField(
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                        CpfInputFormatter(),
                      ],
                      initialValue: _formData['cpf'],
                      decoration: const InputDecoration(labelText: 'CPF'),
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Campo Obrigatório';
                        }

                        return null;
                      },
                      onSaved: (value) => _formData['cpf'] = value!,
                    ),
                    TextFormField(
                      initialValue: _formData['userName'],
                      decoration: const InputDecoration(labelText: 'Nome'),
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Campo Obrigatório';
                        }

                        if (value.length < 3) {
                          return 'Mínino 3 letras';
                        }

                        return null;
                      },
                      onSaved: (value) => _formData['userName'] = value!,
                    ),
                    TextFormField(
                      initialValue: _formData['mothersName'],
                      decoration:
                          const InputDecoration(labelText: 'Nome da Mãe'),
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Campo Obrigatório';
                        }

                        if (value.length < 3) {
                          return 'Mínino 3 letras';
                        }

                        return null;
                      },
                      onSaved: (value) => _formData['mothersName'] = value!,
                    ),
                    TextFormField(
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                        DataInputFormatter(),
                      ],
                      initialValue: _formData['birth'],
                      decoration: const InputDecoration(
                          labelText: 'Data de Nascimento'),
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Campo Obrigatório';
                        }

                        return null;
                      },
                      onSaved: (value) => _formData['birth'] = value!,
                    ),
                    TextFormField(
                      initialValue: _formData['gender'],
                      decoration: const InputDecoration(labelText: 'Gênero'),
                      onSaved: (value) => _formData['gender'] = radioBtnValue,
                    ),
                    RadioListTile(
                      title: const Text("Feminino"),
                      value: "feminino",
                      groupValue: radioBtnValue,
                      onChanged: (_) {
                        setState(() {
                          radioBtnValue = "feminino";
                        });
                      },
                    ),
                    RadioListTile(
                        title: const Text("Masculino"),
                        value: "masculino",
                        groupValue: radioBtnValue,
                        onChanged: (_) {
                          setState(() {
                            radioBtnValue = "masculino";
                          });
                        }),
                    RadioListTile(
                        title: const Text("Outros"),
                        value: "outros",
                        groupValue: radioBtnValue,
                        onChanged: (_) {
                          setState(() {
                            radioBtnValue = "outros";
                          });
                        }),
                  ],
                ),
              ),
            ),
    );
  }
}

class MaskTextInputFormatter {}
