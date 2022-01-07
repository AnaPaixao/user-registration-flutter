// ignore_for_file: use_key_in_widget_constructors, deprecated_member_use
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class TesteList extends StatefulWidget {
  @override
  State<TesteList> createState() => _TesteListState();
}

class _TesteListState extends State<TesteList> {
  List<String> userList = ["Nenhum registro carregado"];

  static const _baseUrl =
      "https://user-registration-a12e0-default-rtdb.firebaseio.com/";

  Future<void> getAll() {
    return http.get(Uri.parse("$_baseUrl/users.json")).then((response) {
      Map<String, dynamic> map = json.decode(response.body);
      userList = [];
      map.forEach((key, value) {
        setState(() {
          userList.add(map[key]["cpf"]);
          userList.add(map[key]["userName"]);
          userList.add(map[key]["mothersName"]);
          userList.add(map[key]["birth"]);
          userList.add(map[key]["gender"]);
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lista do Firebase'),
      ),
      body: Container(
        padding: const EdgeInsets.all(30),
        child: Center(
          child: RefreshIndicator(
            onRefresh: () => getAll(),
            child: ListView(
              padding: const EdgeInsets.all(9),
              children: <Widget>[
                for (String s in userList) Text(s),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
