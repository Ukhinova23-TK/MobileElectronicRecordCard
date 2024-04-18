import 'package:mobile_electronic_record_card/model/model.dart';

import '../role_repository.dart';

class RoleRepositoryImpl implements RoleRepository {
  @override
  Future<Role?> get(int id) async {
    return await Role()
        .getById(id);
  }

  @override
  Future<List<Role>> getAll() async {
    return await Role()
        .select()
        .toList();
  }

  @override
  Future<Role?> getByName(String name) async {
    return await Role()
        .select()
        .where('name=$name')
        .toSingle();
  }
}