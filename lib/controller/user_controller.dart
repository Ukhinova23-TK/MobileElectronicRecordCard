import 'package:flutter_logcat/log/log.dart';
import 'package:mobile_electronic_record_card/client/impl/user_http_client_impl.dart';
import 'package:mobile_electronic_record_card/controller/role_controller.dart';
import 'package:mobile_electronic_record_card/model/entity/authenticate_entity.dart';
import 'package:mobile_electronic_record_card/model/entity/user_entity.dart';
import 'package:mobile_electronic_record_card/repository/impl/storage_repository_impl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../model/entity/role_entity.dart';
import '../model/model.dart';
import '../repository/impl/user_repository_impl.dart';
import '../repository/user_repository.dart';
import '../service/mapper/impl/role_mapper.dart';
import '../service/mapper/impl/user_mapper.dart';
import '../service/mapper/mapper.dart';

class UserController {
  Future<List<UserEntity>> get users => getAllFromDb();

  Future<void> synchronization() async {
    await getAllFromServer().then((value) =>
        setAllToDb(value)
            .then((_) =>
            Log.i('Data received into db', tag: 'user_controller'))
            .catchError((e) => Log.e(e, tag: 'user_controller')))
        .catchError((e) => Log.e(e, tag: 'user_controller'));
  }

  Future<List<UserEntity>> getAllFromDb() async {
    Mapper<UserEntity, User> userMapper = UserMapper();
    return (await UserRepositoryImpl().getAll())
        .map((user) => userMapper.toEntity(user)).toList();
  }

  Future<List<RoleEntity>?> getRolesFromDb(int id) async {
    Mapper<RoleEntity, Role> roleMapper = RoleMapper();
    return (await UserRepositoryImpl().getRoles(id))
        ?.map((role) => roleMapper.toEntity(role)).toList();
  }

  Future<List<UserEntity>> getAllFromServer() async {
    return await UserHttpClientImpl().getAll();
  }

  Future<void> setAllToDb(List<UserEntity> users) async {
    UserRepository userRepository = UserRepositoryImpl();
    for (var element in users) {
      userRepository
          .save(UserMapper().toModel(element));
    }
  }

  Future<UserEntity> getByLoginFromServer(String login) async {
    UserEntity user = await UserHttpClientImpl().getByLogin(login);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt('id', user.id!);
    if (user.groupId != null) {
      prefs.setInt('groupId', user.groupId!);
    }
    if (user.roles != null) {
      await RoleController().getStudentTeacherRoleFromDb(user.roles!).then((roles){
        if(roles.isNotEmpty) {
          List<String> r = [];
          for (var element in roles) {
            r.add(element!);
          }
          prefs.setInt('rolesCount', roles.length);
          prefs.setStringList('rolesName', r);
        }
      });
    }
    return user;
  }

  Future<void> authenticate(String login, String password) async {
    await UserHttpClientImpl().authenticate(
        AuthenticateEntity(login, password).toJson())
        .then((value) {
      StorageRepositoryImpl().saveSecureData(AuthenticateEntity
          .fromJson(value)
          .token!);
    });
  }
}