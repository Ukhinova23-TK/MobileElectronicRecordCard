import 'package:mobile_electronic_record_card/model/model.dart';
import 'package:mobile_electronic_record_card/repository/user_repository.dart';

class UserRepositoryImpl implements UserRepository {
  @override
  Future<void> delete(int id) async {
    await User().select().id.equals(id).delete();
  }

  @override
  Future<User?> get(int id) async {
    return await User().getById(id);
  }

  @override
  Future<List<User>> getAll() async {
    return await User().select().toList();
  }

  @override
  Future<int?> save(User user) async {
    return await user.save();
  }

  @override
  Future<void> deleteAll() async {
    await User().select().delete();
  }

  @override
  Future<List<Role>?> getRoles(int id) async {
    return await User().getRoles()?.where('id=$id').toList();
  }

  @override
  Future<int>? getMaxVersion() async {
    List<User> users = await User().select().orderByDesc('version').toList();
    if (users.isEmpty) {
      return 0;
    } else {
      List<int> versions = [];
      for (var element in users) {
        versions.add(element.version ?? 0);
      }
      versions.sort();
      return versions.last;
    }
  }
}
