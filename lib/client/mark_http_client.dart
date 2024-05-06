import 'package:mobile_electronic_record_card/model/entity/mark_entity.dart';

abstract class MarkHttpClient {
  Future<List<MarkEntity>> getAll();
}
