import 'dart:async';
import 'package:uuid/uuid.dart';
import 'package:flutter_bloc_dio/src/model/static_models/user_static_model.dart';

class UserRepository {
  User? _user;

  Future<User?> getUser() async {
    if (_user != null) return _user;
    return Future.delayed(
      const Duration(milliseconds: 300),
      () => _user = User(const Uuid().v4()),
    );
  }
}
