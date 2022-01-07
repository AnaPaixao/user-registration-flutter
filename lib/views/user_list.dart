import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:user_registration/components/user_tile.dart';
import 'package:user_registration/provider/users.dart';
import 'package:user_registration/routes/app_routes.dart';

class UserList extends StatefulWidget {
  const UserList({Key? key}) : super(key: key);

  @override
  State<UserList> createState() => _UserListState();
}

class _UserListState extends State<UserList> {
  @override
  Widget build(BuildContext context) {
    final Users users = Provider.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Lista de Usuários'),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.brown,
              ),
              child: Text(
                'Cadastro de usuário',
                style: TextStyle(color: Colors.white, fontSize: 24),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.person_add),
              title: const Text('Novo Cadastro'),
              onTap: () {
                Navigator.of(context).pushNamed(AppRoutes.userForm);
                // Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.people),
              title: const Text('Lista de Cadastros'),
              onTap: () {
                Navigator.of(context).pushNamed(AppRoutes.home);
                // Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.folder),
              title: const Text('Firebase'),
              onTap: () {
                Navigator.of(context).pushNamed(AppRoutes.testeList);
                // Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
      body: ListView.builder(
          itemCount: users.count,
          itemBuilder: (ctx, i) => UserTile(users.byIndex(i))),
    );
  }
}
