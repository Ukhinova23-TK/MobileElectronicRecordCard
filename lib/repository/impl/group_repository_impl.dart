import 'package:mobile_electronic_record_card/model/model.dart';

import '../group_repository.dart';

class GroupRepositoryImpl implements GroupRepository {
  @override
  Future<void> delete(int id) async {
    await Student_group().select().id.equals(id).delete();
  }

  @override
  Future<Student_group?> get(int id) async {
    return await Student_group().getById(id);
  }

  @override
  Future<List<Student_group>> getAll() async {
    return await Student_group().select().toList();
  }

  @override
  Future<int?> save(Student_group studentGroup) async {
    return await studentGroup.save();
  }

  @override
  Future<void> deleteAll() async {
    await Student_group().select().delete();
  }

  @override
  Future<int>? getMaxVersion() async {
    List<Student_group> studentGroups =
        await Student_group().select().orderByDesc('version').toList();
    if (studentGroups.isEmpty) {
      return 0;
    } else {
      List<int> versions = [];
      for (var element in studentGroups) {
        versions.add(element.version ?? 0);
      }
      versions.sort();
      return versions.last;
    }
  }
}
