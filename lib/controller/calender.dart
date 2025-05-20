import 'package:flutter/material.dart';
import 'package:anuwadak/models/calendar_model.dart'; // Assuming your project name is anuwadak

class CalendarController extends ChangeNotifier {
  CalendarModel _calendarModel;

  CalendarController() : _calendarModel = CalendarModel(focusedDay: DateTime.now());

  DateTime get focusedDay => _calendarModel.focusedDay;
  DateTime? get selectedDay => _calendarModel.selectedDay;

  void onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    if (!isSameDay(_calendarModel.selectedDay, selectedDay)) {
      _calendarModel.selectedDay = selectedDay;
      _calendarModel.focusedDay = focusedDay;
      notifyListeners();
    }
  }

  void onPageChanged(DateTime focusedDay) {
    _calendarModel.focusedDay = focusedDay;
    notifyListeners();
  }

  bool isSameDay(DateTime? dayA, DateTime dayB) {
    if (dayA == null) {
      return false;
    }
    return dayA.year == dayB.year && dayA.month == dayB.month && dayA.day == dayB.day;
  }
}