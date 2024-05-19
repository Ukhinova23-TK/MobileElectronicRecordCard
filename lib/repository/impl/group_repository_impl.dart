import 'package:mobile_electronic_record_card/model/model.dart';
import 'package:mobile_electronic_record_card/repository/group_repository.dart';

class GroupRepositoryImpl implements GroupRepository {
  @override
  Future<void> delete(int id) async {
    await Student_group().select().id.equals(id).delete();
  }

  @override
  Future<Student_group?> get(int id) async {
    return await Student_group().getById(id);
  }

  @override
  Future<List<Student_group>> getAll() async {
    return await Student_group().select().toList();
  }

  @override
  Future<int?> save(Student_group studentGroup) async {
    return await studentGroup.save();
  }

  @override
  Future<void> deleteAll() async {
    await Student_group().select().delete();
  }

  @override
  Future<int>? getMaxVersion() async {
    Student_group? studentGroup = await Student_group()
        .select(columnsToSelect: [Student_groupFields.version.max()])
        .groupBy('version')
        .toSingle();
    return studentGroup?.version ?? 0;
  }

  @override
  Future<List<Student_group>> getBySubject(int subjectId) async {
    return Student_group.fromMapList((await ElectronicRecordCardDbModel()
        .execDataTable("""select distinct sg.*
        from student_group sg join "user" u on u.groupId = sg.id
        join user_subject_control_type usct on usct.student_id = u.id
        join subject s on s.id = usct.subject_id
        where s.id = $subjectId""")));
  }
}
