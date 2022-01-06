import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:user_registration/provider/users.dart';
import 'package:user_registration/routes/app_routes.dart';
import 'package:user_registration/views/user_form.dart';
import 'package:user_registration/views/user_list.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (ctc) => Users(),
      child: MaterialApp(
        title: 'Flutter Main',
        theme: ThemeData(
          // This is the theme of your application.
          //
          // Try running your application with "flutter run". You'll see the
          // application has a blue toolbar. Then, without quitting the app, try
          // changing the primarySwatch below to Colors.green and then invoke
          // "hot reload" (press "r" in the console where you ran "flutter run",
          // or simply save your changes to "hot reload" in a Flutter IDE).
          // Notice that the counter didn't reset back to zero; the application
          // is not restarted.
          primarySwatch: Colors.brown,
        ),
        routes: {
          AppRoutes.home: (_) => const UserList(),
          AppRoutes.userForm: (_) => UserForm()
        },
      ),
    );
  }
}
