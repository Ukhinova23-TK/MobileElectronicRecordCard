import 'package:flutter/material.dart';
import 'package:mobile_electronic_record_card/data/constants/api_constants.dart';
import 'package:mobile_electronic_record_card/data/shared_preference/shared_preference_helper.dart';
import 'package:mobile_electronic_record_card/model/entity/control_type_entity.dart';
import 'package:mobile_electronic_record_card/model/entity/subject_entity.dart';
import 'package:mobile_electronic_record_card/model/entity/teacher_subject_control_type_mark_semester_entity.dart';
import 'package:mobile_electronic_record_card/model/entity/user_entity.dart';
import 'package:mobile_electronic_record_card/model/enumeration/mark_name.dart';
import 'package:mobile_electronic_record_card/page/bottom_nav_bar_choose.dart';
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
  final sharedLocator = getIt.get<SharedPreferenceHelper>();
  Future<List<SubjectEntity>>? subjects;
  Future<ControlTypeEntity>? controlType;
  Future<List<UserEntity>>? users;
  late int _selectedIndex;
  late BottomNavBarChoose bottomNavBar;
  int? dropdownValue;
  bool _infoModal = false;

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.selectedItemNavBar ??
        (sharedLocator.getRolesCount() == 2 ? 1 : 0);
    Provider.of<UserSubjectControlTypeProvider>(context, listen: false)
        .initUserSubjectsControlTypes(sharedLocator.getUserId()!);
    bottomNavBar = BottomNavBarChoose(context: context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: appbarColor,
        title: const Text('Зачетка'),
        actions: <Widget>[
          IconButton(
              onPressed: () {}, icon: const Icon(Icons.qr_code_2_outlined)),
          _infoModal
              ? IconButton(
                  onPressed: () => Provider.of<UserSubjectControlTypeProvider>(
                          context,
                          listen: false)
                      .userSubjectsControlTypes
                      ?.then((value) => openInfoModalWindow(value)),
                  icon: const Icon(Icons.percent_outlined))
              : Container()
        ],
      ),
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
                              (dropdownValue ?? dataUniqueSemester.first))
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
                                dropdownValue = value;
                                _infoModal = true;
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
                        }),
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

  Color? setColor(String? markName) {
    switch (markName) {
      case MarkName.excellent || MarkName.failed || MarkName.release:
        return greatMarkColor;
      case MarkName.good:
        return wellMarkColor;
      case MarkName.satisfactory:
        return satisfactoryMarkColor;
      case MarkName.unsatisfactory || MarkName.passed:
        return failMarkColor;
      default:
        return noMarkColor;
    }
  }

  BottomNavigationBar? buildBottomNavigationBar() {
    return BottomNavigationBar(
      items: bottomNavBar.getItems(),
      currentIndex: _selectedIndex,
      selectedItemColor: greatMarkColor,
      onTap: _onItemTapped,
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    bottomNavBar.changeItem(index);
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

  Widget _height() => const SizedBox(height: 16);

  Widget _width() => const SizedBox(width: 16);
}
