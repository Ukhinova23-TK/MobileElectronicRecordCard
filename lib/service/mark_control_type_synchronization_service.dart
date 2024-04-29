import 'package:mobile_electronic_record_card/client/impl/mark_control_type_http_client_impl.dart';
import 'package:mobile_electronic_record_card/model/model.dart';
import 'package:mobile_electronic_record_card/repository/impl/mark_control_type_repository_impl.dart';
import 'package:mobile_electronic_record_card/repository/mark_control_type_repository.dart';
import 'package:mobile_electronic_record_card/service/mapper/impl/mark_control_type_mapper.dart';

class MarkControlTypeSynchronizationService {
  static Future<List<Mark_control_type>> getMarks() async {
    MarkControlTypeRepository repository = MarkControlTypeRepositoryImpl();
    MarkControlTypeHttpClientImpl().getAll().then((value) => {
      value.forEach((element) async {
        await repository.save(MarkControlTypeMapper().toModel(element));
      })
    });
    return await repository.getAll();
  }
}