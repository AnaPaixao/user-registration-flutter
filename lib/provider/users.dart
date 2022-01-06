// ignore_for_file: unnecessary_null_comparison
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:user_registration/data/dummy_users.dart';
import 'package:user_registration/models/user.dart';

class Users with ChangeNotifier {
  static const _baseUrl =
      "https://user-registration-a12e0-default-rtdb.firebaseio.com/";

  List<String> listStrings = <String>["Nenhum registro carregado."];

  final Map<String, User> _items = {...dummyUsers};

  List<User> get all {
    return [..._items.values];
  }

  int get count {
    return _items.length;
  }

  User byIndex(int i) {
    http.get((Uri.parse("$_baseUrl/users.json")));
    return _items.values.elementAt(i);
  }

  // add and alter
  Future<void> put(User user) async {
    if (user == null) {
      return;
    }

    if (user.id != null &&
        user.id.trim().isNotEmpty &&
        _items.containsKey(user.id)) {
      await http.patch(
        (Uri.parse("$_baseUrl/users/${user.id}.json")),
        body: json.encode({
          'cpf': user.cpf,
          'userName': user.userName,
          'mothersName': user.mothersName,
          'birth': user.birth,
          'gender': user.gender,
        }),
      );

      _items.update(
        user.id,
        (_) => User(
            id: user.id,
            cpf: user.cpf,
            userName: user.userName,
            mothersName: user.mothersName,
            birth: user.birth,
            gender: user.gender),
      );
    } else {
      final response = await http.post(
        (Uri.parse("$_baseUrl/users.json")),
        body: json.encode({
          'cpf': user.cpf,
          'userName': user.userName,
          'mothersName': user.mothersName,
          'birth': user.birth,
          'gender': user.gender,
        }),
      );

      final id = json.decode(response.body)['name'];

      // final id = Random().nextDouble().toString();

      _items.putIfAbsent(
        id,
        () => User(
          id: id,
          cpf: user.cpf,
          userName: user.userName,
          mothersName: user.mothersName,
          birth: user.birth,
          gender: user.gender,
        ),
      );
    }
    notifyListeners();
  }

  void remove(User user) async {
    await http.delete((Uri.parse("$_baseUrl/users/${user.id}.json")));
    if (user != null && user.id != null) {
      _items.remove(user.id);
      notifyListeners();
    }
  }

  Future<void> getAll() {
    return http.get((Uri.parse("$_baseUrl/users.json"))).then((response) {
      // Map<String, dynamic> map = json.decode(response.body);
      // listStrings = [];
      // map.forEach((key, value) {
      //   setState(() {
      //     listStrings.add(map[key]["user"]);
      //     print(listStrings);
      //   });
      // });
    });
  }
}
