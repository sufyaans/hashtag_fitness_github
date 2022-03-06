import 'package:flutter/material.dart';
import 'package:hashtag_fitness/variables.dart';
import 'package:table_calendar/table_calendar.dart';
import 'dart:collection';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

/// Example event class.
class Event {
  final String title;
  const Event(this.title);

  @override
  String toString() => title;
}

/// Example events.
///
/// Using a [LinkedHashMap] is highly recommended if you decide to use a map.
final kEvents = LinkedHashMap<DateTime, List<Event>>(
  equals: isSameDay,
  hashCode: getHashCode,
)..addAll(_kEventSource);
final _kEventSource = Map<DateTime, List<Event>>();
// final _kEventSource = Map.fromIterable(List.generate(50, (index) => index),
//     key: (item) => DateTime.utc(kFirstDay.year, kFirstDay.month, item * 5),
//     value: (item) => List.generate(
//         item % 4 + 1, (index) => Event('Event $item | ${index + 1}')))
//   ..addAll({
//     kToday: [
//       Event('Today\'s Event 1'),
//       Event('Today\'s Event 2'),
//     ],
//   });

int getHashCode(DateTime key) {
  return key.day * 1000000 + key.month * 10000 + key.year;
}

/// Returns a list of [DateTime] objects from [first] to [last], inclusive.
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

class Calendar extends StatefulWidget {
  @override
  _CalendarState createState() => _CalendarState();
}

class _CalendarState extends State<Calendar> {
  ValueNotifier<List<Event>>? _selectedEvents;
  CalendarFormat _calendarFormat = CalendarFormat.month;
  RangeSelectionMode _rangeSelectionMode = RangeSelectionMode
      .toggledOff; // Can be toggled on/off by longpressing a date
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  DateTime? _rangeStart;
  DateTime? _rangeEnd;
  bool loaded = false;

  Future<void> getData() async {
    // Get docs from collection reference
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('Measurements')
        .get();
    // setState(() {
    //   _kEventSource = Map.fromIterable(List.generate(50, (index) => index),
    //       key: (item) =>
    //           DateTime.utc(kFirstDay.year, kFirstDay.month, item * 5),
    //       value: (item) => List.generate(
    //           item % 4 + 1, (index) => Event('Event $item | ${index + 1}')))
    //     ..addAll({
    //       kToday: [
    //         Event('Today\'s Event 1'),
    //         Event('Today\'s Event 2'),
    //       ],
    //     });
    // });
    // print(_kEventSource);
    // Get data from docs and convert map to List
    final allData = await querySnapshot.docs.map((doc) => doc.data()).toList();
    print(allData);
    for (var i in allData) {
      setState(() {
        if ((i! as Map<String, dynamic>)['Dummy'] != 'Dummy') {
          _kEventSource.putIfAbsent(
              DateTime.utc(
                  (i as Map<String, dynamic>)['timestamp'].toDate().year,
                  (i as Map<String, dynamic>)['timestamp'].toDate().month,
                  (i as Map<String, dynamic>)['timestamp'].toDate().day),
              () => [
                    Event("Body Weight (KG): " +
                        '${(i as Map<String, dynamic>)['Body Weight (KG)']}'),
                    Event("Body Fat (%): " +
                        '${(i as Map<String, dynamic>)['Body Fat (%)']}'),
                    Event("Chest Measurement (CM): " +
                        '${(i as Map<String, dynamic>)['Chest Measurement (CM)']}'),
                    Event("Waist Measurement (CM): " +
                        '${(i as Map<String, dynamic>)['Waist Measurement (CM)']}'),
                    Event("Neck Measurement (CM): " +
                        '${(i as Map<String, dynamic>)['Neck Measurement (CM)']}'),
                    Event("Right Arm Measurement (CM): " +
                        '${(i as Map<String, dynamic>)['Right Arm Measurement (CM)']}'),
                    Event("Left Arm Measurement (CM): " +
                        '${(i as Map<String, dynamic>)['Left Arm Measurement (CM)']}'),
                    Event("Right Thigh Measurement (CM): " +
                        '${(i as Map<String, dynamic>)['Right Thigh Measurement (CM)']}'),
                    Event("Left Thigh Measurement (CM): " +
                        '${(i as Map<String, dynamic>)['Left Thigh Measurement (CM)']}'),
                    Event("Hip Measurement (CM): " +
                        '${(i as Map<String, dynamic>)['Hip Measurement (CM)']}'),
                  ]);
        }
        print(_kEventSource);
      });
    }
    print(allData);
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

    // `start` or `end` could be null
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
                    calendarStyle: CalendarStyle(
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
                  const SizedBox(height: 8.0),
                  Expanded(
                    child: ValueListenableBuilder<List<Event>>(
                      valueListenable: _selectedEvents!,
                      builder: (context, value, _) {
                        try {
                          return ListView.builder(
                            itemCount: value.length,
                            itemBuilder: (context, index) {
                              return Container(
                                margin: const EdgeInsets.symmetric(
                                  horizontal: 12.0,
                                  vertical: 4.0,
                                ),
                                decoration: BoxDecoration(
                                    color: backGround,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(12))),
                                child: ListTile(
                                  onTap: () => print('${value[index]}'),
                                  title: Text('${value[index]}',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontFamily: basicFont)),
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
