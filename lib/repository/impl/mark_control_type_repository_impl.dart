import 'package:mobile_electronic_record_card/model/model.dart';
import 'package:sqfentity_gen/sqfentity_gen.dart';

import '../mark_control_type_repository.dart';

class MarkControlTypeRepositoryImpl implements MarkControlTypeRepository {
  @override
  Future<void> delete(int markId, int controlTypeId) async {
    await Mark_control_type()
        .select()
        .where('markId=$markId AND control_typeId=$controlTypeId')
        .delete();
  }

  @override
  Future<void> deleteAll() async {
    await Mark_control_type()
        .select()
        .delete();
  }

  @override
  Future<Mark_control_type?> get(int markId, int controlTypeId) async {
    return await Mark_control_type()
        .getById(controlTypeId, markId);
  }

  @override
  Future<List<Mark_control_type>> getAll() async {
    return await Mark_control_type()
        .select()
        .toList();
  }

  Future<List<Mark_control_type?>> getMarks(int controlTypeId) async {
    return await Mark_control_type()
        .select()
        .where('control_typeId = ${controlTypeId}')
        .toList();
  }

  @override
  Future<BoolResult?> save(Mark_control_type markControlType) async {
    return await markControlType
        .save();
  }

}