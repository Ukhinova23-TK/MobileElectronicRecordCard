import 'package:flutter_logcat/log/log.dart';

import '../client/impl/control_type_http_client_impl.dart';
import '../model/entity/control_type_entity.dart';
import '../model/model.dart';
import '../repository/control_type_repository.dart';
import '../repository/impl/control_type_repository_impl.dart';
import '../service/mapper/impl/control_type_mapper.dart';
import '../service/mapper/mapper.dart';

class ControlTypeController {
  Future<List<ControlTypeEntity>> get controlTypes => getAllFromDb();

  Future<List<ControlTypeEntity>> getAllFromDb() async {
    Mapper<ControlTypeEntity, Control_type> controlTypeMapper =
        ControlTypeMapper();
    return (await ControlTypeRepositoryImpl().getAll())
        .map((controlType) => controlTypeMapper.toEntity(controlType))
        .toList();
  }

  Future<void> getAllFromServer() {
    return ControlTypeHttpClientImpl()
        .getAll()
        .then((value) => setAllToDb(value))
        .then((value) =>
            Log.i('Data received into db', tag: 'control_type_controller'))
        .catchError((e) => Log.e(e, tag: 'control_type_controller'))
        .catchError((e) => Log.e(e, tag: 'control_type_controller'));
  }

  Future<void> setAllToDb(List<ControlTypeEntity> controlTypes) async {
    ControlTypeRepository controlTypeRepository = ControlTypeRepositoryImpl();
    for (var element in controlTypes) {
      controlTypeRepository.save(ControlTypeMapper().toModel(element));
    }
  }
}
