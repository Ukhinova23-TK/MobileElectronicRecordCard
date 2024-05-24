import 'package:mobile_electronic_record_card/controller/delete_controller.dart';
import 'package:mobile_electronic_record_card/model/entity/group_entity.dart';
import 'package:mobile_electronic_record_card/model/model.dart';
import 'package:mobile_electronic_record_card/repository/group_repository.dart';
import 'package:mobile_electronic_record_card/repository/impl/group_repository_impl.dart';
import 'package:mobile_electronic_record_card/service/mapper/impl/group_mapper.dart';
import 'package:mobile_electronic_record_card/service/mapper/mapper.dart';

class GroupController implements DeleteController {
  Future<List<GroupEntity>> get groups => getAllFromDb();

  Future<List<GroupEntity>> getAllFromDb() async {
    Mapper<GroupEntity, Student_group> groupMapper = GroupMapper();
    return (await GroupRepositoryImpl().getAll())
        .map((controlType) => groupMapper.toEntity(controlType))
        .toList();
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

  @override
  Future<void> delete(int id) async {
    await GroupRepositoryImpl().delete(id);
  }

  Future<void> deleteAll() async {
    await GroupRepositoryImpl().deleteAll();
  }
}
