import 'package:mobile_electronic_record_card/model/model.dart';

import '../control_type_repository.dart';

class ControlTypeRepositoryImpl implements ControlTypeRepository {

  @override
  Future<int?> save(Control_type controlType) async {
    return await controlType
        .save();
  }

  @override
  Future<void> delete(int id) async {
    await Control_type()
        .select()
        .id
        .equals(id)
        .delete();
  }

  @override
  Future<Control_type?> getControlType(int id) async {
    return await Control_type()
        .getById(id);
  }
  
  @override
  Future<List<Mark>?> getMarks(int id) async {
    return await Control_type()
        .getMarks()
        ?.where('id=$id')
        .toList();
  }

  @override
  Future<List<Control_type>> getAll() async {
    return await Control_type()
        .select()
        .toList();
  }
}