import 'package:app_bar_with_search_switch/app_bar_with_search_switch.dart';
import 'package:flutter/material.dart';
import 'package:flutter_logcat/flutter_logcat.dart';
import 'package:mobile_electronic_record_card/constants/api_constants.dart';
import 'package:mobile_electronic_record_card/controller/control_type_controller.dart';
import 'package:mobile_electronic_record_card/controller/group_controller.dart';
import 'package:mobile_electronic_record_card/model/entity/control_type_entity.dart';
import 'package:mobile_electronic_record_card/model/entity/group_entity.dart';
import 'package:mobile_electronic_record_card/page/bottom_nav_bar_choose.dart';
import 'package:mobile_electronic_record_card/page/teacher/subject_page.dart';

import '../student/record_card_page.dart';

class GroupPage extends StatefulWidget {
  int? selectedItemNavBar;
  bool? bottomNavBar;

  GroupPage({this.selectedItemNavBar, this.bottomNavBar, super.key});

  @override
  State<StatefulWidget> createState() {
    return GroupPageState();
  }
}

class GroupPageState extends State<GroupPage> {
  Future<List<GroupEntity>>? groups;
  final searchText = ValueNotifier<String>('');
  late int _selectedIndex;
  late bool bottomNavBar;

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.selectedItemNavBar ?? 0;
    bottomNavBar = widget.bottomNavBar ?? false;
    groups = GroupController().groups.catchError((onError) {
      Log.e('Ошибка загрузки данных', tag: 'group_page');
      ScaffoldMessenger.of(context)
        ..removeCurrentSnackBar()
        ..showSnackBar(const SnackBar(content: Text('Ошибка загрузки данных')));
    });
  }

  @override
  Widget build(BuildContext context) {
    const title = titleGroupPage;

    return Scaffold(
      appBar: AppBarWithSearchSwitch(
        onChanged: (text) {
          searchText.value = text;
          setState(() {
            groups = GroupController().groups;
          });
        },
        appBarBuilder: (context) {
          return AppBar(
            backgroundColor: appbarColor,
            title: const Text(title),
            actions: [
              const AppBarSearchButton(
                buttonHasTwoStates: false,
              ),
              IconButton(
                onPressed: () => synchronization(),
                icon: const Icon(Icons.access_time),
              )
            ],
          );
        },
      ),
      body: buildFutureBuilder(),
      bottomNavigationBar: buildBottomNavigationBar(),
    );
  }

  BottomNavigationBar? buildBottomNavigationBar() {
    if (bottomNavBar) {
      return BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.work_outline), label: 'Преподаватель'),
          BottomNavigationBarItem(
              icon: Icon(Icons.school_outlined), label: 'Студент'),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: greatMarkColor,
        onTap: _onItemTapped,
      );
    } else {
      return null;
    }
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    BottomNavBarChoose(
            index: index, context: context, bottomNavBar: bottomNavBar)
        .changeItem();
  }

  FutureBuilder<List<GroupEntity>> buildFutureBuilder() {
    return FutureBuilder(
      future: groups,
      builder: (context, snapshot) {
        return search(snapshot);
      },
    );
  }

  ListView search(AsyncSnapshot<List<GroupEntity>> snapshot) {
    List<GroupEntity> list = [];
    if (searchText.value == '') {
      snapshot.data?.forEach((e) => list.add(e));
      return buildListView(list);
    }
    if (snapshot.hasData) {
      snapshot.data?.forEach((e) {
        if (e.name!.toLowerCase().contains(searchText.value.toLowerCase()) ||
            ((e.fullName != null) &&
                (e.fullName!
                    .toLowerCase()
                    .contains(searchText.value.toLowerCase())))) {
          list.add(e);
        }
      });
    }
    return buildListView(list);
  }

  ListView buildListView(List<GroupEntity> snapshot) {
    if (snapshot.isEmpty) {
      return ListView.builder(
          itemCount: 1,
          itemBuilder: (context, index) {
            return const ListTile(
              title: Text("Нет данных"),
            );
          });
    } else {
      return ListView.builder(
          itemCount: snapshot.length,
          itemBuilder: (context, index) {
            return GroupList(
                snapshot[index].name ?? "", snapshot[index].fullName ?? "");
          });
    }
  }

  synchronization() {
    GroupController().synchronization().then((_) => {
          setState(() {
            groups = GroupController().groups;
          })
        });
  }
}

class GroupList extends StatelessWidget {
  const GroupList(this.name, this.fullName, {super.key});
  final String name;
  final String fullName;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(name),
      subtitle: Text(fullName),
    );
  }
}
