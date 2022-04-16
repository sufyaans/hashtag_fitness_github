// ignore_for_file: prefer_const_constructors, prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:hashtag_fitness/variables.dart';
import 'package:table_calendar/table_calendar.dart';
import 'dart:collection';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hashtag_fitness/variables.dart' as vr;
import 'dart:io';

// Event class.
class Event {
  final String title;
  const Event(this.title);

  @override
  String toString() => title;
}

// Events
// Using a LinkedHashMap is highly recommended if you decide to use a map.
final kEvents = LinkedHashMap<DateTime, List<Event>>(
  equals: isSameDay,
  hashCode: getHashCode,
)..addAll(_kEventSource);
final _kEventSource = Map<DateTime, List<Event>>();

int getHashCode(DateTime key) {
  return key.day * 1000000 + key.month * 10000 + key.year;
}

// Returns a list of DateTime objects from first to last, inclusive.
List<DateTime> daysInRange(DateTime first, DateTime last) {
  final dayCount = last.difference(first).inDays + 1;
  return List.generate(
    dayCount,
    (index) => DateTime.utc(first.year, first.month, first.day + index),
  );
}

final kToday = DateTime.now();
final kFirstDay = DateTime(kToday.year, kToday.month - 3, kToday.day);
final kLastDay = DateTime(kToday.year, kToday.month + 3, kToday.day);
var cur;

class nutritionCalendar extends StatefulWidget {
  @override
  _CalendarState createState() => _CalendarState();
}

class _CalendarState extends State<nutritionCalendar> {
  ValueNotifier<List<Event>>? _selectedEvents;
  CalendarFormat _calendarFormat = CalendarFormat.month;
  RangeSelectionMode _rangeSelectionMode = RangeSelectionMode
      .toggledOff; // Can be toggled on/off by longpressing a date
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  DateTime? _rangeStart;
  DateTime? _rangeEnd;
  bool loaded = false;
  List<Event> tmp = [];

  Future<void> getData() async {
    // Get docs from collection reference
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('Nutrition')
        .get();

    // print(_kEventSource);
    // Get data from docs and convert map to List
    final allData = await querySnapshot.docs.map((doc) => doc.data()).toList();
    for (var i in allData) {
      if (cur == 0) {
        cur = (i as Map<String, dynamic>)['timestamp'].toDate().day;
      }
      setState(() {
        if ((i! as Map<String, dynamic>)['Dummy'] != 'Dummy') {
          if (cur != (i as Map<String, dynamic>)['timestamp'].toDate().day) {
            cur = (i as Map<String, dynamic>)['timestamp'].toDate().day;
            tmp = [];
          }
          tmp.add(Event("Type of Meal: " +
              '${(i as Map<String, dynamic>)['Type of Meal']}'));
          tmp.add(Event("Items Consumed: " +
              '${(i as Map<String, dynamic>)['Items Consumed']}'));
          tmp.add(Event(
              "Quantity: " + '${(i as Map<String, dynamic>)['Quantity']}'));
          tmp.add(Event("Total Calories (Kcal): " +
              '${(i as Map<String, dynamic>)['Fat (g)']}'));
          tmp.add(
              Event("Fat (g): " + '${(i as Map<String, dynamic>)['Fat (g)']}'));
          tmp.add(Event(
              "Carbs (g): " + '${(i as Map<String, dynamic>)['Carbs (g)']}'));
          tmp.add(Event("Protein (g): " +
              '${(i as Map<String, dynamic>)['Protein (g)']}'));
        }
        _kEventSource.putIfAbsent(
            DateTime.utc(
                (i as Map<String, dynamic>)['timestamp'].toDate().year,
                (i as Map<String, dynamic>)['timestamp'].toDate().month,
                (i as Map<String, dynamic>)['timestamp'].toDate().day,
                (i as Map<String, dynamic>)['timestamp'].toDate().hour,
                (i as Map<String, dynamic>)['timestamp'].toDate().minute,
                (i as Map<String, dynamic>)['timestamp'].toDate().second),
            () => tmp);
      });
    }
  }

  @override
  void initState() {
    super.initState();
    getData().then((item) {
      _selectedDay = _focusedDay;
      _selectedEvents = ValueNotifier(_getEventsForDay(_selectedDay!));
      loaded = true;
    });
  }

  @override
  void dispose() {
    _selectedEvents!.dispose();
    super.dispose();
  }

  List<Event> _getEventsForDay(DateTime day) {
    // Implementation example
    return kEvents[day] ?? [];
  }

  List<Event> _getEventsForRange(DateTime start, DateTime end) {
    // Implementation example
    final days = daysInRange(start, end);

    return [
      for (final d in days) ..._getEventsForDay(d),
    ];
  }

  void _onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    if (!isSameDay(_selectedDay, selectedDay)) {
      setState(() {
        _selectedDay = selectedDay;
        _focusedDay = focusedDay;
        _rangeStart = null; // Important to clean those
        _rangeEnd = null;
        _rangeSelectionMode = RangeSelectionMode.toggledOff;
      });

      _selectedEvents!.value = _getEventsForDay(selectedDay);
    }
  }

  void _onRangeSelected(DateTime? start, DateTime? end, DateTime focusedDay) {
    setState(() {
      _selectedDay = null;
      _focusedDay = focusedDay;
      _rangeStart = start;
      _rangeEnd = end;
      _rangeSelectionMode = RangeSelectionMode.toggledOn;
    });

    // start or end could be null
    if (start != null && end != null) {
      _selectedEvents!.value = _getEventsForRange(start, end);
    } else if (start != null) {
      _selectedEvents!.value = _getEventsForDay(start);
    } else if (end != null) {
      _selectedEvents!.value = _getEventsForDay(end);
    }
  }

  @override
  Widget build(BuildContext context) {
    try {
      return Scaffold(
        backgroundColor: vr.backGround,
        appBar: AppBar(backgroundColor: Colors.transparent, elevation: 0),
        body: loaded
            ? Column(
                children: [
                  TableCalendar<Event>(
                    firstDay: kFirstDay,
                    lastDay: kLastDay,
                    focusedDay: _focusedDay,
                    selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
                    rangeStartDay: _rangeStart,
                    rangeEndDay: _rangeEnd,
                    calendarFormat: _calendarFormat,
                    rangeSelectionMode: _rangeSelectionMode,
                    eventLoader: _getEventsForDay,
                    startingDayOfWeek: StartingDayOfWeek.monday,
                    headerStyle: HeaderStyle(
                      formatButtonVisible: false,
                      titleTextStyle: TextStyle(
                          color: Color(0xFFffffff),
                          fontSize: 20,
                          fontFamily: vr.basicFont),
                      leftChevronIcon: Icon(
                        Icons.keyboard_arrow_left,
                        color: Color(0xFFffffff),
                      ),
                      rightChevronIcon: Icon(
                        Icons.keyboard_arrow_right,
                        color: Color(0xFFffffff),
                      ),
                    ),
                    calendarStyle: CalendarStyle(
                      defaultTextStyle: const TextStyle(color: Colors.white),

                      // Use `CalendarStyle` to customize the UI

                      outsideDaysVisible: false,
                    ),
                    onDaySelected: _onDaySelected,
                    onRangeSelected: _onRangeSelected,
                    onFormatChanged: (format) {
                      if (_calendarFormat != format) {
                        setState(() {
                          _calendarFormat = format;
                        });
                      }
                    },
                    onPageChanged: (focusedDay) {
                      _focusedDay = focusedDay;
                    },
                  ),
                  const SizedBox(height: 0.0),
                  Expanded(
                    child: ValueListenableBuilder<List<Event>>(
                      valueListenable: _selectedEvents!,
                      builder: (context, value, _) {
                        try {
                          return ListView.builder(
                            shrinkWrap: true,
                            itemCount: value.length,
                            itemBuilder: (context, index) {
                              return Container(
                                margin: const EdgeInsets.symmetric(
                                  horizontal: 12.0,
                                  vertical: 0.0,
                                ),
                                decoration: BoxDecoration(
                                  color: vr.backGround,
                                  border: index % 7 == 6
                                      ? Border(
                                          bottom: BorderSide(
                                            width: 0.5,
                                            color: Color(0xFF354049),
                                          ),
                                        )
                                      : Border(
                                          bottom: BorderSide(
                                            width: 0,
                                            color: Color(0x00000000),
                                          ),
                                        ),
                                ),
                                child: Column(
                                  children: [
                                    ListTile(
                                      onTap: () => print('${value[index]}'),
                                      title: Text('${value[index]}',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontFamily: vr.basicFont)),
                                    ),
                                  ],
                                ),
                              );
                            },
                          );
                        } on Exception catch (e) {
                          return Container();
                        }
                      },
                    ),
                  ),
                ],
              )
            : Container(),
      );
    } on Exception catch (e) {
      return Container();
    }
  }
}
