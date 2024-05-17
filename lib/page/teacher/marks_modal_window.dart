import 'package:flutter/material.dart';
import 'package:mobile_electronic_record_card/model/entity/mark_entity.dart';
import 'package:mobile_electronic_record_card/model/entity/student_and_mark_entity.dart';

class MarksModalWindow extends StatefulWidget {
  final List<MarkEntity>? marks;
  final StudentAndMarkEntity? currentItem;

  const MarksModalWindow(this.marks, this.currentItem, {super.key});

  @override
  State<MarksModalWindow> createState() => _MarksModalWindowState();
}

class _MarksModalWindowState extends State<MarksModalWindow> {
  late List<MarkEntity>? marks;
  StudentAndMarkEntity? currentItem;
  int? selectedOption;

  _MarksModalWindowState();

  @override
  void initState() {
    super.initState();
    marks = widget.marks;
    currentItem = widget.currentItem;
    selectedOption = currentItem?.mark?.id ?? marks?.first.id;
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
          itemCount: marks?.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(marks?[index].title ?? ""),
              leading: Radio<int>(
                value: marks?[index].id ?? 1,
                groupValue: selectedOption,
                onChanged: (int? value) {
                  setState(() {
                    selectedOption = value;
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
                Navigator.of(context).pop(selectedOption);
              },
              child: const Text("Сохранить"),
            )
          ],
        )
      ],
    );
  }
}
