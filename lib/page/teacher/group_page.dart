import 'package:app_bar_with_search_switch/app_bar_with_search_switch.dart';
import 'package:flutter/material.dart';
import 'package:mobile_electronic_record_card/constants/api_constants.dart';
import 'package:mobile_electronic_record_card/controller/control_type_controller.dart';
import 'package:mobile_electronic_record_card/controller/group_controller.dart';
import 'package:mobile_electronic_record_card/model/entity/control_type_entity.dart';
import 'package:mobile_electronic_record_card/model/entity/group_entity.dart';
import 'package:mobile_electronic_record_card/page/teacher/subject_page.dart';

import '../student/record_card_page.dart';

class GroupPage extends StatefulWidget {
  int? selectedItemNavBar;

  GroupPage({this.selectedItemNavBar, super.key});

  @override
  State<StatefulWidget> createState() {
    return GroupPageState();
  }
}

class GroupPageState extends State<GroupPage> {
  Future<List<GroupEntity>>? groups;
  final searchText = ValueNotifier<String>('');
  late int _selectedIndex;

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.selectedItemNavBar ?? 0;
    groups = GroupController().groups;
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
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.work_outline),
              label: 'Преподаватель'
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.school_outlined),
              label: 'Студент'
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: greatMarkColor,
        onTap: _onItemTapped,
      ),
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      switch(index){
        case 0: {
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (context) => SubjectPage(
                    selectedItemNavBar: _selectedIndex
                ),
              ),
              (Route<dynamic> route) => false
          );
        }
        case 1: {
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (context) => RecordCardPage(
                    selectedItemNavBar: _selectedIndex
                ),
              ),
              (Route<dynamic> route) => false
          );
        }
      }
    });
  }

  FutureBuilder<List<GroupEntity>> buildFutureBuilder() {
    return FutureBuilder(
      future: groups,
      builder: (context, snapshot) {
        return search(snapshot);
      },
    );
  }

  ListView search (AsyncSnapshot<List<GroupEntity>> snapshot) {
    List<GroupEntity> list = [];
    if(searchText.value == ''){
      snapshot.data?.forEach((e) => list.add(e));
      return buildListView(list);
    }
    if(snapshot.hasData) {
      snapshot.data?.forEach((e) {
        if (e.name!.toLowerCase().contains(searchText.value.toLowerCase())
            || ((e.fullName != null)
                && (e.fullName!.toLowerCase()
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
                snapshot[index].name ?? "",
                snapshot[index].fullName ?? ""
            );
          }
      );
    }
  }

  synchronization() {
    GroupController().synchronization().then((_) =>
    {
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
