import 'package:flutter/material.dart';
import 'package:mobile_electronic_record_card/controller/user_subject_control_type_controller.dart';
import 'package:mobile_electronic_record_card/model/entity/teacher_subject_control_type_mark_semester_entity.dart';

class UserSubjectControlTypeProvider extends ChangeNotifier {
  Future<List<TeacherSubjectControlTypeMarkSemesterEntity>>? _userSubjectsControlTypes;

  Future<List<TeacherSubjectControlTypeMarkSemesterEntity>>? get userSubjectsControlTypes =>
      _userSubjectsControlTypes;

  void initUserSubjectsControlTypes(int userId) =>
      _userSubjectsControlTypes =
          UserSubjectControlTypeController().getByStudentFromDb(userId);

  void fetchControlTypes() async => notifyListeners();
}
