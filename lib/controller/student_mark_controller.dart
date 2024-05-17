import 'package:flutter_logcat/flutter_logcat.dart';
import 'package:mobile_electronic_record_card/client/impl/student_mark_http_client_impl.dart';
import 'package:mobile_electronic_record_card/model/entity/student_and_mark_entity.dart';
import 'package:mobile_electronic_record_card/model/entity/student_mark_entity.dart';
import 'package:mobile_electronic_record_card/model/model.dart';
import 'package:mobile_electronic_record_card/repository/impl/student_mark_repository_impl.dart';
import 'package:mobile_electronic_record_card/repository/impl/user_subject_control_type_repository_impl.dart';
import 'package:mobile_electronic_record_card/repository/student_mark_repository.dart';
import 'package:mobile_electronic_record_card/service/mapper/impl/student_mark_mapper.dart';
import 'package:mobile_electronic_record_card/service/mapper/mapper.dart';

class StudentMarkController {
  Future<List<StudentMarkEntity>> get marks => getAllFromDb();

  Future<List<StudentAndMarkEntity>> getByGroupAndSubjectFromDb(
      int groupId, int subjectId) async {
    return (await StudentMarkRepositoryImpl()
            .getByGroupAndSubject(groupId, subjectId))
        .map((e) => StudentAndMarkEntity.fromJson(e))
        .toList();
  }

  void _setToDb(StudentMarkEntity studentMark) {
    StudentMarkRepositoryImpl().save(StudentMarkMapper().toModel(studentMark));
  }

  void _updateToDb(StudentMarkEntity studentMark) {
    StudentMarkRepositoryImpl()
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
      _updateToDb(sm.first);
    } else {
      var usct = await UserSubjectControlTypeRepositoryImpl()
          .getByStudentAndSubject(userId, subjectId);
      if (usct != null) {
        _setToDb(StudentMarkEntity(
            markId: markId,
            completionDate: DateTime.now(),
            userSubjectControlTypeId: usct.id,
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

  Future<void> getAllFromServer() async {
    return StudentMarkHttpClientImpl().getAll().then((value) =>
        setAllToDb(value)
            .then((value) =>
                Log.i('Data received into db', tag: 'student_mark_controller'))
            .catchError((e) => Log.e(e, tag: 'student_mark_controller'))
            .catchError((e) => Log.e(e, tag: 'student_mark_controller')));
  }

  Future<void> setAllToDb(List<StudentMarkEntity> studentMarks) async {
    StudentMarkRepository studentMarkRepository = StudentMarkRepositoryImpl();
    for (var element in studentMarks) {
      studentMarkRepository.save(StudentMarkMapper().toModel(element));
    }
  }

  /*Future<void> postOnServer(StudentMarkEntity studentMarkEntity) async {}

  Future<void> updateOnServer(StudentMarkEntity studentMarkEntity) async {}*/
}
