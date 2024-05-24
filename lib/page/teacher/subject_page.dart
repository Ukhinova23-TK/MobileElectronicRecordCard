import 'package:app_bar_with_search_switch/app_bar_with_search_switch.dart';
import 'package:flutter/material.dart';
import 'package:mobile_electronic_record_card/data/constants/api_constants.dart';
import 'package:mobile_electronic_record_card/data/shared_preference/shared_preference_helper.dart';
import 'package:mobile_electronic_record_card/model/entity/subject_entity.dart';
import 'package:mobile_electronic_record_card/page/bottom_nav_bar_choose.dart';
import 'package:mobile_electronic_record_card/page/synchronization_function.dart';
import 'package:mobile_electronic_record_card/page/teacher/group_page.dart';
import 'package:mobile_electronic_record_card/provider/subject_provider.dart';
import 'package:mobile_electronic_record_card/service/locator/locator.dart';
import 'package:provider/provider.dart';

class SubjectPage extends StatefulWidget {
  final int? selectedItemNavBar;

  const SubjectPage({this.selectedItemNavBar, super.key});

  @override
  State<StatefulWidget> createState() {
    return SubjectPageState();
  }
}

class SubjectPageState extends State<SubjectPage> {
  final sharedLocator = getIt.get<SharedPreferenceHelper>();
  final searchText = ValueNotifier<String>('');
  late int _selectedIndex;
  late BottomNavBarChoose bottomNavBar;

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.selectedItemNavBar ?? 0;
    bottomNavBar = BottomNavBarChoose(context: context);
    Provider.of<SubjectProvider>(context, listen: false).initSubjects();
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
                actions: [
                  const AppBarSearchButton(
                    buttonHasTwoStates: false,
                  ),
                  IconButton(
                      icon: const Icon(Icons.refresh_outlined),
                      onPressed: () =>
                          synchronization().then((_) => setState(() {
                                Provider.of<SubjectProvider>(context,
                                        listen: false)
                                    .initSubjects();
                              }))),
                  IconButton(
                      icon: const Icon(Icons.logout_outlined),
                      onPressed: () => logout(context))
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
    List<BottomNavigationBarItem> bottomItems = bottomNavBar.getItems();
    if(bottomItems.isNotEmpty) {
      return BottomNavigationBar(
        items: bottomNavBar.getItems(),
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
    bottomNavBar.changeItem(index);
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
