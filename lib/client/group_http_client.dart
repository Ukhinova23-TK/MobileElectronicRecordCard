import 'package:mobile_electronic_record_card/model/entity/group_entity.dart';

abstract class GroupHttpClient {
  Future<List<GroupEntity>> getAll();
}
