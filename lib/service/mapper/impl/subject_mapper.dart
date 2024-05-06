import 'package:mobile_electronic_record_card/model/entity/subject_entity.dart';
import 'package:mobile_electronic_record_card/model/model.dart';

import '../mapper.dart';

class SubjectMapper implements Mapper<SubjectEntity, Subject> {
  @override
  SubjectEntity toEntity(Subject model) {
    return SubjectEntity(
        id: model.id, name: model.name, version: model.version);
  }

  @override
  Subject toModel(SubjectEntity entity) {
    return Subject(id: entity.id, name: entity.name, version: entity.version);
  }
}
