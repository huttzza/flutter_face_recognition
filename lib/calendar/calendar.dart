import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class Calendar extends StatefulWidget {
  @override
  _CalendarState createState() => _CalendarState();
}

class _CalendarState extends State<Calendar> {
  CalendarFormat format = CalendarFormat.month;
  DateTime selectedDay = DateTime.now();
  DateTime focusedDay = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('calendar')),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            TableCalendar(
              locale: 'ko-KR',
              firstDay: DateTime(1960),
              focusedDay: selectedDay,
              lastDay: DateTime(2050),
              calendarFormat: format,
              onFormatChanged: (CalendarFormat _format) {
                setState(() {
                  format = _format;
                });
              },
              onDaySelected: (DateTime selectDay, DateTime focusDay) {
                setState(() {
                  selectedDay = selectDay;
                  focusedDay = focusDay;
                });
              },
              calendarStyle: CalendarStyle(
                isTodayHighlighted: true,
                selectedDecoration: BoxDecoration(
                  color: Colors.blue,
                  //shape: BoxShape.rectangle,
                  //borderRadius:
                  //new BorderRadius.all(const Radius.circular(5.0))
                ),
                selectedTextStyle: TextStyle(color: Colors.white),
                todayDecoration: BoxDecoration(
                  color: Colors.grey,
                  //shape: BoxShape.rectangle,
                  //borderRadius: BorderRadius.circular(5.0)
                ),
                //defaultDecoration:
                //BoxDecoration(borderRadius: BorderRadius.circular(5.0))
              ),
              selectedDayPredicate: (DateTime date) {
                return isSameDay(selectedDay, date);
              },
              headerStyle: HeaderStyle(
                  formatButtonVisible: true,
                  titleCentered: true,
                  formatButtonShowsNext: false,
                  formatButtonDecoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5.0),
                      color: Colors.blue),
                  formatButtonTextStyle: TextStyle(color: Colors.white),
                  leftChevronVisible: false,
                  rightChevronVisible: false,
                  headerPadding:
                      EdgeInsets.symmetric(horizontal: 5.0, vertical: 15.0)),
              daysOfWeekStyle: DaysOfWeekStyle(
                  weekdayStyle: TextStyle(fontSize: 13),
                  weekendStyle: TextStyle(fontSize: 13)),
            )
          ],
        ),
      ),
    );
  }
}
