// ignore_for_file: avoid_function_literals_in_foreach_calls

import 'package:mobile_electronic_record_card/client/impl/control_type_http_client_impl.dart';
import 'package:mobile_electronic_record_card/model/model.dart';
import 'package:mobile_electronic_record_card/service/mapper/impl/control_type_mapper.dart';

import '../repository/control_type_repository.dart';
import '../repository/impl/control_type_repository_impl.dart';

class ControlTypeSynchronizationService {

  static Future<List<Control_type>> getControlTypes() async {
    ControlTypeRepository repository = ControlTypeRepositoryImpl();
    ControlTypeHttpClientImpl().getAll().then((value) =>
    {
      value.forEach((element) async {
        await repository.save(ControlTypeMapper().toModel(element));
        })
    });
    return await repository.getAll();
  }
}