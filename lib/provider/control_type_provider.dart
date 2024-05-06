import 'package:flutter/material.dart';
import 'package:mobile_electronic_record_card/controller/control_type_controller.dart';
import 'package:mobile_electronic_record_card/model/entity/control_type_entity.dart';

class ControlTypeProvider extends ChangeNotifier {
  late Future<List<ControlTypeEntity>> _controlTypes;

  Future<List<ControlTypeEntity>> get controlTypes => _controlTypes;

  void initControlTypes(int controlTypeId) =>
      _controlTypes = ControlTypeController().controlTypes;

  void fetchControlTypes() async => notifyListeners();
}
