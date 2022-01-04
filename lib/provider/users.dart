import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:user_registration/data/dummy_users.dart';
import 'package:user_registration/models/user.dart';

class Users with ChangeNotifier {
  final Map<String, User> _items = {...dummyUsers};

  List<User> get all {
    return [..._items.values];
  }

  int get count {
    return _items.length;
  }

  User byIndex(int i) {
    return _items.values.elementAt(i);
  }

  // add and alter
  void put(User user) {
    // ignore: unnecessary_null_comparison
    if (user == null) {
      return;
    }

    if (user.id != null &&
        user.id.trim().isNotEmpty &&
        _items.containsKey(user.id)) {
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
      final id = Random().nextDouble().toString();
      _items.putIfAbsent(
        id,
        () => User(
            id: id,
            cpf: user.cpf,
            userName: user.userName,
            mothersName: user.mothersName,
            birth: user.birth,
            gender: user.gender),
      );
    }
    notifyListeners();
  }
}
