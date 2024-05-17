import 'package:mobile_electronic_record_card/model/model.dart';
import 'package:mobile_electronic_record_card/repository/user_repository.dart';

class UserRepositoryImpl implements UserRepository {
  @override
  Future<void> delete(int id) async {
    await User().select().id.equals(id).delete();
  }

  @override
  Future<User?> get(int id) async {
    return await User().getById(id);
  }

  @override
  Future<List<User>> getAll() async {
    return await User().select().toList();
  }

  @override
  Future<int?> save(User user) async {
    return await user.save();
  }

  @override
  Future<void> deleteAll() async {
    await User().select().delete();
  }

  @override
  Future<List<Role>?> getRoles(int id) async {
    return await User().getRoles()?.where('id=$id').toList();
  }

  @override
  Future<int>? getMaxVersion() async {
    User? user = await User()
        .select(columnsToSelect: [UserFields.version.max()])
        .orderBy('version')
        .toSingle();
    return user?.version ?? 0;
  }

  @override
  Future<List<User>> getStudentsByGroupAndSubject(
      int groupId, int subjectId) async {
    return User.fromMapList(
        (await ElectronicRecordCardDbModel().execDataTable("""select u.*
        from student_group sg join "user" u on u.groupId = sg.id
        join user_subject_control_type usct on usct.student_id = u.id
        join subject s on s.id = usct.subject_id
        where s.id = $subjectId and sg.id = $groupId""")));
  }
}
