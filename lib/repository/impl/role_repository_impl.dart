import 'package:mobile_electronic_record_card/model/model.dart';

import '../role_repository.dart';

class RoleRepositoryImpl implements RoleRepository {
  @override
  Future<Role?> get(int id) async {
    return await Role().getById(id);
  }

  @override
  Future<List<Role>> getAll() async {
    return await Role().select().toList();
  }

  @override
  Future<Role?> getByName(String name) async {
    return await Role().select().where('name=$name').toSingle();
  }

  @override
  Future<List<User>?> getUsers(int id) async {
    return await Role().getUsers()?.where('user_id=$id').toList();
  }

  @override
  Future<void> deleteAll() async {
    await Role().select().delete();
  }

  @override
  Future<int?> save(Role role) async {
    return await role.save();
  }

  @override
  Future<Role?> getByUserId(int id) async {
    return await Role()
        .select(columnsToSelect: ["name"])
        .where('id=$id')
        .toSingle();
  }
}
