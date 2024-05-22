import 'package:flutter/material.dart';
import 'package:mobile_electronic_record_card/data/shared_preference/shared_preference_helper.dart';
import 'package:mobile_electronic_record_card/model/enumeration/role_name.dart';
import 'package:mobile_electronic_record_card/page/profile_page.dart';
import 'package:mobile_electronic_record_card/page/student/record_card_page.dart';
import 'package:mobile_electronic_record_card/page/teacher/subject_page.dart';
import 'package:mobile_electronic_record_card/service/locator/locator.dart';

class BottomNavBarChoose {
  BuildContext context;
  final sharedLocator = getIt.get<SharedPreferenceHelper>();

  BottomNavBarChoose({required this.context});

  void changeItem(int index) {
    List<String>? roles = sharedLocator.getRolesName();
    if (roles != null) {
      switch (index) {
        case 0:
          {
            if (roles.length == 2 || roles.contains(RoleName.teacher)) {
              if (context.widget.runtimeType != SubjectPage) {
                onTeacherPage(index);
              }
            } else {
              if (roles.contains(RoleName.student) &&
                  context.widget.runtimeType != RecordCardPage) {
                onStudentPage(index);
              }
            }
          }
        case 1:
          {
            if (roles.length == 2) {
              if (context.widget.runtimeType != RecordCardPage) {
                onStudentPage(index);
              }
            } else {
              if (context.widget.runtimeType != ProfilePage) {
                onProfilePage(index);
              }
            }
          }
        case 2:
          {
            if (context.widget.runtimeType != ProfilePage) {
              onProfilePage(index);
            }
          }
      }
    }
  }

  List<BottomNavigationBarItem> getItems() {
    List<String>? roles = sharedLocator.getRolesName();
    List<BottomNavigationBarItem> bottomItems = [];
    if (roles != null) {
      if (roles.contains(RoleName.teacher)) {
        bottomItems.add(const BottomNavigationBarItem(
            icon: Icon(Icons.work_outline), label: 'Преподаватель'));
      }
      if (roles.contains(RoleName.student)) {
        bottomItems.add(const BottomNavigationBarItem(
            icon: Icon(Icons.school_outlined), label: 'Студент'));
      }
      bottomItems.add(const BottomNavigationBarItem(
          icon: Icon(Icons.person_outlined), label: 'Профиль'));
      return bottomItems;
    } else {
      return bottomItems;
    }
  }

  void onProfilePage(int index) {
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) => ProfilePage(
            selectedItemNavBar: index,
          ),
        ),
        (Route<dynamic> route) => false);
  }

  void onStudentPage(int index) {
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) => RecordCardPage(
            selectedItemNavBar: index,
          ),
        ),
        (Route<dynamic> route) => false);
  }

  void onTeacherPage(int index) {
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) => SubjectPage(
            selectedItemNavBar: index,
          ),
        ),
        (Route<dynamic> route) => false);
  }
}
