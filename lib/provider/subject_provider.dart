import 'package:flutter/material.dart';
import 'package:mobile_electronic_record_card/controller/subject_controller.dart';
import 'package:mobile_electronic_record_card/model/entity/subject_entity.dart';

class SubjectProvider extends ChangeNotifier {
  Future<List<SubjectEntity>>? _subjects;

  Future<List<SubjectEntity>>? get subjects => _subjects;

  void initSubjects(int userId) =>
      _subjects = SubjectController().getByTeacher(userId);

  void fetchSubjects() async => notifyListeners();
}
