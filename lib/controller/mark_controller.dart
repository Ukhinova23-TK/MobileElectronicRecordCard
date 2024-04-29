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

  Future<void> synchronization () async {
    await getAllFromServer().then((value) =>
        setAllToDb(value)
            .then((value) =>
            Log.i('Data received into db', tag: 'mark_controller'))
            .catchError((e) => Log.e(e, tag: 'mark_controller')))
        .catchError((e) => Log.e(e, tag: 'mark_controller'));
  }

  Future<List<MarkEntity>> getAllFromDb () async {
    Mapper<MarkEntity, Mark> markMapper = MarkMapper();
    return (await MarkRepositoryImpl().getAll())
        .map((mark) => markMapper.toEntity(mark)).toList();
  }

  Future<List<MarkEntity>?> getByControlTypeFromDb (int id) async {
    Mapper<MarkEntity, Mark> markMapper = MarkMapper();
    return (await ControlTypeRepositoryImpl().getMarks(id))
        ?.map((mark) =>
        markMapper.toEntity(mark)).toList();
  }

  Future<List<MarkEntity>> getAllFromServer () {
    return MarkHttpClientImpl().getAll();
  }

  Future<void> setAllToDb (List<MarkEntity> marks) async {
    MarkRepository markRepository = MarkRepositoryImpl();
    for (var e in marks) {
      markRepository
            .save(MarkMapper().toModel(e));
    }
  }
}