import 'package:mobile_electronic_record_card/controller/subject_controller.dart';
import 'package:mobile_electronic_record_card/model/entity/subject_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

class SubjectProvider extends ChangeNotifier {
  Future<List<SubjectEntity>>? _subjects;

  void initSubjects() => _subjects =
      SubjectController().subjects;

  void fetchSubjects() async =>
      notifyListeners();

  Future<List<SubjectEntity>>? get subjects => _subjects;
}
