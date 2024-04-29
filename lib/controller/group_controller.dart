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

  Future<void> synchronization () async {
    await getAllFromServer().then((value) =>
        setAllToDb(value)
            .then((value) =>
            Log.i('Data received into db', tag: 'group_controller'))
            .catchError((e) => Log.e(e, tag: 'group_controller')))
        .catchError((e) => Log.e(e, tag: 'group_controller'));
  }

  Future<List<GroupEntity>> getAllFromDb () async {
    Mapper<GroupEntity, Student_group> groupMapper = GroupMapper();
    return (await GroupRepositoryImpl().getAll())
        .map((controlType) => groupMapper.toEntity(controlType)).toList();
  }

  Future<List<GroupEntity>> getAllFromServer () {
    return GroupHttpClientImpl().getAll() ;
  }

  // need?
  Future<GroupEntity> getByIdFromServer (int id) {
    return GroupHttpClientImpl().getById(id);
  }

  Future<void> setAllToDb(List<GroupEntity> groups) async {
    GroupRepository groupRepository = GroupRepositoryImpl();
    for (var element in groups) {
      groupRepository
            .save(GroupMapper().toModel(element));
    }
  }

}