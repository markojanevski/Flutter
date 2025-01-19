import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'map_screen.dart';

class CalendarScreen extends StatefulWidget {
  @override
  _CalendarScreenState createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  Map<DateTime, List<Map<String, dynamic>>> events = {};

  void _addEvent(DateTime date, String time, String location) {
    setState(() {
      if (events[date] == null) {
        events[date] = [];
      }
      events[date]!.add({'time': time, 'location': location});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Exam Schedule'),
      ),
      body: Column(
        children: [
          TableCalendar(
            focusedDay: DateTime.now(),
            firstDay: DateTime.utc(2020, 1, 1),
            lastDay: DateTime.utc(2030, 12, 31),
            eventLoader: (day) => events[day] ?? [],
            onDaySelected: (selectedDay, focusedDay) {
              showDialog(
                context: context,
                builder: (context) {
                  String time = '';
                  String location = '';
                  return AlertDialog(
                    title: Text('Add Event'),
                    content: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        TextField(
                          decoration: InputDecoration(labelText: 'Time'),
                          onChanged: (value) => time = value,
                        ),
                        TextField(
                          decoration: InputDecoration(labelText: 'Location'),
                          onChanged: (value) => location = value,
                        ),
                      ],
                    ),
                    actions: [
                      TextButton(
                        onPressed: () {
                          _addEvent(selectedDay, time, location);
                          Navigator.pop(context);
                        },
                        child: Text('Save'),
                      ),
                    ],
                  );
                },
              );
            },
          ),
          Expanded(
            child: ListView(
              children: events.entries.expand((entry) {
                final date = entry.key;
                final dayEvents = entry.value;
                return dayEvents.map((event) {
                  return ListTile(
                    title: Text(
                      '${event['time']} at ${event['location']}',
                    ),
                    subtitle: Text(date.toIso8601String()),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => MapScreen(
                            location: event['location'],
                          ),
                        ),
                      );
                    },
                  );
                }).toList();
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}
