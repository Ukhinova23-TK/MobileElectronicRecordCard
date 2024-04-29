import '../client/impl/user_http_client_impl.dart';
import '../model/model.dart';
import '../repository/impl/user_repository_impl.dart';
import '../repository/user_repository.dart';
import 'mapper/impl/user_mapper.dart';

class UserSynchronizationService {

  static Future<List<User>> getUsers() async {
    UserRepository repository = UserRepositoryImpl();
    UserHttpClientImpl().getAll().then((value) => {
      value.forEach((element) async {
        await repository.save(UserMapper().toModel(element));
      })
    });
    return await repository.getAll();
  }
}