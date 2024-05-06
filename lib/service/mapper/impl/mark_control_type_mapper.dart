import 'package:mobile_electronic_record_card/model/model.dart';
import 'package:mobile_electronic_record_card/service/mapper/mapper.dart';

import '../../../model/entity/mark_control_type_entity.dart';

class MarkControlTypeMapper
    implements Mapper<MarkControlTypeEntity, Mark_control_type> {
  @override
  MarkControlTypeEntity toEntity(Mark_control_type model) {
    return MarkControlTypeEntity(
        markId: model.markId, controlTypeId: model.control_typeId);
  }

  @override
  Mark_control_type toModel(MarkControlTypeEntity entity) {
    return Mark_control_type(
        markId: entity.markId, control_typeId: entity.controlTypeId);
  }
}
