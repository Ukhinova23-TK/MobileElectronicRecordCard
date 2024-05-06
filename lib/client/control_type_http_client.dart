import '../model/entity/control_type_entity.dart';

abstract class ControlTypeHttpClient {
  Future<List<ControlTypeEntity>> getAll();
}
