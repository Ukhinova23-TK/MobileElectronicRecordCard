import 'package:mobile_electronic_record_card/model/entity/deletion_entity.dart';

abstract class DeletionHttpClient {
  Future<List<DeletionEntity>> getAll();
}