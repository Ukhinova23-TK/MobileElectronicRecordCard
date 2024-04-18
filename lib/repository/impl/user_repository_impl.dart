import 'package:mobile_electronic_record_card/model/model.dart';
import 'package:mobile_electronic_record_card/repository/user_repository.dart';

class UserRepositoryImpl implements UserRepository{
  @override
  Future<void> delete(int id) async {
    await User()
        .select()
        .id
        .equals(id)
        .delete();
  }

  @override
  Future<User?> get(int id) async {
    return await User()
        .getById(id);
  }

  @override
  Future<List<User>> getAll() async {
    return await User()
        .select()
        .toList();
  }

  @override
  Future<int?> save(User user) async {
    return await User()
        .save();
  }

}