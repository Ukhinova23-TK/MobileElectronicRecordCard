import '../../../model/entity/group_entity.dart';
import '../../../model/model.dart';
import '../mapper.dart';

class GroupMapper implements Mapper<GroupEntity, Student_group> {
  @override
  GroupEntity toEntity(Student_group model) {
    return GroupEntity(
        id: model.id,
        name: model.name,
        fullName: model.full_name,
        admissionDate: model.admission_date,
        version: model.version);
  }

  @override
  Student_group toModel(GroupEntity entity) {
    return Student_group(
        id: entity.id,
        name: entity.name,
        full_name: entity.fullName,
        admission_date: entity.admissionDate,
        version: entity.version);
  }
}
