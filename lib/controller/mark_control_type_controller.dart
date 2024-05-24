import 'package:mobile_electronic_record_card/model/entity/mark_control_type_entity.dart';
import 'package:mobile_electronic_record_card/model/model.dart';
import 'package:mobile_electronic_record_card/repository/impl/mark_control_type_repository_impl.dart';
import 'package:mobile_electronic_record_card/repository/mark_control_type_repository.dart';
import 'package:mobile_electronic_record_card/service/mapper/impl/mark_control_type_mapper.dart';
import 'package:mobile_electronic_record_card/service/mapper/mapper.dart';

class MarkControlTypeController {
  Future<List<MarkControlTypeEntity>> get markControlTypes => getAllFromDb();

  Future<List<MarkControlTypeEntity>> getAllFromDb() async {
    Mapper<MarkControlTypeEntity, Mark_control_type> markControlTypeMapper =
        MarkControlTypeMapper();
    return (await MarkControlTypeRepositoryImpl().getAll())
        .map((markControlType) =>
            markControlTypeMapper.toEntity(markControlType))
        .toList();
  }

  Future<void> setAllToDb(List<MarkControlTypeEntity> markControlTypes) async {
    MarkControlTypeRepository controlTypeRepository =
        MarkControlTypeRepositoryImpl();
    for (var element in markControlTypes) {
      controlTypeRepository.save(MarkControlTypeMapper().toModel(element));
    }
  }
}
