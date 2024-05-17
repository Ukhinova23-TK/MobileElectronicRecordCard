import 'package:mobile_electronic_record_card/model/model.dart';

abstract class UserSubjectControlTypeRepository {
  Future<int?> save(User_subject_control_type userSubjectControlType);

  Future<List<User_subject_control_type>> getAll();

  Future<User_subject_control_type?> get(int id);

  Future<void> delete(int id);

  Future<void> deleteAll();

  Future<int>? getMaxVersion();

  Future<List<User_subject_control_type>> getByGroupAndSubject(int groupId, int subjectId);
}
