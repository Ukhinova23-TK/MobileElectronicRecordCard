import 'package:mobile_electronic_record_card/model/model.dart';
import 'package:mobile_electronic_record_card/repository/user_subject_control_type_repository.dart';

class UserSubjectControlTypeRepositoryImpl
    implements UserSubjectControlTypeRepository {
  @override
  Future<void> delete(int id) async {
    await User_subject_control_type().select().id.equals(id).delete();
  }

  @override
  Future<User_subject_control_type?> get(int id) async {
    return await User_subject_control_type().getById(id);
  }

  Future<User_subject_control_type?> getByStudentAndSubject(
      int userId, int subjectId) async {
    return await User_subject_control_type()
        .select()
        .student_id
        .equals(userId)
        .and
        .subject_id
        .equals(subjectId)
        .toSingle();
  }

  @override
  Future<List<User_subject_control_type>> getAll() async {
    return await User_subject_control_type().select().toList();
  }

  @override
  Future<int?> save(User_subject_control_type userSubjectControlType) async {
    return await userSubjectControlType.save();
  }

  @override
  Future<void> deleteAll() async {
    await User_subject_control_type().select().delete();
  }

  @override
  Future<int>? getMaxVersion() async {
    User_subject_control_type? userSubjectControlType =
        await User_subject_control_type()
            .select(columnsToSelect: [
              User_subject_control_typeFields.version.max()
            ])
            .orderBy('version')
            .toSingle();
    return userSubjectControlType?.version ?? 0;
  }

  @override
  Future<List<User_subject_control_type>> getByGroupAndSubject(
      int groupId, int subjectId) async {
    return User_subject_control_type.fromMapList(
        (await ElectronicRecordCardDbModel().execDataTable("""select usct.*
        from student_group sg join "user" u on u.groupId = sg.id
        join user_subject_control_type usct on usct.student_id = u.id
        join subject s on s.id = usct.subject_id
        where s.id = $subjectId and sg.id = $groupId""")));
  }

  Future<List<Map<String, dynamic>>> getByStudent(int userId) async {
    return await ElectronicRecordCardDbModel().execDataTable("""
    select u.id as "user.id", u.last_name as "user.lastName",
    u.first_name as "user.firstName", u.middle_name as "user.middleName",
    m.id as "mark.id", m.name as "mark.name",
    m.title as "mark.title", m.value as "mark.value",
    s.id as "subject.id", s.name as "subject.name",
    ct.id as "control_type.id", ct.name as "control_type.name",
    ct.title as "control_type.title", usct.semester
    from "user" u join user_subject_control_type usct on u.id = usct.teacher_id
    join subject s on usct.subject_id = s.id
    join control_type ct on usct.control_type_id = ct.id
    left join student_mark sm on usct.id = sm.user_subject_control_type_id
    left join mark m on sm.mark_id = m.id
    where usct.student_id = $userId
    """);
  }
}
