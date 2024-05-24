import 'package:mobile_electronic_record_card/controller/delete_controller.dart';
import 'package:mobile_electronic_record_card/model/entity/student_and_mark_entity.dart';
import 'package:mobile_electronic_record_card/model/entity/student_mark_entity.dart';
import 'package:mobile_electronic_record_card/model/model.dart';
import 'package:mobile_electronic_record_card/repository/impl/student_mark_repository_impl.dart';
import 'package:mobile_electronic_record_card/repository/impl/user_subject_control_type_repository_impl.dart';
import 'package:mobile_electronic_record_card/repository/student_mark_repository.dart';
import 'package:mobile_electronic_record_card/service/mapper/impl/student_mark_mapper.dart';
import 'package:mobile_electronic_record_card/service/mapper/mapper.dart';

class StudentMarkController implements DeleteController {
  Future<List<StudentMarkEntity>> get marks => getAllFromDb();

  Future<StudentMarkEntity?> getByUserSubjectControlTypeFromDb(
      int usctId) async {
    var studentMark =
        await StudentMarkRepositoryImpl().getByUserSubjectControlType(usctId);
    return studentMark != null
        ? StudentMarkMapper().toEntity(studentMark)
        : null;
  }

  Future<List<StudentAndMarkEntity>> getByGroupAndSubjectFromDb(
      int groupId, int subjectId) async {
    return (await StudentMarkRepositoryImpl()
            .getByGroupAndSubject(groupId, subjectId))
        .map((e) => StudentAndMarkEntity.fromJson(e))
        .toList();
  }

  Future<List<StudentMarkEntity>> getStudentMarksByGroupAndSubjectFromDb(
      int groupId, int subjectId) async {
    return (await StudentMarkRepositoryImpl()
        .getStudentMarksByGroupAndSubject(groupId, subjectId))
        .map((e) => StudentMarkMapper().toEntity(e))
        .toList();
  }

  Future<void> setToDb(StudentMarkEntity studentMark) async {
    await StudentMarkRepositoryImpl()
        .save(StudentMarkMapper().toModel(studentMark));
  }

  Future<void> updateToDb(StudentMarkEntity studentMark) async {
    await StudentMarkRepositoryImpl()
        .update(StudentMarkMapper().toModel(studentMark));
  }

  Future<void> set(int userId, int markId, int subjectId) async {
    var sm = (await StudentMarkRepositoryImpl()
        .getByStudentAndSubject(userId, subjectId))
        ?.map((e) => StudentMarkEntity.fromJson(e))
        .toList();
    if (sm != null && sm.isNotEmpty) {
      sm.first.markId = markId;
      sm.first.completionDate = DateTime.now();
      sm.first.saved = true;
      await updateToDb(sm.first);
    } else {
      var usct = await UserSubjectControlTypeRepositoryImpl()
          .getByStudentAndSubject(userId, subjectId);
      if (usct != null) {
        await setToDb(StudentMarkEntity(
            markId: markId,
            completionDate: DateTime.now(),
            userSubjectControlTypeId: usct.id,
            saved: true,
            version: 0));
      }
    }
  }

  Future<List<StudentMarkEntity>> getAllFromDb() async {
    Mapper<StudentMarkEntity, Student_mark> studentMarkMapper =
        StudentMarkMapper();
    return (await StudentMarkRepositoryImpl().getAll())
        .map((mark) => studentMarkMapper.toEntity(mark))
        .toList();
  }

  Future<void> setAllToDb(List<StudentMarkEntity> studentMarks) async {
    StudentMarkRepository studentMarkRepository = StudentMarkRepositoryImpl();
    for (var element in studentMarks) {
      studentMarkRepository.save(StudentMarkMapper().toModel(element));
    }
  }

  @override
  Future<void> delete(int id) async {
    await StudentMarkRepositoryImpl().delete(id);
  }

  Future<void> deleteAll() async {
    await StudentMarkRepositoryImpl().deleteAll();
  }
}
