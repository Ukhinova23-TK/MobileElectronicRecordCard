import 'package:flutter/material.dart';
import 'package:mobile_electronic_record_card/data/constants/api_constants.dart';
import 'package:mobile_electronic_record_card/data/shared_preference/shared_preference_helper.dart';
import 'package:mobile_electronic_record_card/model/entity/teacher_subject_control_type_mark_semester_entity.dart';
import 'package:mobile_electronic_record_card/model/enumeration/mark_name.dart';
import 'package:mobile_electronic_record_card/page/bottom_nav_bar_choose.dart';
import 'package:mobile_electronic_record_card/page/student/qr_code_modal_window.dart';
import 'package:mobile_electronic_record_card/page/synchronization_function.dart';
import 'package:mobile_electronic_record_card/page/student/info_modal_window.dart';
import 'package:mobile_electronic_record_card/provider/user_subject_control_type_provider.dart';
import 'package:mobile_electronic_record_card/service/locator/locator.dart';
import 'package:provider/provider.dart';

class RecordCardPage extends StatefulWidget {
  final int? selectedItemNavBar;

  const RecordCardPage({this.selectedItemNavBar, super.key});

  @override
  State<RecordCardPage> createState() => _RecordCardPageState();
}

class _RecordCardPageState extends State<RecordCardPage> {
  final _sharedLocator = getIt.get<SharedPreferenceHelper>();
  late int _selectedIndex;
  late BottomNavBarChoose _bottomNavBar;
  int? _dropdownValue;

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.selectedItemNavBar ??
        (_sharedLocator.getRolesCount() == 2 ? 1 : 0);
    Provider.of<UserSubjectControlTypeProvider>(context, listen: false)
        .initUserSubjectsControlTypes(_sharedLocator.getUserId()!);
    _bottomNavBar = BottomNavBarChoose(context: context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context),
      body: Consumer<UserSubjectControlTypeProvider>(
          builder: (context, usctProvider, _) => FutureBuilder(
              future: usctProvider.userSubjectsControlTypes,
              builder: (context, snapshot) {
                if (snapshot.hasData && snapshot.data?.length != 0) {
                  List<int> dataUniqueSemester =
                      snapshot.data!.map((e) => e.semester).toSet().toList();
                  dataUniqueSemester.sort();
                  List<TeacherSubjectControlTypeMarkSemesterEntity> data =
                      snapshot.data!
                          .where((element) =>
                              element.semester ==
                              (_dropdownValue ?? dataUniqueSemester.first))
                          .toList();
                  return Column(children: [
                    _height(),
                    Row(
                      children: [
                        _width(),
                        DropdownMenu<int>(
                            initialSelection: dataUniqueSemester.first,
                            onSelected: (int? value) {
                              setState(() {
                                _dropdownValue = value;
                              });
                            },
                            dropdownMenuEntries: dataUniqueSemester
                                .map<DropdownMenuEntry<int>>((int value) {
                              return DropdownMenuEntry<int>(
                                  value: value,
                                  label: '${value.toString()} семестр');
                            }).toList()),
                      ],
                    ),
                    _height(),
                    Expanded(child:
                    ListView.builder(
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        itemCount: data.length,
                        itemBuilder: (context, index) {
                          return ListTile(
                            title: SizedBox(
                                width: MediaQuery.of(context).size.width * 0.6,
                                child: Text(
                                  data[index].subject.name ?? "",
                                  textAlign: TextAlign.left,
                                  textDirection: TextDirection.rtl,
                                )),
                            subtitle: SizedBox(
                                width: MediaQuery.of(context).size.width * 0.6,
                                child: Text(
                                  data[index].controlType.title ?? "",
                                  textAlign: TextAlign.left,
                                  textDirection: TextDirection.rtl,
                                )),
                            trailing: SizedBox(
                                width: MediaQuery.of(context).size.width * 0.4,
                                child: Text(
                                  data[index].mark?.title ?? "Нет оценки",
                                  textAlign: TextAlign.right,
                                  textDirection: TextDirection.ltr,
                                )),
                            tileColor: setColor(data[index].mark?.name),
                          );
                        })
                    ),
                  ]);
                } else {
                  return ListView.builder(
                      itemCount: 1,
                      itemBuilder: (context, index) {
                        return const ListTile(
                          title: Text("Нет данных"),
                        );
                      });
                }
              })),
      bottomNavigationBar: buildBottomNavigationBar(),
    );
  }

  AppBar buildAppBar(BuildContext context) {
    List<Widget> buttons = [];
    buttons.add(IconButton(
        onPressed: () => openQrModalWindow(),
        icon: const Icon(Icons.qr_code_2_outlined)));
    buttons.add(IconButton(
        onPressed: () =>
            Provider.of<UserSubjectControlTypeProvider>(context, listen: false)
                .userSubjectsControlTypes
                ?.then((value) => openInfoModalWindow(value)),
        icon: const Icon(Icons.percent_outlined)));
    buttons.add(IconButton(
        icon: const Icon(Icons.refresh_outlined),
        onPressed: () => synchronization().then((value) => setState(() {
              Provider.of<UserSubjectControlTypeProvider>(context)
                  .initUserSubjectsControlTypes(_sharedLocator.getUserId()!);
            }))));
    buttons.add(IconButton(
      icon: const Icon(Icons.logout_outlined),
      onPressed: () => logout(context),
    ));
    return AppBar(
      backgroundColor: appbarColor,
      title: const Text('Зачетка'),
      actions: buttons,
    );
  }

  Color? setColor(String? markName) {
    switch (markName) {
      case MarkName.excellent || MarkName.passed || MarkName.release:
        return greatMarkColor;
      case MarkName.good:
        return wellMarkColor;
      case MarkName.satisfactory:
        return satisfactoryMarkColor;
      case MarkName.unsatisfactory || MarkName.failed:
        return failMarkColor;
      default:
        return noMarkColor;
    }
  }

  BottomNavigationBar? buildBottomNavigationBar() {
    List<BottomNavigationBarItem> bottomItems = _bottomNavBar.getItems();
    if (bottomItems.isNotEmpty) {
      return BottomNavigationBar(
        items: _bottomNavBar.getItems(),
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
    _bottomNavBar.changeItem(index);
  }

  Future<void> openInfoModalWindow(
      List<TeacherSubjectControlTypeMarkSemesterEntity> list) {
    return showModalBottomSheet<void>(
      context: context,
      builder: (BuildContext context) {
        return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [InfoModalWindow(tsctms: list)]);
      },
    );
  }

  Future<void> openQrModalWindow() {
    return showModalBottomSheet<void>(
      context: context,
      builder: (BuildContext context) {
        return const Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [QrCodeModalWindow()]);
      },
    );
  }

  Widget _height() => const SizedBox(height: 16);

  Widget _width() => const SizedBox(width: 16);
}
