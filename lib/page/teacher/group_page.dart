import 'package:app_bar_with_search_switch/app_bar_with_search_switch.dart';
import 'package:flutter/material.dart';
import 'package:mobile_electronic_record_card/data/constants/api_constants.dart';
import 'package:mobile_electronic_record_card/model/entity/group_entity.dart';
import 'package:mobile_electronic_record_card/page/bottom_nav_bar_choose.dart';
import 'package:mobile_electronic_record_card/page/teacher/student_mark_page.dart';
import 'package:mobile_electronic_record_card/provider/group_provider.dart';
import 'package:provider/provider.dart';

class GroupPage extends StatefulWidget {
  final int? selectedItemNavBar;
  final bool? bottomNavBar;
  final int subjectId;

  const GroupPage(
      {required this.subjectId,
      this.selectedItemNavBar,
      this.bottomNavBar,
      super.key});

  @override
  State<StatefulWidget> createState() {
    return GroupPageState();
  }
}

class GroupPageState extends State<GroupPage> {
  final searchText = ValueNotifier<String>('');
  late int _selectedIndex;
  late bool _bottomNavBar;
  late int _subjectId;

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.selectedItemNavBar ?? 0;
    _bottomNavBar = widget.bottomNavBar ?? false;
    _subjectId = widget.subjectId;
    Provider.of<GroupProvider>(context, listen: false).initGroups(_subjectId);
  }

  @override
  Widget build(BuildContext context) {
    const title = titleGroupPage;

    return ChangeNotifierProvider(
        create: (_) => null,
        child: Scaffold(
          appBar: AppBarWithSearchSwitch(
            onChanged: (text) {
              searchText.value = text;
              setState(() {
                Provider.of<GroupProvider>(context, listen: false)
                    .fetchGroups();
              });
            },
            appBarBuilder: (context) {
              return AppBar(
                backgroundColor: appbarColor,
                title: const Text(title),
                actions: const [
                  AppBarSearchButton(
                    buttonHasTwoStates: false,
                  )
                ],
              );
            },
          ),
          body: Consumer<GroupProvider>(
              builder: (context, groupProvider, _) =>
                  buildFutureBuilder(groupProvider)),
          bottomNavigationBar: buildBottomNavigationBar(),
        ));
  }

  BottomNavigationBar? buildBottomNavigationBar() {
    if (_bottomNavBar) {
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
            index: index, context: context, bottomNavBar: _bottomNavBar)
        .changeItem();
  }

  FutureBuilder<List<GroupEntity>> buildFutureBuilder(
      GroupProvider groupProvider) {
    return FutureBuilder(
      future: groupProvider.groups,
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
      list = snapshot.data!
          .where((e) =>
              e.name!.toLowerCase().contains(searchText.value.toLowerCase()) ||
              ((e.fullName != null) &&
                  (e.fullName!
                      .toLowerCase()
                      .contains(searchText.value.toLowerCase()))))
          .toList();
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
            return ListTile(
                title: Text(snapshot[index].name ?? ""),
                subtitle: Text(snapshot[index].fullName ?? ""),
                onTap: () async {
                  await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => StudentMarkPage(
                          subjectId: _subjectId,
                          groupId: snapshot[index].id ?? 0),
                    ),
                  );
                });
          });
    }
  }
}
