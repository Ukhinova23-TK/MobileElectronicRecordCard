import 'package:flutter/material.dart';
import 'package:mobile_electronic_record_card/controller/student_mark_controller.dart';
import 'package:mobile_electronic_record_card/data/constants/api_constants.dart';
import 'package:mobile_electronic_record_card/data/shared_preference/shared_preference_helper.dart';
import 'package:mobile_electronic_record_card/model/entity/mark_entity.dart';
import 'package:mobile_electronic_record_card/model/entity/student_and_mark_entity.dart';
import 'package:mobile_electronic_record_card/model/enumeration/mark_name.dart';
import 'package:mobile_electronic_record_card/page/bottom_nav_bar_choose.dart';
import 'package:mobile_electronic_record_card/page/logout.dart';
import 'package:mobile_electronic_record_card/page/teacher/marks_modal_window.dart';
import 'package:mobile_electronic_record_card/provider/mark_provider.dart';
import 'package:mobile_electronic_record_card/provider/student_mark_provider.dart';
import 'package:mobile_electronic_record_card/service/locator/locator.dart';
import 'package:mobile_electronic_record_card/service/synchronization/impl/synchronization_service_impl.dart';
import 'package:provider/provider.dart';

class StudentMarkPage extends StatefulWidget {
  final int? selectedItemNavBar;
  final int subjectId;
  final int groupId;

  const StudentMarkPage(
      {required this.subjectId,
      required this.groupId,
      this.selectedItemNavBar,
      super.key});

  @override
  State<StatefulWidget> createState() {
    return StudentMarkPageState();
  }
}

class StudentMarkPageState extends State<StudentMarkPage> {
  bool isSelectItem = false;
  Map<int, bool> selectedItem = {};
  final sharedLocator = getIt.get<SharedPreferenceHelper>();
  late bool _needSave;
  late int _selectedIndex;
  late int _subjectId;
  late int _groupId;
  late BottomNavBarChoose bottomNavBar;

  @override
  void initState() {
    super.initState();
    _needSave = sharedLocator.getNeedSave() ?? false;
    _selectedIndex = widget.selectedItemNavBar ?? 0;
    _subjectId = widget.subjectId;
    _groupId = widget.groupId;
    bottomNavBar = BottomNavBarChoose(context: context);
    Provider.of<StudentMarkProvider>(context, listen: false)
        .initStudentMark(_groupId, _subjectId);
    Provider.of<MarkProvider>(context, listen: false)
        .initMarks(_groupId, _subjectId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(titleStudentMarkPage),
      body: Consumer<StudentMarkProvider>(
          builder: (context, studentMarkProvider, _) =>
              buildFutureBuilder(studentMarkProvider)),
      floatingActionButton: _buildSelectAllButton(),
      bottomNavigationBar: buildBottomNavigationBar(),
    );
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

  AppBar buildAppBar(String title) {
    List<Widget> buttons = [];
    if (_needSave) {
      buttons.add(IconButton(
        icon: const Icon(Icons.save),
        onPressed: () => saveToServer(),
      ));
    }
    buttons.add(IconButton(
        icon: const Icon(Icons.logout_outlined),
        onPressed: () => logout(context)));
    return AppBar(
      actions: buttons,
      title: Text(title),
    );
  }

  void saveToServer() {
    StudentMarkController()
        .getStudentMarksByGroupAndSubjectFromDb(_groupId, _subjectId)
        .then((value) => SynchronizationServiceImpl().push(value).then((value) {
              setState(() {
                sharedLocator.setNeedSave(false);
                _needSave = sharedLocator.getNeedSave() ?? false;
              });
            }));
  }

  FutureBuilder<List<StudentAndMarkEntity>> buildFutureBuilder(
      StudentMarkProvider studentMarkProvider) {
    return FutureBuilder(
      future: studentMarkProvider.studentMarks,
      builder: (context, snapshot) {
        return buildListView(snapshot);
      },
    );
  }

  ListView buildListView(AsyncSnapshot<List<StudentAndMarkEntity>> snapshot) {
    if (!snapshot.hasData) {
      return ListView.builder(
          itemCount: 1,
          itemBuilder: (context, index) {
            return const ListTile(
              title: Text("Нет данных"),
            );
          });
    } else {
      return ListView.builder(
          itemCount: snapshot.data?.length,
          itemBuilder: (builder, index) {
            if (snapshot.data == null) {
              return null;
            }
            StudentAndMarkEntity data = snapshot.data![index];
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
            (element) => studentMarkFutures.add(StudentMarkController()
                .set(studentMarks[element.key].user.id!, result, _subjectId)));
      } else {
        studentMarkFutures.add(StudentMarkController()
            .set(currentItem!.user.id!, result, _subjectId));
      }
      Future.wait(studentMarkFutures).then((value) => setState(() {
            Provider.of<StudentMarkProvider>(context, listen: false)
                .initStudentMark(_groupId, _subjectId);
            Provider.of<StudentMarkProvider>(context, listen: false)
                .fetchStudentMark();
            sharedLocator.setNeedSave(true);
            _needSave = sharedLocator.getNeedSave() ?? true;
            isSelectItem = false;
          }));
    }
  }

  Widget? _buildSelectIcon(bool isSelectedData, StudentAndMarkEntity data) {
    if (isSelectItem) {
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
      isSelectItem = selectedItem.containsValue(true);
    });
  }

  void onTap(bool isSelectedData, int index, StudentAndMarkEntity currentItem) {
    if (isSelectItem) {
      setState(() {
        selectedItem[index] = !isSelectedData;
        isSelectItem = selectedItem.containsValue(true);
      });
    } else {
      //marks?.then((value) => buildMarks(value));
      _openMarksModalWindow(currentItem);
    }
  }

  Widget? _buildSelectAllButton() {
    bool isFalseAvailable = selectedItem.containsValue(false);
    if (isSelectItem) {
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
    // If false will be available then it will select all the checkbox
    // If there will be no false then it will de-select all
    selectedItem.updateAll((key, value) => isFalseAvailable);
    setState(() {
      isSelectItem = selectedItem.containsValue(true);
    });
  }
}
