import 'package:mobile_electronic_record_card/model/entity/mark_entity.dart';
import 'package:mobile_electronic_record_card/model/model.dart';
import 'package:mobile_electronic_record_card/repository/impl/control_type_repository_impl.dart';
import 'package:mobile_electronic_record_card/repository/impl/mark_repository_impl.dart';
import 'package:mobile_electronic_record_card/repository/mark_repository.dart';
import 'package:mobile_electronic_record_card/service/mapper/impl/mark_mapper.dart';
import 'package:mobile_electronic_record_card/service/mapper/mapper.dart';

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

  Future<void> setAllToDb(List<MarkEntity> marks) async {
    MarkRepository markRepository = MarkRepositoryImpl();
    for (var e in marks) {
      markRepository.save(MarkMapper().toModel(e));
    }
  }
}
