import 'package:mobile_electronic_record_card/model/model.dart';

abstract class SubjectRepository {
  Future<int?> save(Subject subject);

  Future<List<Subject>> getAll();

  Future<Subject?> get(int id);

  Future<void> delete(int id);
}