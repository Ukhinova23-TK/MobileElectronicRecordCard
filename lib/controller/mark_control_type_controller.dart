import 'package:flutter_logcat/log/log.dart';

import '../client/impl/mark_control_type_http_client_impl.dart';
import '../model/entity/mark_control_type_entity.dart';
import '../model/model.dart';
import '../repository/impl/mark_control_type_repository_impl.dart';
import '../repository/mark_control_type_repository.dart';
import '../service/mapper/impl/mark_control_type_mapper.dart';
import '../service/mapper/mapper.dart';

class MarkControlTypeController {
  Future<List<MarkControlTypeEntity>> get markControlTypes => getAllFromDb();

  Future<void> getAllFromServer() {
    return MarkControlTypeHttpClientImpl()
        .getAll()
        .then((value) => setAllToDb(value)
            .then((value) =>
                Log.i('Data received into db', tag: 'mark_control_type_controller'))
            .catchError((e) => Log.e(e, tag: 'mark_control_type_controller')))
        .catchError((e) => Log.e(e, tag: 'mark_control_type_controller'));
  }

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
