import 'package:flutter/material.dart';
import 'package:mobile_electronic_record_card/controller/student_mark_controller.dart';
import 'package:mobile_electronic_record_card/model/entity/student_and_mark_entity.dart';

class StudentMarkProvider extends ChangeNotifier {
  late Future<List<StudentAndMarkEntity>> _studentMarks;

  Future<List<StudentAndMarkEntity>> get studentMarks => _studentMarks;

  void initStudentMark(int groupId, int subjectId) => _studentMarks =
      StudentMarkController().getByGroupAndSubjectFromDb(groupId, subjectId);

  void fetchStudentMark() async => notifyListeners();
}
