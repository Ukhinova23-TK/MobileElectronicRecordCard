import 'package:flutter/material.dart';
import 'package:mobile_electronic_record_card/page/student/record_card_page.dart';
import 'package:mobile_electronic_record_card/page/teacher/subject_page.dart';

class BottomNavBarChoose {
  int index;
  BuildContext context;
  bool bottomNavBar;

  BottomNavBarChoose(
      {required this.index, required this.context, required this.bottomNavBar});

  void changeItem() {
    switch (index) {
      case 0:
        {
          if (context.widget.runtimeType != SubjectPage) {
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (context) => SubjectPage(
                    selectedItemNavBar: index,
                    bottomNavBar: bottomNavBar,
                  ),
                ),
                (Route<dynamic> route) => false);
          }
        }
      case 1:
        {
          if (context.widget.runtimeType != RecordCardPage) {
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (context) => RecordCardPage(
                    selectedItemNavBar: index,
                    bottomNavBar: bottomNavBar,
                  ),
                ),
                (Route<dynamic> route) => false);
          }
        }
    }
  }
}
