import 'package:mobile_electronic_record_card/model/entity/student_mark_entity.dart';

abstract class StudentMarkHttpClient {
  Future<List<StudentMarkEntity>> getAll();

  Future<void> post(StudentMarkEntity studentMark);

  Future<void> update(StudentMarkEntity studentMark);
}
