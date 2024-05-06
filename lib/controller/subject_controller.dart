import 'package:flutter_logcat/flutter_logcat.dart';

import '../client/impl/subject_http_client_impl.dart';
import '../model/entity/subject_entity.dart';
import '../model/model.dart';
import '../repository/impl/subject_repository_impl.dart';
import '../repository/subject_repository.dart';
import '../service/mapper/impl/subject_mapper.dart';
import '../service/mapper/mapper.dart';

class SubjectController {
  Future<List<SubjectEntity>> get subjects => getAllFromDb();

  Future<void> synchronization() async {
    await getAllFromServer()
        .then((value) => setAllToDb(value)
            .then((_) =>
                Log.i('Data received into db', tag: 'subject_controller'))
            .catchError((e) => Log.e(e, tag: 'subject_controller')))
        .catchError((e) => Log.e(e, tag: 'subject_controller'));
  }

  Future<List<SubjectEntity>> getAllFromDb() async {
    Mapper<SubjectEntity, Subject> subjectMapper = SubjectMapper();
    return (await SubjectRepositoryImpl().getAll())
        .map((subject) => subjectMapper.toEntity(subject))
        .toList();
  }

  Future<List<SubjectEntity>> getAllFromServer() {
    return SubjectHttpClientImpl().getAll();
  }

  Future<void> setAllToDb(List<SubjectEntity> subjects) async {
    SubjectRepository subjectRepository = SubjectRepositoryImpl();
    for (var e in subjects) {
      subjectRepository.save(SubjectMapper().toModel(e));
    }
  }
}
