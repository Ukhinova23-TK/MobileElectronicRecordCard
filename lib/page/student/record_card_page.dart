import 'package:flutter/material.dart';
import 'package:flutter_logcat/flutter_logcat.dart';
import 'package:mobile_electronic_record_card/constants/api_constants.dart';
import 'package:mobile_electronic_record_card/controller/control_type_controller.dart';
import 'package:mobile_electronic_record_card/controller/subject_controller.dart';
import 'package:mobile_electronic_record_card/model/entity/control_type_entity.dart';
import 'package:mobile_electronic_record_card/model/entity/subject_entity.dart';
import 'package:mobile_electronic_record_card/model/entity/user_entity.dart';
import 'package:mobile_electronic_record_card/page/bottom_nav_bar_choose.dart';
import 'package:mobile_electronic_record_card/page/student/info_modal_window.dart';

class RecordCardPage extends StatefulWidget {
  final int? selectedItemNavBar;
  final bool? bottomNavBar;

  const RecordCardPage({this.selectedItemNavBar, this.bottomNavBar, super.key});

  @override
  State<RecordCardPage> createState() => _RecordCardPageState();
}

class _RecordCardPageState extends State<RecordCardPage> {
  List<String> semesters = [];
  Future<List<SubjectEntity>>? subjects;
  Future<ControlTypeEntity>? controlType;
  Future<List<UserEntity>>? users;
  late int _selectedIndex;
  late bool bottomNavBar;

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.selectedItemNavBar ?? 1;
    bottomNavBar = widget.bottomNavBar ?? false;
    subjects = SubjectController().subjects.catchError((onError) {
      Log.e('Ошибка загрузки данных', tag: 'record_card_page');
      ScaffoldMessenger.of(context)
        ..removeCurrentSnackBar()
        ..showSnackBar(const SnackBar(content: Text('Ошибка загрузки данных')));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: appbarColor,
        title: const Text('Зачетка'),
        actions: [
          IconButton(
              onPressed: () {}, icon: const Icon(Icons.qr_code_2_outlined)),
          IconButton(onPressed: () {}, icon: const Icon(Icons.filter_alt)),
          IconButton(
              onPressed: () => openInfoModalWindow(),
              icon: const Icon(Icons.percent_outlined))
        ],
      ),
      body: Column(
        children: [
          _height(),
          Row(
            children: [
              _width(),
              //  TODO подвязать данные
              const DropdownMenuExample(
                semesters: [
                  '1 semester',
                  '2 semester',
                  '3 semester',
                  '4 semester',
                  '5 semester',
                  '6 semester'
                ],
              )
            ],
          ),
          _height(),
          FutureBuilder(
              future: subjects,
              builder: (context, snapshot) {
                if (snapshot.data == null) {
                  return ListView.builder(
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      itemCount: 1,
                      itemBuilder: (context, index) {
                        return const ListTile(
                          title: Text("Нет данных"),
                        );
                      });
                } else {
                  return ListView.builder(
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      itemCount: snapshot.data?.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: Text(snapshot.data?[index].name ?? ""),
                          //  TODO подвязать данные
                          subtitle: const Text('Тип контроля'),
                          trailing: const Text('Оценка'),
                          tileColor: greatMarkColor,
                        );
                      });
                }
              })
        ],
      ),
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

  Future<void> openInfoModalWindow() {
    return showModalBottomSheet<void>(
      context: context,
      builder: (BuildContext context) {
        return const Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [InfoModalWindow()]);
      },
    );
  }

  Widget _height() => const SizedBox(height: 16);

  Widget _width() => const SizedBox(width: 16);
}

class DropdownMenuExample extends StatefulWidget {
  final List<String>? semesters;

  const DropdownMenuExample({super.key, this.semesters});

  @override
  State<DropdownMenuExample> createState() => _DropdownMenuExampleState();
}

class _DropdownMenuExampleState extends State<DropdownMenuExample> {
  late List<String>? semesters = [];
  late String? dropdownValue;

  @override
  void initState() {
    super.initState();
    semesters = widget.semesters;
    dropdownValue = semesters?.first;
  }

  @override
  Widget build(BuildContext context) {
    return DropdownMenu<String>(
      initialSelection: semesters?.first,
      onSelected: (String? value) {
        // This is called when the user selects an item.
        setState(() {
          dropdownValue = value!;
        });
      },
      dropdownMenuEntries:
          semesters!.map<DropdownMenuEntry<String>>((String value) {
        return DropdownMenuEntry<String>(value: value, label: value);
      }).toList(),
    );
  }
}
