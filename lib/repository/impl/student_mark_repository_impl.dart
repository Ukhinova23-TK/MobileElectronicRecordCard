import 'package:mobile_electronic_record_card/model/enumeration/mark_name.dart';
import 'package:mobile_electronic_record_card/model/model.dart';
import 'package:mobile_electronic_record_card/repository/student_mark_repository.dart';
import 'package:sqfentity_gen/sqfentity_gen.dart';

class StudentMarkRepositoryImpl implements StudentMarkRepository {
  @override
  Future<void> delete(int id) async {
    await Student_mark().select().id.equals(id).delete();
  }

  @override
  Future<Student_mark?> get(int id) async {
    return await Student_mark().getById(id);
  }

  @override
  Future<List<Student_mark>> getAll() async {
    return await Student_mark().select().toList();
  }

  @override
  Future<int?> save(Student_mark studentMark) async {
    return await studentMark.upsert();
  }

  @override
  Future<BoolResult> update(Student_mark studentMark) {
    return ElectronicRecordCardDbModel().execSQL("""update student_mark
    set id = ${studentMark.id},
    mark_id = ${studentMark.mark_id}, 
    completion_date = ${studentMark.completion_date?.millisecondsSinceEpoch},
    saved = ${studentMark.saved},
    version = ${studentMark.version}
    where user_subject_control_type_id = 
    ${studentMark.user_subject_control_type_id}
    """);
  }

  @override
  Future<void> deleteAll() async {
    await Student_mark().select().delete();
  }

  @override
  Future<int>? getMaxVersion() async {
    Student_mark? studentMark = await Student_mark()
        .select(columnsToSelect: [Student_markFields.version.max()])
        .orderBy('version')
        .toSingle();
    return studentMark?.version ?? 0;
  }

  @override
  Future<Student_mark?> getByUserSubjectControlType(int controlTypeId) async {
    return await Student_mark()
        .select()
        .user_subject_control_type_id
        .equals(controlTypeId)
        .toSingle();
  }

  @override
  Future<List<Map<String, dynamic>>> getByGroupAndSubject(
      int groupId, int subjectId) async {
    return await ElectronicRecordCardDbModel().execDataTable("""
    select u.id as "user.id", u.last_name as "user.lastName",
    u.first_name as "user.firstName", u.middle_name as "user.middleName", 
    m.id as "mark.id", m.name as "mark.name", m.title as "mark.title", 
    m.value as "mark.value", sm.saved as "saved", usct.semester as "semester" 
    from "user" u join user_subject_control_type usct on u.id = usct.student_id
    join subject s on usct.subject_id = s.id
    left join student_mark sm on usct.id = sm.user_subject_control_type_id
    left join mark m on sm.mark_id = m.id
    where u.groupId = $groupId and s.id = $subjectId
    """);
  }

  @override
  Future<List<Student_mark>> getStudentMarksByGroupAndSubjectAndSemester(
      int groupId, int subjectId, int semester) async {
    return (await ElectronicRecordCardDbModel().execDataTable("""
    select sm.*
    from "user" u join user_subject_control_type usct on u.id = usct.student_id
    join student_mark sm on usct.id = sm.user_subject_control_type_id
    join mark m on sm.mark_id = m.id
    where u.groupId = $groupId and usct.subject_id = $subjectId
    and m.name != '${MarkName.nonAdmission}' and sm.saved = true
    and usct.semester = $semester
    """)).map((e) => Student_mark.fromMap(e)).toList();
  }

  @override
  Future<List<Map<String, dynamic>>>? getByStudentAndSubjectAndSemester(
      int userId, int subjectId, int semester) async {
    return await ElectronicRecordCardDbModel().execDataTable("""
    select sm.id, sm.mark_id as "markId", 
    sm.user_subject_control_type_id as "userSubjectControlTypeId", 
    sm.completion_date as "completionDate", sm.version
    from student_mark sm join user_subject_control_type usct 
    on sm.user_subject_control_type_id = usct.id
    where usct.student_id = $userId and usct.subject_id = $subjectId
    and usct.semester = $semester""");
  }
}
