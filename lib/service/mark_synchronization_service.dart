import '../client/impl/mark_http_client_impl.dart';
import '../model/model.dart';
import '../repository/impl/mark_repository_impl.dart';
import '../repository/mark_repository.dart';
import 'mapper/impl/mark_mapper.dart';

class MarkSynchronizationService {

  static Future<List<Mark>> getMarks() async {
    MarkRepository repository = MarkRepositoryImpl();
    MarkHttpClientImpl().getAll().then((value) => {
      value.forEach((element) async {
        await repository.save(MarkMapper().toModel(element));
      })
    });
    return await repository.getAll();
  }

}