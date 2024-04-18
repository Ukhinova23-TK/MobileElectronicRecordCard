import '../model/entity/group_entity.dart';

class GroupController {
  final _groups = <GroupEntity>[];

  List<GroupEntity> get groups => List.unmodifiable(_groups);


}