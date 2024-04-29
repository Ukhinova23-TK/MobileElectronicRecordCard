import 'package:mobile_electronic_record_card/client/impl/role_http_client_impl.dart';
import 'package:mobile_electronic_record_card/repository/impl/role_repository_impl.dart';
import 'package:mobile_electronic_record_card/repository/role_repository.dart';

import '../model/model.dart';
import 'mapper/impl/role_mapper.dart';

class RoleSynchronizationService {

  static Future<List<Role>> getRoles() async {
    RoleRepository repository = RoleRepositoryImpl();
    RoleHttpClientImpl().getAll().then((value) => {
      value.forEach((element) async {
        await repository.save(RoleMapper().toModel(element));
      })
    });
    return await repository.getAll();
  }

}