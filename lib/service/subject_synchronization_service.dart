import '../client/impl/subject_http_client_impl.dart';
import '../model/model.dart';
import '../repository/impl/subject_repository_impl.dart';
import '../repository/subject_repository.dart';
import 'mapper/impl/subject_mapper.dart';

class SubjectSynchronizationService {

  static Future<List<Subject>> getSubjects() async {
    SubjectRepository repository = SubjectRepositoryImpl();
    SubjectHttpClientImpl().getAll().then((value) => {
      value.forEach((element) async {
        await repository.save(SubjectMapper().toModel(element));
      })
    });
    return await repository.getAll();
  }
}