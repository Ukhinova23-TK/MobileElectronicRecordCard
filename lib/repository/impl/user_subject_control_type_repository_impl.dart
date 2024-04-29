import 'package:mobile_electronic_record_card/model/model.dart';

import '../user_subject_control_type_repository.dart';

class UserSubjectControlTypeRepositoryImpl implements UserSubjectControlTypeRepository {
  @override
  Future<void> delete(int id) async {
    await User_subject_control_type()
        .select()
        .id
        .equals(id)
        .delete();
  }

  @override
  Future<User_subject_control_type?> get(int id) async {
    return await User_subject_control_type()
        .getById(id);
  }

  @override
  Future<List<User_subject_control_type>> getAll() async {
    return await User_subject_control_type()
        .select()
        .toList();
  }

  @override
  Future<int?> save(User_subject_control_type userSubjectControlType) async {
    return await userSubjectControlType
        .save();
  }

  @override
  Future<void> deleteAll() async {
    await User_subject_control_type()
        .select()
        .delete();
  }

}