import 'package:mobile_electronic_record_card/model/model.dart';

abstract class GroupRepository {
  Future<int?> save(Student_group studentGroup);

  Future<List<Student_group>> getAll();

  Future<Student_group?> get(int id);

  Future<void> delete(int id);

  Future<void> deleteAll();
}