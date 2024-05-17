import 'package:app_bar_with_search_switch/app_bar_with_search_switch.dart';
import 'package:flutter/material.dart';
import 'package:mobile_electronic_record_card/controller/control_type_controller.dart';
import 'package:mobile_electronic_record_card/controller/group_controller.dart';
import 'package:mobile_electronic_record_card/controller/mark_control_type_controller.dart';
import 'package:mobile_electronic_record_card/controller/mark_controller.dart';
import 'package:mobile_electronic_record_card/controller/role_controller.dart';
import 'package:mobile_electronic_record_card/controller/student_mark_controller.dart';
import 'package:mobile_electronic_record_card/controller/subject_controller.dart';
import 'package:mobile_electronic_record_card/controller/user_controller.dart';
import 'package:mobile_electronic_record_card/controller/user_subject_control_type_controller.dart';
import 'package:mobile_electronic_record_card/data/constants/api_constants.dart';
import 'package:mobile_electronic_record_card/model/entity/subject_entity.dart';
import 'package:mobile_electronic_record_card/page/bottom_nav_bar_choose.dart';
import 'package:mobile_electronic_record_card/page/teacher/group_page.dart';
import 'package:mobile_electronic_record_card/provider/subject_provider.dart';
import 'package:mobile_electronic_record_card/repository/impl/control_type_repository_impl.dart';
import 'package:mobile_electronic_record_card/repository/impl/group_repository_impl.dart';
import 'package:mobile_electronic_record_card/repository/impl/mark_control_type_repository_impl.dart';
import 'package:mobile_electronic_record_card/repository/impl/mark_repository_impl.dart';
import 'package:mobile_electronic_record_card/repository/impl/role_repository_impl.dart';
import 'package:mobile_electronic_record_card/repository/impl/student_mark_repository_impl.dart';
import 'package:mobile_electronic_record_card/repository/impl/subject_repository_impl.dart';
import 'package:mobile_electronic_record_card/repository/impl/user_repository_impl.dart';
import 'package:mobile_electronic_record_card/repository/impl/user_subject_control_type_repository_impl.dart';
import 'package:provider/provider.dart';

class SubjectPage extends StatefulWidget {
  final int? selectedItemNavBar;
  final bool? bottomNavBar;

  const SubjectPage({this.selectedItemNavBar, this.bottomNavBar, super.key});

  @override
  State<StatefulWidget> createState() {
    return SubjectPageState();
  }
}

class SubjectPageState extends State<SubjectPage> {
  final searchText = ValueNotifier<String>('');
  late int _selectedIndex;
  late bool bottomNavBar;

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.selectedItemNavBar ?? 0;
    bottomNavBar = widget.bottomNavBar ?? false;
    Provider.of<SubjectProvider>(context, listen: false).initSubjects();
    //delete();
    data();
  }

  void data() async {
    await SubjectController().getAllFromServer();
    await ControlTypeController().getAllFromServer();
    await MarkController().getAllFromServer();
    await MarkControlTypeController().getAllFromServer();
    await GroupController().getAllFromServer();
    await RoleController().getAllFromServer();
    await UserController().getAllFromServer();
    await UserSubjectControlTypeController().getAllFromServer();
    await StudentMarkController().getAllFromServer();
  }

  void delete() async {
    await SubjectRepositoryImpl().deleteAll();
    await ControlTypeRepositoryImpl().deleteAll();
    await MarkRepositoryImpl().deleteAll();
    await MarkControlTypeRepositoryImpl().deleteAll();
    await GroupRepositoryImpl().deleteAll();
    await RoleRepositoryImpl().deleteAll();
    await UserRepositoryImpl().deleteAll();
    await UserSubjectControlTypeRepositoryImpl().deleteAll();
    await StudentMarkRepositoryImpl().deleteAll();
  }

  @override
  Widget build(BuildContext context) {
    const title = titleSubjectPage;
    return ChangeNotifierProvider(
        create: (_) => null,
        child: Scaffold(
          appBar: AppBarWithSearchSwitch(
            onChanged: (text) {
              searchText.value = text;
              setState(() {
                Provider.of<SubjectProvider>(context, listen: false)
                    .fetchSubjects();
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
          body: Consumer<SubjectProvider>(
              builder: (context, subjectProvider, _) =>
                  buildFutureBuilder(subjectProvider)),
          bottomNavigationBar: buildBottomNavigationBar(),
        ));
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

  FutureBuilder<List<SubjectEntity>> buildFutureBuilder(
      SubjectProvider subjectProvider) {
    return FutureBuilder(
      future: subjectProvider.subjects,
      builder: (context, snapshot) {
        return search(snapshot);
      },
    );
  }

  ListView search(AsyncSnapshot<List<SubjectEntity>> snapshot) {
    List<SubjectEntity> list = [];
    if (searchText.value == '') {
      snapshot.data?.forEach((e) => list.add(e));
      return buildListView(list);
    }
    if (snapshot.hasData) {
      list = snapshot.data!
          .where((e) =>
              e.name!.toLowerCase().contains(searchText.value.toLowerCase()))
          .toList();
    }
    return buildListView(list);
  }

  ListView buildListView(List<SubjectEntity> snapshot) {
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
                onTap: () async {
                  await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          GroupPage(subjectId: snapshot[index].id ?? 0),
                    ),
                  );
                });
          });
    }
  }
}
