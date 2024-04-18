import 'package:mobile_electronic_record_card/service/mapper/mapper.dart';

import '../../../model/entity/control_type_entity.dart';
import '../../../model/model.dart';

class ControlTypeMapper implements Mapper<ControlTypeEntity, Control_type> {
  @override
  ControlTypeEntity toEntity(Control_type model) {
    return ControlTypeEntity(
        id: model.id,
        name: model.name,
        title: model.title
    );
  }

  @override
  Control_type toModel(ControlTypeEntity entity) {
    return Control_type(
      id: entity.id,
      name: entity.name,
      title: entity.title
    );
  }

}