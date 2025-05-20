import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:anuwadak/controllers/calendar_controller.dart'; // Assuming your project name is anuwadak
import 'package:provider/provider.dart';

class CalendarScreen extends StatelessWidget {
  const CalendarScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => CalendarController(),
      child: _CalendarView(),
    );
  }
}

class _CalendarView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final calendarController = Provider.of<CalendarController>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Calendar'),
      ),
      body: Column(
        children: [
          TableCalendar(
            focusedDay: calendarController.focusedDay,
            firstDay: DateTime.utc(2020, 1, 1),
            lastDay: DateTime.utc(2030, 12, 31),
            selectedDayPredicate: (day) => calendarController.isSameDay(calendarController.selectedDay, day),
            onDaySelected: (selectedDay, focusedDay) {
              calendarController.onDaySelected(selectedDay, focusedDay);
            },
            onPageChanged: (focusedDay) {
              calendarController.onPageChanged(focusedDay);
            },
            calendarFormat: CalendarFormat.month, // You can change this
            headerStyle: const HeaderStyle(
              formatButtonVisible: false,
            ),
          ),
          const SizedBox(height: 20),
          Text(
            calendarController.selectedDay != null
                ? 'Selected day: ${calendarController.selectedDay!.toLocal().toString().split(' ')[0]}'
                : 'No day selected',
            style: const TextStyle(fontSize: 18),
          ),
        ],
      ),
    );
  }
}