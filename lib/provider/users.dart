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
}
