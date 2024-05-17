import 'package:flutter_logcat/log/log.dart';

import '../client/impl/mark_http_client_impl.dart';
import '../model/entity/mark_entity.dart';
import '../model/model.dart';
import '../repository/impl/control_type_repository_impl.dart';
import '../repository/impl/mark_repository_impl.dart';
import '../repository/mark_repository.dart';
import '../service/mapper/impl/mark_mapper.dart';
import '../service/mapper/mapper.dart';

class MarkController {
  Future<List<MarkEntity>> get marks => getAllFromDb();

  Future<MarkEntity?> get(int id) async {
    Mapper<MarkEntity, Mark> markMapper = MarkMapper();
    Mark? mark = await MarkRepositoryImpl().get(id);
    if(mark != null){
      return markMapper.toEntity(mark);
    }
    return null;
  }

  Future<List<MarkEntity>> getAllFromDb() async {
    Mapper<MarkEntity, Mark> markMapper = MarkMapper();
    return (await MarkRepositoryImpl().getAll())
        .map((mark) => markMapper.toEntity(mark))
        .toList();
  }

  Future<List<MarkEntity>?> getByControlTypeFromDb(int id) async {
    Mapper<MarkEntity, Mark> markMapper = MarkMapper();
    return (await ControlTypeRepositoryImpl().getMarks(id))
        ?.map((mark) => markMapper.toEntity(mark))
        .toList();
  }

  Future<List<MarkEntity>?> getByGroupAndSubjectFromDb(
      int groupId, int subjectId) async {
    Mapper<MarkEntity, Mark> markMapper = MarkMapper();
    return (await ControlTypeRepositoryImpl()
            .getMarksByGroupAndSubject(groupId, subjectId))
        ?.map((mark) => markMapper.toEntity(mark))
        .toList();
  }

  Future<void> getAllFromServer() {
    return MarkHttpClientImpl()
        .getAll()
        .then((value) => setAllToDb(value)
            .then((value) =>
                Log.i('Data received into db', tag: 'mark_controller'))
            .catchError((e) => Log.e(e, tag: 'mark_controller')))
        .catchError((e) => Log.e(e, tag: 'mark_controller'));
  }

  Future<void> setAllToDb(List<MarkEntity> marks) async {
    MarkRepository markRepository = MarkRepositoryImpl();
    for (var e in marks) {
      markRepository.save(MarkMapper().toModel(e));
    }
  }
}
