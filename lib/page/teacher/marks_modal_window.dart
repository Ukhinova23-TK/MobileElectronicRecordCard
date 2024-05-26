import 'package:flutter/material.dart';
import 'package:mobile_electronic_record_card/model/entity/mark_entity.dart';
import 'package:mobile_electronic_record_card/model/entity/student_and_mark_entity.dart';
import 'package:mobile_electronic_record_card/model/enumeration/mark_name.dart';

class MarksModalWindow extends StatefulWidget {
  final List<MarkEntity>? marks;
  final StudentAndMarkEntity? currentItem;

  const MarksModalWindow(this.marks, this.currentItem, {super.key});

  @override
  State<MarksModalWindow> createState() => _MarksModalWindowState();
}

class _MarksModalWindowState extends State<MarksModalWindow> {
  late List<MarkEntity>? _marks;
  StudentAndMarkEntity? _currentItem;
  int? _selectedOption;

  _MarksModalWindowState();

  @override
  void initState() {
    super.initState();
    _marks = widget.marks
        ?.where((element) => element.name != MarkName.nonAdmission)
        .toList();
    _currentItem = widget.currentItem;
    _selectedOption = _currentItem?.mark?.id ?? _marks?.first.id;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Row(
          children: [Text('')],
        ),
        ListView.builder(
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          itemCount: _marks?.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(_marks?[index].title ?? ""),
              leading: Radio<int>(
                value: _marks?[index].id ?? 1,
                groupValue: _selectedOption,
                onChanged: (int? value) {
                  setState(() {
                    _selectedOption = value;
                  });
                },
              ),
            );
          },
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop(_selectedOption);
              },
              child: const Text("Сохранить"),
            )
          ],
        )
      ],
    );
  }
}
