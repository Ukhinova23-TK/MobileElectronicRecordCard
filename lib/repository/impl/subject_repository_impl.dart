import 'package:mobile_electronic_record_card/model/model.dart';

import '../subject_repository.dart';

class SubjectRepositoryImpl implements SubjectRepository {
  @override
  Future<void> delete(int id) async {
    await Subject()
        .select()
        .id
        .equals(id)
        .delete();
  }

  @override
  Future<Subject?> get(int id) async {
    return await Subject()
        .getById(id);
  }

  @override
  Future<List<Subject>> getAll() async {
    return await Subject()
        .select()
        .toList();
  }

  @override
  Future<int?> save(Subject subject) async {
    return await subject
        .save();
  }

  @override
  Future<void> deleteAll() async {
     await Subject()
         .select()
         .delete();
  }

}