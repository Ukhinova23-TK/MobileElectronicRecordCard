import 'package:flutter/material.dart';
import 'package:mobile_electronic_record_card/controller/mark_controller.dart';
import 'package:mobile_electronic_record_card/model/entity/mark_entity.dart';

class MarkProvider extends ChangeNotifier {
  late Future<List<MarkEntity>?> _marks;

  Future<List<MarkEntity>?> get marks => _marks;

  void initMarks(int controlTypeId) =>
      _marks = MarkController().getByControlTypeFromDb(controlTypeId);

  void fetchMarks() async => notifyListeners();
}
