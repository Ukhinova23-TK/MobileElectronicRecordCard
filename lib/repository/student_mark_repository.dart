import 'package:mobile_electronic_record_card/model/model.dart';
import 'package:sqfentity_gen/sqfentity_gen.dart';

abstract class StudentMarkRepository {
  Future<BoolResult> update(Student_mark studentMark);

  Future<int?> save(Student_mark studentMark);

  Future<List<Student_mark>> getAll();

  Future<Student_mark?> get(int id);

  Future<void> delete(int id);

  Future<void> deleteAll();

  Future<int>? getMaxVersion();

  Future<Student_mark?> getByUserSubjectControlType(int controlTypeId);

  Future<List<Map<String, dynamic>>> getByGroupAndSubject(
      int groupId, int subjectId);
}
