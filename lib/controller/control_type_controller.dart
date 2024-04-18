import 'package:mobile_electronic_record_card/model/model.dart';
import 'package:mobile_electronic_record_card/repository/control_type_repository.dart';
import 'package:mobile_electronic_record_card/service/control_type_synchronization_service.dart';

import '../client/impl/control_type_http_client_impl.dart';
import '../model/entity/control_type_entity.dart';
import '../repository/impl/control_type_repository_impl.dart';
import '../service/mapper/impl/control_type_mapper.dart';
import '../service/mapper/mapper.dart';

class ControlTypeController {
  final List<ControlTypeEntity> _controlTypes = <ControlTypeEntity>[];

  Future<List<ControlTypeEntity>> get groups => fromDb();

  Future<void> synchronization () async {
    await fromServer().then((value) => toDb(value)
        .then((value) => fromDb()
        .then((_) => print('Data received'))));
  }

  Future<List<ControlTypeEntity>> fromDb () async {
    Mapper<ControlTypeEntity, Control_type> controlTypeMapper = ControlTypeMapper();
    return (await ControlTypeRepositoryImpl().getAll())
        .map((controlType) => controlTypeMapper.toEntity(controlType)).toList();
  }

  Future<List<ControlTypeEntity>> fromServer () {
    // Получаем данные с сервера
    return ControlTypeHttpClientImpl().getAll() ;
  }

  Future<void> toDb(List<ControlTypeEntity> controlTypes) async {
    ControlTypeRepository controlTypeRepository = ControlTypeRepositoryImpl();
    // Сохраняем данные в локальную БД
    ControlTypeHttpClientImpl().getAll().then((value) =>
        value.map((e) => controlTypeRepository
            .save(ControlTypeMapper().toModel(e))));
  }

}