// ignore_for_file: use_key_in_widget_constructors, deprecated_member_use
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:user_registration/models/user.dart';
import 'package:user_registration/provider/users.dart';
import 'package:user_registration/routes/app_routes.dart';

class UserTile extends StatefulWidget {
  final User user;

  const UserTile(this.user);

  @override
  State<UserTile> createState() => _UserTileState();
}

class _UserTileState extends State<UserTile> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
        title: Text(widget.user.userName),
        subtitle: Text("CPF: " + widget.user.cpf),
        trailing: SizedBox(
          width: 100,
          child: Row(
            children: <Widget>[
              IconButton(
                icon: const Icon(Icons.edit),
                color: Colors.green,
                onPressed: () {
                  Navigator.of(context).pushNamed(
                    AppRoutes.userForm,
                    arguments: widget.user,
                  );
                },
              ),
              IconButton(
                icon: const Icon(Icons.delete),
                color: Colors.red,
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (ctx) => AlertDialog(
                      title: const Text('Excluir Usuário'),
                      content: const Text('Tem certeza?'),
                      actions: <Widget>[
                        FlatButton(
                          child: const Text('Não'),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                        FlatButton(
                          child: const Text('Sim'),
                          onPressed: () {
                            Provider.of<Users>(context, listen: false)
                                .remove(widget.user);
                            Navigator.of(context).pop();
                          },
                        ),
                      ],
                    ),
                  );
                },
              ),
            ],
          ),
        ));
  }
}
