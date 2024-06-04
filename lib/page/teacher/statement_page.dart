import 'package:flutter/material.dart';
import 'package:mobile_electronic_record_card/controller/student_mark_controller.dart';
import 'package:mobile_electronic_record_card/data/constants/api_constants.dart';
import 'package:mobile_electronic_record_card/model/entity/mark_entity.dart';
import 'package:mobile_electronic_record_card/model/entity/student_and_mark_entity.dart';
import 'package:mobile_electronic_record_card/model/enumeration/mark_name.dart';
import 'package:mobile_electronic_record_card/page/bottom_nav_bar_choose.dart';
import 'package:mobile_electronic_record_card/page/synchronization_function.dart';
import 'package:mobile_electronic_record_card/page/teacher/marks_modal_window.dart';
import 'package:mobile_electronic_record_card/provider/mark_provider.dart';
import 'package:mobile_electronic_record_card/provider/student_mark_provider.dart';
import 'package:mobile_electronic_record_card/service/synchronization/impl/synchronization_service_impl.dart';
import 'package:provider/provider.dart';

class StatementPage extends StatefulWidget {
  final int? selectedItemNavBar;
  final int subjectId;
  final int groupId;

  const StatementPage(
      {required this.subjectId,
      required this.groupId,
      this.selectedItemNavBar,
      super.key});

  @override
  State<StatefulWidget> createState() {
    return StatementPageState();
  }
}

class StatementPageState extends State<StatementPage> {
  bool _isSelectItem = false;
  Map<int, bool> selectedItem = {};
  late bool _needSave;
  late int _selectedIndex;
  late int _subjectId;
  late int _groupId;
  late BottomNavBarChoose _bottomNavBar;
  int? _dropdownValue;

  @override
  void initState() {
    super.initState();
    _needSave = false;
    _selectedIndex = widget.selectedItemNavBar ?? 0;
    _subjectId = widget.subjectId;
    _groupId = widget.groupId;
    _bottomNavBar = BottomNavBarChoose(context: context);
    Provider.of<StudentMarkProvider>(context, listen: false)
        .initStudentMark(_groupId, _subjectId);
    Provider.of<MarkProvider>(context, listen: false)
        .initMarks(_groupId, _subjectId);
  }

  @override
  Widget build(BuildContext context) {
    return buildFutureBuilder();
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

  AppBar buildAppBar(String title) {
    List<Widget> buttons = [];
    if (_needSave) {
      buttons.add(IconButton(
        icon: const Icon(Icons.save),
        onPressed: () => saveToServer(),
      ));
    }
    buttons.add(IconButton(
        icon: const Icon(Icons.refresh_outlined),
        onPressed: () => synchronization().then((value) => setState(() {
              Provider.of<StudentMarkProvider>(context, listen: false)
                  .initStudentMark(_groupId, _subjectId);
              Provider.of<MarkProvider>(context, listen: false)
                  .initMarks(_groupId, _subjectId);
            }))));
    buttons.add(IconButton(
        icon: const Icon(Icons.logout_outlined),
        onPressed: () {
          if (_needSave) {
            showDialog<void>(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: const Text('Предупреждение'),
                    content: const Text(
                        'У вас есть не сохраненные на сервер данные. '
                        'При выходе из учетной записи эти данные будут потеряны. '
                        'Вы уверены, что хотите выйти?'),
                    actions: [
                      TextButton(
                          onPressed: () => Navigator.of(context).pop(),
                          child: const Text('Назад')),
                      TextButton(
                          onPressed: () => logout(context),
                          child: const Text('Выход'))
                    ],
                  );
                });
          } else {
            logout(context);
          }
        }));
    return AppBar(
      actions: buttons,
      title: Text(title),
    );
  }

  void saveToServer() {
    StudentMarkController()
        .getStudentMarksByGroupAndSubjectFromDb(
            _groupId, _subjectId, _dropdownValue!)
        .then((value) => SynchronizationServiceImpl().push(value).then((_) {
              Provider.of<StudentMarkProvider>(context, listen: false)
                  .initStudentMark(_groupId, _subjectId);
              setState(() {});
            }));
  }

  Consumer<StudentMarkProvider> buildFutureBuilder() {
    return Consumer<StudentMarkProvider>(
      builder: (context, studentMarkProvider, _) {
        return FutureBuilder(
            future: studentMarkProvider.studentMarks,
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return Scaffold(
                  appBar: buildAppBar(titleStudentMarkPage),
                  body: ListView.builder(
                      itemCount: 1,
                      itemBuilder: (context, index) {
                        return const ListTile(
                          title: Text("Нет данных"),
                        );
                      }),
                  floatingActionButton: _buildSelectAllButton(),
                  bottomNavigationBar: buildBottomNavigationBar(),
                );
              } else {
                List<int> dataUniqueSemester =
                    snapshot.data!.map((e) => e.semester).toSet().toList();
                dataUniqueSemester.sort();
                List<StudentAndMarkEntity> data = snapshot.data!
                    .where((element) =>
                        element.semester ==
                        (_dropdownValue ?? dataUniqueSemester.first))
                    .toList();
                //WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
                _dropdownValue ??= dataUniqueSemester.first;
                _needSave = data.any((element) => element.saved);
                //});
                return Scaffold(
                  appBar: buildAppBar(titleStudentMarkPage),
                  body: Column(
                    children: [
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
                      buildListView(data),
                    ],
                  ),
                  floatingActionButton: _buildSelectAllButton(),
                  bottomNavigationBar: buildBottomNavigationBar(),
                );
              }
            });
      },
    );
  }

  ListView buildListView(List<StudentAndMarkEntity> snapshot) {
    return ListView.builder(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        itemCount: snapshot.length,
        itemBuilder: (builder, index) {
          StudentAndMarkEntity data = snapshot[index];
          bool isSelectedData = false;
          if (data.mark?.name != MarkName.nonAdmission) {
            selectedItem[index] ??= false;
            isSelectedData = selectedItem[index]!;
          }
          return ListTile(
            onLongPress: () => data.mark?.name != MarkName.nonAdmission
                ? onLongPress(isSelectedData, index)
                : {},
            onTap: () => data.mark?.name != MarkName.nonAdmission
                ? onTap(isSelectedData, index, data)
                : {},
            title: SizedBox(
                width: MediaQuery.of(context).size.width * 0.6,
                child: Text(
                  '${data.user.lastName} ${data.user.firstName} '
                  '${data.user.middleName ?? ''}',
                  textAlign: TextAlign.left,
                  textDirection: TextDirection.rtl,
                )),
            trailing: SizedBox(
                width: MediaQuery.of(context).size.width * 0.4,
                child: Text(
                  textAlign: TextAlign.right,
                  textDirection: TextDirection.ltr,
                  data.mark?.title ?? 'Нет оценки',
                )),
            leading: _buildSelectIcon(isSelectedData, data),
            tileColor: setColor(data.mark?.name),
          );
        });
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

  void buildMarks(List<MarkEntity>? marks,
      [StudentAndMarkEntity? currentItem]) async {
    final result = await showModalBottomSheet<int>(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return SingleChildScrollView(
            child: MarksModalWindow(marks, currentItem));
      },
    );
    if (result != null) {
      var studentMarkFutures = <Future>[];
      if (currentItem == null && selectedItem.containsValue(true)) {
        List<StudentAndMarkEntity> studentMarks =
            await Provider.of<StudentMarkProvider>(context, listen: false)
                .studentMarks;
        selectedItem.entries.where((element) => element.value).forEach(
            (element) => studentMarkFutures.add(StudentMarkController().set(
                studentMarks
                    .where(
                        (studentMark) => studentMark.semester == _dropdownValue)
                    .toList()[element.key]
                    .user
                    .id!,
                result,
                _subjectId,
                _dropdownValue!)));
      } else {
        studentMarkFutures.add(StudentMarkController()
            .set(currentItem!.user.id!, result, _subjectId, _dropdownValue!));
      }
      Future.wait(studentMarkFutures).then((value) => setState(() {
            Provider.of<StudentMarkProvider>(context, listen: false)
                .initStudentMark(_groupId, _subjectId);
            _isSelectItem = false;
          }));
    }
  }

  Widget? _buildSelectIcon(bool isSelectedData, StudentAndMarkEntity data) {
    if (_isSelectItem) {
      return Icon(
        isSelectedData ? Icons.check_box : Icons.check_box_outline_blank,
        color: Theme.of(context).primaryColor,
      );
    }
    return null;
  }

  void onLongPress(bool isSelectedData, int index) {
    setState(() {
      selectedItem[index] = !isSelectedData;
      _isSelectItem = selectedItem.containsValue(true);
    });
  }

  void onTap(bool isSelectedData, int index, StudentAndMarkEntity currentItem) {
    if (_isSelectItem) {
      setState(() {
        selectedItem[index] = !isSelectedData;
        _isSelectItem = selectedItem.containsValue(true);
      });
    } else {
      _openMarksModalWindow(currentItem);
    }
  }

  Widget? _buildSelectAllButton() {
    bool isFalseAvailable = selectedItem.containsValue(false);
    if (_isSelectItem) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: _selectAll,
            child: Icon(
              isFalseAvailable ? Icons.done_all : Icons.remove_done,
            ),
          ),
          const SizedBox(height: 16),
          FloatingActionButton(
            onPressed: () => _openMarksModalWindow(),
            child: const Icon(Icons.assignment_turned_in_outlined),
          )
        ],
      );
    } else {
      return null;
    }
  }

  void _openMarksModalWindow([StudentAndMarkEntity? currentItem]) {
    if (currentItem != null) {
      Provider.of<MarkProvider>(context, listen: false)
          .marks
          .then((value) => buildMarks(value, currentItem));
    } else {
      Provider.of<MarkProvider>(context, listen: false)
          .marks
          .then((value) => buildMarks(value));
    }
  }

  void _selectAll() {
    bool isFalseAvailable = selectedItem.containsValue(false);
    selectedItem.updateAll((key, value) => isFalseAvailable);
    setState(() {
      _isSelectItem = selectedItem.containsValue(true);
    });
  }

  Widget _height() => const SizedBox(height: 16);

  Widget _width() => const SizedBox(width: 16);
}
