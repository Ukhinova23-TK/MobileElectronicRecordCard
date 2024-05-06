import 'package:mobile_electronic_record_card/model/model.dart';
import 'package:sqfentity_gen/sqfentity_gen.dart';

abstract class MarkControlTypeRepository {
  Future<BoolResult?> save(Mark_control_type mark);

  Future<List<Mark_control_type>> getAll();

  Future<Mark_control_type?> get(int markId, int controlTypeId);

  Future<void> delete(int markId, int controlTypeId);

  Future<void> deleteAll();
}
