import 'package:mobile_electronic_record_card/model/model.dart';
import 'package:mobile_electronic_record_card/repository/control_type_repository.dart';

class ControlTypeRepositoryImpl implements ControlTypeRepository {
  @override
  Future<int?> save(Control_type controlType) async {
    return await controlType.save();
  }

  @override
  Future<void> delete(int id) async {
    await Control_type().select().id.equals(id).delete();
  }

  @override
  Future<Control_type?> getControlType(int id) async {
    return await Control_type().getById(id);
  }

  @override
  Future<List<Mark>?> getMarks(int id) async {
    return await Control_type(id: id).getMarks()?.toList();
  }

  @override
  Future<List<Control_type>> getAll() async {
    return await Control_type().select().toList();
  }

  @override
  Future<void> deleteAll() async {
    await Control_type().select().delete();
  }

  @override
  Future<int>? getMaxVersion() async {
    Control_type? controlType = await Control_type()
        .select(columnsToSelect: [Control_typeFields.version.max()])
        .groupBy('version')
        .toSingle();
    return controlType?.version ?? 0;
  }

  @override
  Future<List<Mark>?> getMarksByGroupAndSubject(
      int groupId, int subjectId) async {
    return Mark.fromMapList((await ElectronicRecordCardDbModel()
        .execDataTable("""select distinct m.*
        from student_group sg join "user" u on u.groupId = sg.id
        join user_subject_control_type usct on usct.student_id = u.id
        join subject s on s.id = usct.subject_id
        join mark_control_type mct on mct.control_typeId = usct.control_type_id
        join mark m on m.id = mct.markId
        where s.id = $subjectId and sg.id = $groupId""")));
  }
}
