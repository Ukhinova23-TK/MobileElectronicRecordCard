import 'package:mobile_electronic_record_card/controller/delete_controller.dart';
import 'package:mobile_electronic_record_card/model/entity/subject_entity.dart';
import 'package:mobile_electronic_record_card/model/model.dart';
import 'package:mobile_electronic_record_card/repository/impl/subject_repository_impl.dart';
import 'package:mobile_electronic_record_card/repository/subject_repository.dart';
import 'package:mobile_electronic_record_card/service/mapper/impl/subject_mapper.dart';
import 'package:mobile_electronic_record_card/service/mapper/mapper.dart';

class SubjectController implements DeleteController {

  Future<List<SubjectEntity>> get subjects => getAllFromDb();

  Future<List<SubjectEntity>> getAllFromDb() async {
    Mapper<SubjectEntity, Subject> subjectMapper = SubjectMapper();
    return (await SubjectRepositoryImpl().getAll())
        .map((subject) => subjectMapper.toEntity(subject))
        .toList();
  }

  Future<void> setAllToDb(List<SubjectEntity> subjects) async {
    SubjectRepository subjectRepository = SubjectRepositoryImpl();
    for (var e in subjects) {
      subjectRepository.save(SubjectMapper().toModel(e));
    }
  }

  Future<List<SubjectEntity>> getByTeacher(int userId) async {
    Mapper<SubjectEntity, Subject> subjectMapper = SubjectMapper();
    return (await SubjectRepositoryImpl().getByTeacher(userId))
        .map((subject) => subjectMapper.toEntity(subject))
        .toList();
  }

  @override
  Future<void> delete(int id) async {
    await SubjectRepositoryImpl().delete(id);
  }

  Future<void> deleteAll() async {
    await SubjectRepositoryImpl().deleteAll();
  }
}
