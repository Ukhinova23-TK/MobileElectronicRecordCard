import 'package:mobile_electronic_record_card/model/model.dart';

import '../student_mark_repository.dart';

class StudentMarkRepositoryImpl implements StudentMarkRepository {
  @override
  Future<void> delete(int id) async {
    await Student_mark().select().id.equals(id).delete();
  }

  @override
  Future<Student_mark?> get(int id) async {
    return await Student_mark().getById(id);
  }

  @override
  Future<List<Student_mark>> getAll() async {
    return await Student_mark().select().toList();
  }

  @override
  Future<int?> save(Student_mark studentMark) async {
    return await studentMark.save();
  }

  @override
  Future<void> deleteAll() async {
    await Student_mark().select().delete();
  }

  @override
  Future<int>? getMaxVersion() async {
    List<Student_mark> studentMarks =
        await Student_mark().select().orderByDesc('version').toList();
    List<int> versions = [];
    for (var element in studentMarks) {
      versions.add(element.version ?? 0);
    }
    versions.sort();
    return versions.last;
  }
}
