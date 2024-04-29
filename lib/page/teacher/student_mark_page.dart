import 'package:flutter/material.dart';
import 'package:flutter_logcat/flutter_logcat.dart';
import 'package:mobile_electronic_record_card/controller/control_type_controller.dart';
import 'package:mobile_electronic_record_card/controller/mark_control_type_controller.dart';
import 'package:mobile_electronic_record_card/controller/mark_controller.dart';
import 'package:mobile_electronic_record_card/model/entity/control_type_entity.dart';
import 'package:mobile_electronic_record_card/model/entity/mark_entity.dart';
import 'package:mobile_electronic_record_card/page/teacher/marks_modal_window.dart';

class StudentMarkPage extends StatefulWidget {
  const StudentMarkPage({super.key});

  @override
  State<StatefulWidget> createState() {
    return StudentMarkPageState();
  }
  
}

class StudentMarkPageState extends State<StudentMarkPage> {
  Future<List<ControlTypeEntity>>? students;
  Future<List<MarkEntity>?>? marks;
  // показатель выбора
  bool isSelectItem = false;
  // список выбранных записей с id и показателем выбора
  Map<int, bool> selectedItem = {};

  @override
  void initState() {
    super.initState();
    students = ControlTypeController().controlTypes;
    marks = MarkController().getByControlTypeFromDb(2);
  }

  @override
  Widget build(BuildContext context) {
    String title = 'Ведомость';
    return Scaffold(
      appBar: buildAppBar(title),
      body: buildFutureBuilder(),
      floatingActionButton: _buildSelectAllButton(),
    );
  }

  AppBar buildAppBar(String title) {
    return AppBar(
      title: Text(title),
      actions: [
        IconButton(
          onPressed: () => synchronization(),
          icon: const Icon(Icons.access_time),
        )
      ],
    );
  }

  FutureBuilder<List<ControlTypeEntity>> buildFutureBuilder() {
    return FutureBuilder(
      future: students,
      builder: (context, snapshot) {
        return buildListView(snapshot);
      },
    );
  }

  synchronization() {
    ControlTypeController().synchronization().then((_) =>
    {
      MarkController().synchronization().then((value) =>
      {
        MarkControlTypeController().synchronization().then((value) =>
        {
          setState(() {
            students = ControlTypeController().controlTypes;
            marks = MarkController().getByControlTypeFromDb(1);
          })
        })
      })
    });
  }

  ListView buildListView(AsyncSnapshot<List<ControlTypeEntity>> snapshot) {
    return ListView.builder(
        itemCount: snapshot.data?.length,
        itemBuilder: (builder, index) {
          if (snapshot.data == null) {
            return null;
          }
          ControlTypeEntity data = snapshot.data![index];
          selectedItem[index] = selectedItem[index] ?? false;
          // показатель выбранности конкретной записи
          bool? isSelectedData = selectedItem[index];

          return ListTile(
            onLongPress: () => onLongPress(isSelectedData, index),
            onTap: () => onTap(isSelectedData, index),
            title: Text(data.title ?? ""),
            leading: _buildSelectIcon(isSelectedData!, data),
          );
        }
    );
  }

  Future<void> buildMarks(List<MarkEntity>? marks) {
    return showModalBottomSheet<void>(
      context: context,
      builder: (BuildContext context) {
        return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              MarksModalWindow(marks)
            ]
        );
      },
    );
  }

  Widget? _buildSelectIcon(bool isSelectedData, ControlTypeEntity data) {
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

  void onTap(bool isSelectedData, int index) {
    if (isSelectItem) {
      setState(() {
        selectedItem[index] = !isSelectedData;
        isSelectItem = selectedItem.containsValue(true);
      });
    } else {
      //marks?.then((value) => buildMarks(value));
      _openMarksModalWindow();
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
          FloatingActionButton(
              onPressed: () => _openMarksModalWindow(),
              child: const Icon(
                Icons.assignment_turned_in_outlined
              ),
          )
        ],
      );
    } else {
      return null;
    }
  }

  void _openMarksModalWindow () {
    marks?.then((value) => buildMarks(value));
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




