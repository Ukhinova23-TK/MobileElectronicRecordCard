import 'package:flutter/material.dart';
import 'package:mobile_electronic_record_card/model/entity/teacher_subject_control_type_mark_semester_entity.dart';

class InfoModalWindow extends StatefulWidget {
  final List<TeacherSubjectControlTypeMarkSemesterEntity> tsctms;
  const InfoModalWindow({required this.tsctms, super.key});

  @override
  State<InfoModalWindow> createState() => _InfoModalWindowState();
}

class _InfoModalWindowState extends State<InfoModalWindow> {
  late List<TeacherSubjectControlTypeMarkSemesterEntity> tsctms;

  @override
  void initState() {
    super.initState();
    tsctms = widget.tsctms;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _height(),
        Row(
          children: [
            _width(),
            const Expanded(
                flex: 2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Процент пятерок, %'),
                  ],
                )),
            Expanded(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [Text(percentGreatMark(tsctms).toString())],
            )),
            _width()
          ],
        ),
        Row(
          children: [
            _width(),
            const Expanded(
                flex: 2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Средний балл'),
                  ],
                )),
            Expanded(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [Text(avgMark(tsctms).toString())],
            )),
            _width()
          ],
        ),
        Row(
          children: [
            _width(),
            const Expanded(
                flex: 2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Красный диплом'),
                  ],
                )),
            Expanded(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [Text(isRedDiploma(tsctms) ? 'Возможен' : 'Не возможен')],
            )),
            _width()
          ],
        ),
        _height(),
      ],
    );
  }

  double avgMark(List<TeacherSubjectControlTypeMarkSemesterEntity> tsctms) {
    double avg = 0.0;
    List<TeacherSubjectControlTypeMarkSemesterEntity> data = filterList(tsctms);
    for (TeacherSubjectControlTypeMarkSemesterEntity element in data) {
      avg += element.mark?.value ?? 0.0;
    }
    return data.isNotEmpty ? avg /= data.length : 0.0;
  }

  int percentGreatMark(
      List<TeacherSubjectControlTypeMarkSemesterEntity> tsctms) {
    List<TeacherSubjectControlTypeMarkSemesterEntity> data = filterList(tsctms);
    int perfect = data.length;
    int real = data.where((element) => element.mark?.value == 5).length;
    return (perfect !=0 && real != 0) ? (real * 100 / perfect).round() : 0;
  }

  bool isRedDiploma(List<TeacherSubjectControlTypeMarkSemesterEntity> tsctms) {
    List<TeacherSubjectControlTypeMarkSemesterEntity> data = filterList(tsctms);
    data = data.where((element) => element.mark?.id == 3).toList();
    for (TeacherSubjectControlTypeMarkSemesterEntity element in data) {
      if (element.mark?.value == 2 ||
          element.mark?.value == 3 ||
          element.mark?.value == 1) {
        return false;
      }
    }
    return percentGreatMark(data) >= 75;
  }

  List<TeacherSubjectControlTypeMarkSemesterEntity> filterList(
      List<TeacherSubjectControlTypeMarkSemesterEntity> tsctms) {
    return tsctms
        .where((element) => element.controlType.id != 1 && element.mark == null)
        .toList();
  }

  Widget _height() => const SizedBox(height: 26);
  Widget _width() => const SizedBox(width: 26);
}
