import 'package:mobile_electronic_record_card/model/model.dart';

abstract class MarkRepository{
  Future<int?> save(Mark mark);

  Future<List<Mark>> getAll();

  Future<Mark?> get(int id);

  Future<void> delete(int id);

  Future<void> deleteAll();

  Future<int>? getMaxVersion();
}