import 'package:mobile_electronic_record_card/model/model.dart';

import '../mark_repository.dart';

class MarkRepositoryImpl implements MarkRepository {
  @override
  Future<void> delete(int id) async {
    await Mark()
        .select()
        .id
        .equals(id)
        .delete();
  }

  @override
  Future<Mark?> get(int id) async {
    return await Mark()
        .getById(id);
  }

  @override
  Future<List<Mark>> getAll() async {
    return await Mark()
        .select()
        .toList();
  }

  @override
  Future<int?> save(Mark mark) async {
    return await mark
        .save();
  }

  @override
  Future<void> deleteAll() async {
    await Mark()
        .select()
        .delete();
  }

}