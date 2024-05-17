import 'package:flutter/material.dart';
import 'package:mobile_electronic_record_card/controller/group_controller.dart';
import 'package:mobile_electronic_record_card/model/entity/group_entity.dart';

class GroupProvider extends ChangeNotifier {
  Future<List<GroupEntity>>? _groups;

  Future<List<GroupEntity>>? get groups => _groups;

  void initGroups(int subjectId) =>
      _groups = GroupController().getBySubject(subjectId);

  void fetchGroups() async => notifyListeners();
}
