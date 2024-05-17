import 'package:mobile_electronic_record_card/model/model.dart';

abstract class ControlTypeRepository {
  Future<int?> save(Control_type controlType);

  Future<List<Control_type>> getAll();

  Future<Control_type?> getControlType(int id);

  Future<List<Mark>?> getMarks(int id);

  Future<List<Mark>?> getMarksByGroupAndSubject(int groupId, int subjectId);

  Future<void> delete(int id);

  Future<void> deleteAll();

  Future<int>? getMaxVersion();
}