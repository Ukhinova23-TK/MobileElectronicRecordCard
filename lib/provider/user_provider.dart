import 'package:flutter/material.dart';
import 'package:mobile_electronic_record_card/controller/user_controller.dart';
import 'package:mobile_electronic_record_card/model/entity/user_entity.dart';

class UserProvider extends ChangeNotifier {
  late Future<List<UserEntity>>? _students;
  late Future<List<UserEntity>?> _teachers;

  Future<List<UserEntity>>? get students => _students;

  Future<List<UserEntity>?> get teachers => _teachers;

  void initStudents(int groupId, int subjectId) => _students =
      UserController().getStudentsByGroupAndSubjectFromDb(groupId, subjectId);

  void initTeachers() => _teachers = UserController().getTeachersFromDb();

  void fetchUsers() async => notifyListeners();
}
