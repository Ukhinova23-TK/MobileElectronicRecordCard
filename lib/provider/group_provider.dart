import 'package:flutter/material.dart';

import '../model/entity/group_entity.dart';

class GroupProvider extends InheritedWidget {
  final _groups = <GroupEntity>[];

  GroupProvider({super.key, required super.child});

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) {
    return false;
  }

  static List<GroupEntity>? of(BuildContext context){
    final provider = context.dependOnInheritedWidgetOfExactType<GroupProvider>();
    return provider?._groups;
  }
}