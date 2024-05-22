import 'package:flutter/material.dart';

const Map<String, String> headers = {
  "Accept": "application/json",
  "Content-Type": "application/json"
};

//  Строковые переменные для страницы авторизации
const String titleAuthPage = 'Электронная зачетка';

const String labelLoginAuthPage = 'Логин';
const String hintLoginAuthPage = 'Введите логин';
const String emptyLoginAuthPage = 'Пожалуйста, введите логин';

const String labelPasswordAuthPage = 'Пароль';
const String hintPasswordAuthPage = 'Введите пароль';
const String emptyPasswordAuthPage = 'Пожалуйста, введите пароль';
const String tinyPasswordAuthPage = 'Пароль должен быть не меньше 12 символов';

const String buttonAuthPage = 'Вход';

//  Строковые переменные для страницы предметов
const String titleSubjectPage = 'Предметы';

//  Строковые переменные для страницы групп
const String titleGroupPage = 'Группы';

//  Строковые переменные для страницы ведомости
const String titleStudentMarkPage = 'Ведомость';

//  Строковые переменные для страницы зачетки
const String titleRecordCardPage = 'Зачетка';

//  Строковые переменные для страницы профиля
const String titleProfilePage = 'Профиль';

// Цветовые решения
const Color appbarColor = Color.fromARGB(255, 245, 245, 245);
const Color noMarkColor = Color.fromARGB(255, 230, 230, 230);
const Color failMarkColor = Color.fromARGB(255, 243, 185, 180);
const Color satisfactoryMarkColor = Color.fromARGB(255, 218, 237, 184);
const Color wellMarkColor = Color.fromARGB(255, 199, 229, 150);
const Color greatMarkColor = Color.fromARGB(255, 175, 218, 105);
const Color blackColor = Colors.black;
const Color greyColor = Colors.white30;