import 'package:mobile_electronic_record_card/model/entity/control_type_entity.dart';
import 'package:mobile_electronic_record_card/model/model.dart';
import 'package:mobile_electronic_record_card/repository/control_type_repository.dart';
import 'package:mobile_electronic_record_card/repository/impl/control_type_repository_impl.dart';
import 'package:mobile_electronic_record_card/service/mapper/impl/control_type_mapper.dart';
import 'package:mobile_electronic_record_card/service/mapper/mapper.dart';

class ControlTypeController {
  Future<List<ControlTypeEntity>> get controlTypes => getAllFromDb();

  Future<List<ControlTypeEntity>> getAllFromDb() async {
    Mapper<ControlTypeEntity, Control_type> controlTypeMapper =
        ControlTypeMapper();
    return (await ControlTypeRepositoryImpl().getAll())
        .map((controlType) => controlTypeMapper.toEntity(controlType))
        .toList();
  }

  Future<void> setAllToDb(List<ControlTypeEntity> controlTypes) async {
    ControlTypeRepository controlTypeRepository = ControlTypeRepositoryImpl();
    for (var element in controlTypes) {
      controlTypeRepository.save(ControlTypeMapper().toModel(element));
    }
  }
}
