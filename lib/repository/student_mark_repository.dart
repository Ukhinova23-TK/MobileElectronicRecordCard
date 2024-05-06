import 'package:mobile_electronic_record_card/model/model.dart';

abstract class StudentMarkRepository {
  Future<int?> save(Student_mark studentMark);

  Future<List<Student_mark>> getAll();

  Future<Student_mark?> get(int id);

  Future<void> delete(int id);

  Future<void> deleteAll();

  Future<int>? getMaxVersion();
}
