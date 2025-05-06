import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';
import 'package:lottie/lottie.dart'; 
import 'custom_app_bar.dart';
import 'dart:convert';
import 'package:flutter/services.dart';

class EventsPage extends StatefulWidget {
  final Function(bool) onThemeChanged;

  const EventsPage({super.key, required this.onThemeChanged});

  @override
  _EventsPageState createState() => _EventsPageState();
}

class _EventsPageState extends State<EventsPage> {
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  bool _isEventDay = false;
  bool _hasCelebrationPlayed = false; 

  final Map<DateTime, Map<String, dynamic>> _events = {};
  final Map<DateTime, Map<String, dynamic>> _pastEvents = {};

  @override
  void initState() {
    super.initState();
    _loadEventsFromFile();
  }


  // Function to add events dynamically
  void addEvent(DateTime date, Map<String, dynamic> eventDetails) {
    setState(() {
      _events[DateUtils.dateOnly(date)] = eventDetails;
    });
  }

  Future<void> _loadEventsFromFile() async {

    String data = await rootBundle.loadString('events.json');
    List<dynamic> jsonData = jsonDecode(data);

    for (var event in jsonData) {
      DateTime eventDate = DateTime.parse(event['date']);
      String eventType = event['type'];

      // Assign event icon and color based on the type of event
      IconData eventIcon;
      Color eventColor;
      BoxShape eventShape;

      switch (eventType) {
        case 'meeting':
          eventIcon = Icons.group;
          eventColor = Colors.blueAccent;
          eventShape = BoxShape.circle;
          break;
        case 'competition':
          eventIcon = Icons.code;
          eventColor = Colors.redAccent;
          eventShape = BoxShape.rectangle;
          break;
        default:
          eventIcon = Icons.star;
          eventColor = Colors.green;
          eventShape = BoxShape.circle;
          break;
      }
      //add to prev
      if (eventDate.isBefore(DateTime.now())) {
        _pastEvents[DateUtils.dateOnly(eventDate)] = {
          'title': event['name'],
          'icon': eventIcon,
          'color': eventColor,
          'registrations': 0,
          'isRegistered': false,
          'shape': eventShape,
          'time': eventDate.toLocal().toString().split(' ')[1].substring(0, 5), // Extract time
          'place': event['place'],
        };
      } else{
        // Add the event to the _events map
        _events[DateUtils.dateOnly(eventDate)] = {
          'title': event['name'],
          'icon': eventIcon,
          'color': eventColor,
          'registrations': 0,
          'isRegistered': false,
          'shape': eventShape,
          'time': eventDate.toLocal().toString().split(' ')[1].substring(0, 5), // Extract time
          'place': event['place'],
        };
      }
    }

    setState(() {}); // Rebuild the UI with the loaded events
  }

  List<Map<String, dynamic>> _getEventsForDay(DateTime day) {
    DateTime onlyDate = DateUtils.dateOnly(day);
    if (_events.containsKey(onlyDate)) {
      return [_events[onlyDate]!];
    }
    if (_pastEvents.containsKey(onlyDate)) {
      return [_pastEvents[onlyDate]!];
    }
    return [];
  }

  Widget _buildUpcomingEventsList() {
      List<Map<String, dynamic>> upcomingEvents = _events.entries
          .map((entry) => {
                'date': entry.key,
                'title': entry.value['title'],
                'icon': entry.value['icon'],
                'time': entry.value['time'],
                'place': entry.value['place'],
                'registrations': entry.value['registrations'],
              })
          .toList();

      return ListView.builder(
        itemCount: upcomingEvents.length,
        itemBuilder: (context, index) {
          var event = upcomingEvents[index];
          DateTime eventDate = event['date'];
          return ListTile(
            leading: Icon(event['icon']),
            title: Text("${event['title']} on ${eventDate.month}/${eventDate.day}"),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Time: ${event['time']}"),
                Text("Place: ${event['place']}"),
                Text("Registrations: ${event['registrations']}"),
              ],
            ),
          );
        },
      );
    }

  Widget _buildPastEventsList() {
    List<Map<String, dynamic>> pastEvents = _pastEvents.entries
        .map((entry) => {
              'date': entry.key,
              'title': entry.value['title'],
              'icon': entry.value['icon'],
              'time': entry.value['time'],
              'place': entry.value['place'],
              'registrations': entry.value['registrations'],
            })
        .toList();

    return ListView.builder(
      itemCount: pastEvents.length,
      itemBuilder: (context, index) {
        var event = pastEvents[index];
        DateTime eventDate = event['date'];
        return ListTile(
          leading: Icon(event['icon']),
          title: Text("${event['title']} on ${eventDate.month}/${eventDate.day}"),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Time: ${event['time']}"),
              Text("Place: ${event['place']}"),
              Text("Registrations: ${event['registrations']}"),
            ],
          ),
        );
      },
    );
  }

  void _showRegistrationDialog(String eventTitle, DateTime eventDate) {
    if (eventDate.isBefore(DateTime.now())) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('This event has already passed!')),
      );
      return;
    }

    showDialog(
      context: context,
      builder: (BuildContext context) {
        DateTime key = DateUtils.dateOnly(eventDate);
        bool isRegistered = _events[key]!['isRegistered'];
        String eventTime = _events[key]!['time'];
        String eventPlace = _events[key]!['place'];

        return AlertDialog(
          title: Text('Register for $eventTitle'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Time: $eventTime'),
              Text('Place: $eventPlace'),
              const SizedBox(height: 10),
              isRegistered
                ? const Text('You have already registered for this event.')
                : const Text('Would you like to register for this event?'),
            ],
          ),
          actions: isRegistered
              ? [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text('OK'),
                  ),
                ]
              : [
                  TextButton(
                    onPressed: () {
                      setState(() {
                        _events[key]!['registrations'] += 1;
                        _events[key]!['isRegistered'] = true;
                      });
                      Navigator.of(context).pop();
                      ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Registration confirmed!')));
                    },
                    child: const Text('Yes'),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text('No'),
                  ),
                ],
        );
      },
    );
  }

  Widget _celebrateEventDay() {
    if (_hasCelebrationPlayed) return Container();

    _hasCelebrationPlayed = true;
    return Lottie.asset(
      'celebration.json',
      repeat: false, 
      onLoaded: (composition) {
        Future.delayed(composition.duration, () {
          setState(() {
            _hasCelebrationPlayed = true;
          });
        });
      },
    );
  }

// Modify this function to correctly pick the closest event from today
  DateTime? _getNextEventDate() {
    DateTime now = DateTime.now();
    // Convert the map keys (dates) to a list, filter out past events, and sort the future events
    List<DateTime> futureEvents = _events.keys
        .where((date) => date.isAfter(now)) // Only future events
        .toList()
      ..sort(); // Sort the list of dates in ascending order
    if (futureEvents.isNotEmpty) {
      return futureEvents.first; // Return the closest future event
    }
    return null; // If no future events, return null
  }

  Widget _buildCountdownTimer() {
    DateTime? nextEventDate = _getNextEventDate();
    DateTime today = DateUtils.dateOnly(DateTime.now());


    if (_events.containsKey(today)) {
      String eventTitle = _events[today]!['title'];
      return Text(
        '$eventTitle is happening today!',
        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      );
    }


    if (nextEventDate != null) {
      int endTime = nextEventDate.millisecondsSinceEpoch;
      return CountdownTimer(
        endTime: endTime,
        widgetBuilder: (_, time) {
          if (time == null) {
            return const Text(
              'Next event has started!',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            );
          }
          return Text(
            'Next event in: ${time.days ?? 0}d ${time.hours ?? 0}h ${time.min ?? 0}m',
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          );
        },
      );
    }
    return const Text('No upcoming events', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold));
  }

  @override
  // Add a variable to track the selected dropdown option
String _selectedEventFilter = 'Upcoming events';

// Dropdown menu options
final List<String> _eventFilterOptions = ['Upcoming events', 'Past events'];

// Modify the build method to include a dropdown selection

@override
  Widget build(BuildContext context) {
  DateTime today = DateUtils.dateOnly(DateTime.now());

  _isEventDay = _events.containsKey(today);

  return Scaffold(
    appBar: customAppBar(context, "Events and Activities", widget.onThemeChanged),
    body: Column(
      children: [
        if (_isEventDay && !_hasCelebrationPlayed)
          Center(
            child: Opacity(
              opacity: 0.7,
              child: _celebrateEventDay(),
            ),
          ),
        TableCalendar(
          // Same TableCalendar setup as before
          locale: "en_US",
          headerStyle: const HeaderStyle(formatButtonVisible: false, titleCentered: true),
          availableGestures: AvailableGestures.all,
          firstDay: DateTime.utc(2023, 1, 1),
          lastDay: DateTime.utc(2030, 12, 31),
          focusedDay: _focusedDay,
          selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
          onDaySelected: (selectedDay, focusedDay) {
            setState(() {
              _selectedDay = selectedDay;
              _focusedDay = focusedDay;
            });

            final events = _getEventsForDay(selectedDay);
            if (events.isNotEmpty) {
              _showRegistrationDialog(events.first['title'], DateUtils.dateOnly(selectedDay));
            }
          },
          eventLoader: (day) => _getEventsForDay(day).map((event) => event['title']).toList(),
          calendarStyle: CalendarStyle(
            todayDecoration: BoxDecoration(
              color: Theme.of(context).brightness == Brightness.dark
                  ? Colors.lightBlueAccent
                  : Colors.blueAccent,
              shape: BoxShape.circle,
            ),
            selectedDecoration: BoxDecoration(
              color: Theme.of(context).brightness == Brightness.dark ? Colors.lightBlue : Colors.blue,
              shape: BoxShape.circle,
            ),
          ),
          calendarBuilders: CalendarBuilders(
            markerBuilder: (context, day, events) {
              if (events.isNotEmpty) {
                final event = _getEventsForDay(day);
                return Positioned(
                  bottom: 1,
                  child: Container(
                    width: 8.0,
                    height: 8.0,
                    decoration: BoxDecoration(
                      color: event.first['color'],
                      shape: event.first['shape'],
                    ),
                  ),
                );
              }
              return null;
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: _buildCountdownTimer(),
        ),
        // Dropdown to toggle between Upcoming and Past events
        // Dropdown to toggle between Upcoming and Past events with custom styling
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Container(
            decoration: BoxDecoration(
              color: Theme.of(context).scaffoldBackgroundColor, // Matches background color
              borderRadius: BorderRadius.circular(8.0),
              border: Border.all(color: Colors.grey.shade300), // Optional border for contrast
            ),
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: DropdownButton<String>(
              value: _selectedEventFilter,
              items: _eventFilterOptions.map((String option) {
                return DropdownMenuItem<String>(
                  value: option,
                  child: Text(option),
                );
              }).toList(),
              onChanged: (String? newValue) {
                setState(() {
                  _selectedEventFilter = newValue!;
                });
              },
              isExpanded: true, // Makes dropdown fill the container width
              underline: const SizedBox(), // Removes the default underline
              dropdownColor: Theme.of(context).scaffoldBackgroundColor, // Matches dropdown menu background color
              icon: Icon(Icons.arrow_drop_down, color: Theme.of(context).primaryColor), // Custom icon color
            ),
          ),
        ),

        Expanded(
          child: _selectedEventFilter == 'Upcoming events'
              ? _buildUpcomingEventsList()
              : _buildPastEventsList(),
        ),
      ],
    ),
  );
}

}
