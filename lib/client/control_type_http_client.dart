import '../model/entity/control_type_entity.dart';

abstract class ControlTypeHttpClient {
  Future<List<ControlTypeEntity>> getAll();

  Future<ControlTypeEntity> getById(int id);

  Future<ControlTypeEntity> getByName(String name);
}