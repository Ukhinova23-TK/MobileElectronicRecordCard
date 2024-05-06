import 'package:flutter/material.dart';

import '../../model/entity/mark_entity.dart';

class MarksModalWindow extends StatefulWidget {
  final List<MarkEntity>? marks;

  const MarksModalWindow(this.marks, {super.key});

  @override
  State<MarksModalWindow> createState() => _MarksModalWindowState();
}

class _MarksModalWindowState extends State<MarksModalWindow> {
  late List<MarkEntity>? marks;
  int? selectedOption;

  _MarksModalWindowState();

  @override
  void initState() {
    super.initState();
    marks = widget.marks;
    selectedOption = marks?.first.id;
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
                Navigator.pop(context, selectedOption);
              },
              child: const Text("Сохранить"),
            )
          ],
        )
      ],
    );
  }
}
