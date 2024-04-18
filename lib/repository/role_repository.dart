import 'package:mobile_electronic_record_card/model/model.dart';

abstract class RoleRepository{
  Future<List<Role>> getAll();

  Future<Role?> get(int id);

  Future<Role?> getByName(String name);
}