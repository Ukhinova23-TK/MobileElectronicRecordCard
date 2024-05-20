import 'package:mobile_electronic_record_card/model/entity/student_mark_entity.dart';

abstract class SynchronizationService {
  Future<void> fetch();
  Future<void> push(List<StudentMarkEntity> studentMarks);
  Future<void> clearDb();
  void clearPreferences();
}
