import 'package:flutter/material.dart';
import 'package:mobile_electronic_record_card/controller/user_controller.dart';
import 'package:mobile_electronic_record_card/model/entity/user_and_group_entity.dart';

class UserProvider extends ChangeNotifier {
  late Future<UserAndGroupEntity> _currentUser;

  Future<UserAndGroupEntity> get currentUser => _currentUser;

  void initCurrentUser(int userId) => _currentUser =
      UserController().getCurrentUserFromDb(userId);

  void fetchUsers() async => notifyListeners();
}
