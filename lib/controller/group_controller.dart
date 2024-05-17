import 'package:flutter_logcat/log/log.dart';

import '../client/impl/group_http_client_impl.dart';
import '../model/entity/group_entity.dart';
import '../model/model.dart';
import '../repository/group_repository.dart';
import '../repository/impl/group_repository_impl.dart';
import '../service/mapper/impl/group_mapper.dart';
import '../service/mapper/mapper.dart';

class GroupController {
  Future<List<GroupEntity>> get groups => getAllFromDb();

  Future<List<GroupEntity>> getAllFromDb() async {
    Mapper<GroupEntity, Student_group> groupMapper = GroupMapper();
    return (await GroupRepositoryImpl().getAll())
        .map((controlType) => groupMapper.toEntity(controlType))
        .toList();
  }

  Future<void> getAllFromServer() async {
    return GroupHttpClientImpl().getAll().then((value) => setAllToDb(value)
        .then(
            (value) => Log.i('Data received into db', tag: 'group_controller'))
        .catchError((e) => Log.e(e, tag: 'group_controller'))
        .catchError((e) => Log.e(e, tag: 'group_controller')));
  }

  Future<List<GroupEntity>> getBySubject(int subjectId) async {
    Mapper<GroupEntity, Student_group> groupMapper = GroupMapper();
    return (await GroupRepositoryImpl().getBySubject(subjectId))
        .map((controlType) => groupMapper.toEntity(controlType))
        .toList();
  }

  Future<void> setAllToDb(List<GroupEntity> groups) async {
    GroupRepository groupRepository = GroupRepositoryImpl();
    for (var element in groups) {
      groupRepository.save(GroupMapper().toModel(element));
    }
  }
}
