import 'package:mobile_electronic_record_card/model/entity/mark_control_type_entity.dart';

abstract class MarkControlTypeHttpClient {
  Future<List<MarkControlTypeEntity>> getAll();
}