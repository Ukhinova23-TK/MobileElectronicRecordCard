import 'package:flutter/material.dart';
import 'package:mobile_electronic_record_card/controller/user_subject_control_type_controller.dart';
import 'package:mobile_electronic_record_card/model/entity/user_subject_control_type_entity.dart';

class UserSubjectControlTypeProvider extends ChangeNotifier {
  Future<List<UserSubjectControlTypeEntity>>? _userSubjectsControlTypes;

  Future<List<UserSubjectControlTypeEntity>>? get userSubjectsControlTypes =>
      _userSubjectsControlTypes;

  void initUserSubjectsControlTypes(int controlTypeId) =>
      _userSubjectsControlTypes =
          UserSubjectControlTypeController().userSubjectControlTypes;

  void fetchControlTypes() async => notifyListeners();
}
