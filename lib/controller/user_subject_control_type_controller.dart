import 'package:flutter_logcat/flutter_logcat.dart';
import 'package:mobile_electronic_record_card/client/impl/user_subject_control_type_http_client_impl.dart';
import 'package:mobile_electronic_record_card/controller/delete_controller.dart';
import 'package:mobile_electronic_record_card/model/entity/teacher_subject_control_type_mark_semester_entity.dart';
import 'package:mobile_electronic_record_card/model/entity/user_subject_control_type_entity.dart';
import 'package:mobile_electronic_record_card/model/model.dart';
import 'package:mobile_electronic_record_card/repository/impl/user_subject_control_type_repository_impl.dart';
import 'package:mobile_electronic_record_card/repository/user_subject_control_type_repository.dart';
import 'package:mobile_electronic_record_card/service/mapper/impl/user_subject_control_type_mapper.dart';
import 'package:mobile_electronic_record_card/service/mapper/mapper.dart';

class UserSubjectControlTypeController implements DeleteController {
  Future<List<UserSubjectControlTypeEntity>> get userSubjectControlTypes =>
      getAllFromDb();

  Future<List<UserSubjectControlTypeEntity>> getAllFromDb() async {
    Mapper<UserSubjectControlTypeEntity, User_subject_control_type> usctMapper =
        UserSubjectControlTypeMapper();
    return (await UserSubjectControlTypeRepositoryImpl().getAll())
        .map((usct) => usctMapper.toEntity(usct))
        .toList();
  }

  Future<List<TeacherSubjectControlTypeMarkSemesterEntity>> getByStudentFromDb(
      int userId) async {
    return (await UserSubjectControlTypeRepositoryImpl()
        .getByStudent(userId))
        .map((e) => TeacherSubjectControlTypeMarkSemesterEntity.fromJson(e))
        .toList();
  }

  Future<void> getAllFromServer() async {
    return UserSubjectControlTypeHttpClientImpl().getAll().then((value) =>
        setAllToDb(value)
            .then((value) => Log.i('Data received into db',
                tag: 'user_subject_control_type_controller'))
            .catchError(
                (e) => Log.e(e, tag: 'user_subject_control_type_controller'))
            .catchError(
                (e) => Log.e(e, tag: 'user_subject_control_type_controller')));
  }

  Future<void> setAllToDb(List<UserSubjectControlTypeEntity> usct) async {
    UserSubjectControlTypeRepository userSubjectControlTypeRepository =
        UserSubjectControlTypeRepositoryImpl();
    for (var element in usct) {
      userSubjectControlTypeRepository
          .save(UserSubjectControlTypeMapper().toModel(element));
    }
  }

  @override
  Future<void> delete(int id) async {
    await UserSubjectControlTypeRepositoryImpl().delete(id);
  }

  Future<void> deleteAll() async {
    await UserSubjectControlTypeRepositoryImpl().deleteAll();
  }
}
