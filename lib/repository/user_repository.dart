import 'package:mobile_electronic_record_card/model/model.dart';

abstract class UserRepository {
  Future<int?> save(User user);

  Future<List<User>> getAll();

  Future<User?> get(int id);

  Future<List<Role>?> getRoles(int id);

  Future<void> delete(int id);

  Future<void> deleteAll();

  Future<int>? getMaxVersion();

  Future<List<User>> getStudentsByGroupAndSubject(int groupId, int subjectId);
}
