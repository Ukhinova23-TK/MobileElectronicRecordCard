import 'package:flutter/material.dart';
import 'package:mobile_electronic_record_card/model/entity/teacher_subject_control_type_mark_semester_entity.dart';
import 'package:mobile_electronic_record_card/model/enumeration/control_type_name.dart';
import 'package:mobile_electronic_record_card/model/enumeration/mark_name.dart';

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
        _height(),
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
        _height(),
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
              children: [
                Text(isRedDiploma(tsctms) ? 'Возможен' : 'Не возможен')
              ],
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
    data = filterTwoList(data);
    for (TeacherSubjectControlTypeMarkSemesterEntity element in data) {
      avg += element.mark?.value ?? 0.0;
    }
    return (data.isNotEmpty && avg != 0) ? avg /= data.length : 0.0;
  }

  int percentGreatMark(
      List<TeacherSubjectControlTypeMarkSemesterEntity> tsctms) {
    List<TeacherSubjectControlTypeMarkSemesterEntity> data = filterList(tsctms);
    data = filterTwoList(data);
    int perfect = data.length;
    int real = data
        .where((element) => element.mark?.name == MarkName.excellent)
        .length;
    return (perfect != 0 && real != 0) ? (real * 100 / perfect).round() : 0;
  }

  bool isRedDiploma(List<TeacherSubjectControlTypeMarkSemesterEntity> tsctms) {
    List<TeacherSubjectControlTypeMarkSemesterEntity> data = filterList(tsctms);
    for (TeacherSubjectControlTypeMarkSemesterEntity element in data) {
      if (element.mark?.name == MarkName.nonAdmission ||
          element.mark?.name == MarkName.reasonableAbsence ||
          element.mark?.name == MarkName.absence ||
          element.mark?.name == MarkName.satisfactory ||
          element.mark?.name == MarkName.unsatisfactory) {
        return false;
      }
    }
    return percentGreatMark(data) >= 75;
  }

  List<TeacherSubjectControlTypeMarkSemesterEntity> filterList(
      List<TeacherSubjectControlTypeMarkSemesterEntity> tsctms) {
    return tsctms
        .where((element) =>
            element.controlType.name != ControlTypeName.credit ||
            element.mark != null ||
            element.mark?.name != MarkName.release ||
            element.mark?.name != MarkName.passed ||
            element.mark?.name != MarkName.failed)
        .toList();
  }

  List<TeacherSubjectControlTypeMarkSemesterEntity> filterTwoList(
      List<TeacherSubjectControlTypeMarkSemesterEntity> tsctms) {
    return tsctms
        .where((element) =>
            element.mark?.name != MarkName.nonAdmission ||
            element.mark?.name != MarkName.absence ||
            element.mark?.name != MarkName.reasonableAbsence)
        .toList();
  }

  Widget _height() => const SizedBox(height: 26);
  Widget _width() => const SizedBox(width: 26);
}
