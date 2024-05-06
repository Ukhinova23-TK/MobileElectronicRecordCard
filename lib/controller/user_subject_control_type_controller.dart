import 'package:flutter_logcat/flutter_logcat.dart';
import 'package:mobile_electronic_record_card/client/impl/user_subject_control_type_http_client_impl.dart';
import 'package:mobile_electronic_record_card/model/entity/user_subject_control_type_entity.dart';
import 'package:mobile_electronic_record_card/model/enumeration/role_name.dart';
import 'package:mobile_electronic_record_card/model/model.dart';
import 'package:mobile_electronic_record_card/repository/impl/user_subject_control_type_repository_impl.dart';
import 'package:mobile_electronic_record_card/repository/user_subject_control_type_repository.dart';
import 'package:mobile_electronic_record_card/service/mapper/impl/user_subject_control_type_mapper.dart';
import 'package:mobile_electronic_record_card/service/mapper/mapper.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserSubjectControlTypeController {
  Future<List<UserSubjectControlTypeEntity>> get userSubjectControlTypes =>
      getAllFromDb();

  Future<List<UserSubjectControlTypeEntity>> getAllFromDb() async {
    Mapper<UserSubjectControlTypeEntity, User_subject_control_type> usctMapper =
        UserSubjectControlTypeMapper();
    return (await UserSubjectControlTypeRepositoryImpl().getAll())
        .map((usct) => usctMapper.toEntity(usct))
        .toList();
  }

  Future<void> synchronization() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    int? userId = pref.getInt('userId');
    int? rolesCount = pref.getInt('rolesCount');
    List<String>? rolesName = pref.getStringList('rolesName');
    if (rolesCount != null && rolesName != null && userId != null) {
      if (rolesCount == 1 && rolesName.first == RoleName.student) {
        getByStudentCriteriaFromServer(userId).then((value) => setAllToDb(value)
            .then((value) =>
                Log.i('Data received into db', tag: 'group_controller'))
            .catchError((e) => Log.e(e, tag: 'group_controller'))
            .catchError((e) => Log.e(e, tag: 'group_controller')));
      } else if (rolesCount == 1 && rolesName.first == RoleName.teacher) {
        getByTeacherCriteriaFromServer(userId).then((value) => setAllToDb(value)
            .then((value) =>
                Log.i('Data received into db', tag: 'group_controller'))
            .catchError((e) => Log.e(e, tag: 'group_controller'))
            .catchError((e) => Log.e(e, tag: 'group_controller')));
      } else {
        getByStudentCriteriaFromServer(userId).then((value) => setAllToDb(value)
            .then((value) =>
                Log.i('Data received into db', tag: 'group_controller'))
            .catchError((e) => Log.e(e, tag: 'group_controller'))
            .catchError((e) => Log.e(e, tag: 'group_controller')));
        getByTeacherCriteriaFromServer(userId).then((value) => setAllToDb(value)
            .then((value) =>
                Log.i('Data received into db', tag: 'group_controller'))
            .catchError((e) => Log.e(e, tag: 'group_controller'))
            .catchError((e) => Log.e(e, tag: 'group_controller')));
      }
    }
  }

  Future<List<UserSubjectControlTypeEntity>> getByStudentCriteriaFromServer(
      int userId) {
    return UserSubjectControlTypeHttpClientImpl()
        .getAll(UserSubjectControlTypeEntity.toStudentCriteriaJson(userId));
  }

  Future<List<UserSubjectControlTypeEntity>> getByTeacherCriteriaFromServer(
      int userId) {
    return UserSubjectControlTypeHttpClientImpl()
        .getAll(UserSubjectControlTypeEntity.toTeacherCriteriaJson(userId));
  }

  Future<void> setAllToDb(List<UserSubjectControlTypeEntity> usct) async {
    UserSubjectControlTypeRepository userSubjectControlTypeRepository =
        UserSubjectControlTypeRepositoryImpl();
    for (var element in usct) {
      userSubjectControlTypeRepository
          .save(UserSubjectControlTypeMapper().toModel(element));
    }
  }
}
