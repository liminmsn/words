import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Home(),
      ),
    );
  }
}

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

enum Calendar { day, week, month, year }

enum ColorLabel {
  blue('Blue', Colors.blue),
  pink('Pink', Colors.pink),
  green('Green', Colors.green),
  yellow('Orange', Colors.orange),
  grey('Grey', Colors.grey);

  const ColorLabel(this.label, this.color);
  final String label;
  final Color color;
}

enum Character { musician, chef, firefighter, artist }

class _HomeState extends State<Home> {
  Calendar calendarView = Calendar.day;
  double _currentVolume = 0;
  bool isChecked = false;
  double timeDilation = 1.0;
  bool _lights = false;
  List<int> items = List<int>.generate(100, (int index) => index);

  Character? _character = Character.musician;

  void setCharacter(Character? value) {
    setState(() {
      _character = value;
    });
  }

  DateTime? selectedDate;
  TimeOfDay? selectedTime;

  @override
  Widget build(BuildContext context) {
    var date = selectedDate;
    var time = selectedTime;

    return Expanded(
      child: Center(
        child: Column(
          children: [
            SegmentedButton<Calendar>(
              segments: const <ButtonSegment<Calendar>>[
                ButtonSegment<Calendar>(
                  value: Calendar.day,
                  label: Text('Day'),
                  icon: Icon(Icons.calendar_view_day),
                ),
                ButtonSegment<Calendar>(
                    value: Calendar.week,
                    label: Text('Week'),
                    icon: Icon(Icons.calendar_view_week)),
                ButtonSegment<Calendar>(
                    value: Calendar.month,
                    label: Text('Month'),
                    icon: Icon(Icons.calendar_view_month)),
                ButtonSegment<Calendar>(
                    value: Calendar.year,
                    label: Text('Year'),
                    icon: Icon(Icons.calendar_today)),
              ],
              selected: <Calendar>{calendarView},
              onSelectionChanged: (newSelection) => {
                setState(() {
                  calendarView = newSelection.first;
                })
              },
            ),
            const SizedBox(
              width: 500,
              child: Wrap(
                alignment: WrapAlignment.center,
                spacing: 8,
                runSpacing: 4,
                children: [
                  Chip(
                    avatar: CircleAvatar(
                        backgroundImage:
                            AssetImage('assets/images/dash_chef.png')),
                    label: Text('Chef Dash'),
                  ),
                  Chip(
                    avatar: CircleAvatar(
                        backgroundImage:
                            AssetImage('assets/images/dash_firefighter.png')),
                    label: Text('Firefighter Dash'),
                  ),
                  Chip(
                    avatar: CircleAvatar(
                        backgroundImage:
                            AssetImage('assets/images/dash_musician.png')),
                    label: Text('Musician Dash'),
                  ),
                  Chip(
                    avatar: CircleAvatar(
                        backgroundImage:
                            AssetImage('assets/images/dash_artist.png')),
                    label: Text('Artist Dash'),
                  ),
                ],
              ),
            ),
            DropdownMenu<ColorLabel>(
              initialSelection: ColorLabel.green,
              // controller: colorController,
              // requestFocusOnTap is enabled/disabled by platforms when it is null.
              // On mobile platforms, this is false by default. Setting this to true will
              // trigger focus request on the text field and virtual keyboard will appear
              // afterward. On desktop platforms however, this defaults to true.
              requestFocusOnTap: true,
              label: const Text('Color'),
              onSelected: (ColorLabel? color) {
                setState(() {
                  // selectedColor = color;
                });
              },
              dropdownMenuEntries: ColorLabel.values
                  .map<DropdownMenuEntry<ColorLabel>>((ColorLabel color) {
                return DropdownMenuEntry<ColorLabel>(
                  value: color,
                  label: color.label,
                  enabled: color.label != 'Grey',
                  style: MenuItemButton.styleFrom(
                    foregroundColor: color.color,
                  ),
                );
              }).toList(),
            ),
            Slider(
              value: _currentVolume,
              max: 5,
              divisions: 5,
              label: _currentVolume.toString(),
              onChanged: (double value) {
                setState(() {
                  _currentVolume = value;
                });
              },
            ),
            Checkbox(
              checkColor: Colors.white,
              value: isChecked,
              onChanged: (bool? value) {
                setState(() {
                  isChecked = value!;
                });
              },
            ),
            Switch(
              // This bool value toggles the switch.
              value: isChecked,
              activeColor: Colors.red,
              onChanged: (bool value) {
                // This is called when the user toggles the switch.
                setState(() {
                  isChecked = value;
                });
              },
            ),
            ListTile(
              title: const Text('Musician'),
              leading: Radio<Character>(
                value: Character.musician,
                groupValue: _character,
                onChanged: setCharacter,
              ),
            ),
            ListTile(
              title: const Text('Chef'),
              leading: Radio<Character>(
                value: Character.chef,
                groupValue: _character,
                onChanged: setCharacter,
              ),
            ),
            ListTile(
              title: const Text('Firefighter'),
              leading: Radio<Character>(
                value: Character.firefighter,
                groupValue: _character,
                onChanged: setCharacter,
              ),
            ),
            ListTile(
              title: const Text('Artist'),
              leading: Radio<Character>(
                value: Character.artist,
                groupValue: _character,
                onChanged: setCharacter,
              ),
            ),
            CheckboxListTile(
              title: const Text('Animate Slowly'),
              value: timeDilation != 1.0,
              onChanged: (bool? value) {
                setState(() {
                  timeDilation = value! ? 10.0 : 1.0;
                });
              },
              secondary: const Icon(Icons.hourglass_empty),
            ),
            SwitchListTile(
              title: const Text('Lights'),
              value: _lights,
              onChanged: (bool value) {
                setState(() {
                  _lights = value;
                });
              },
              secondary: const Icon(Icons.lightbulb_outline),
            ),
            Text(
              date == null
                  ? "You haven't picked a date yet."
                  : DateFormat('MM-dd-yyyy').format(date),
            ),
            ElevatedButton.icon(
              icon: const Icon(Icons.calendar_today),
              onPressed: () async {
                var pickedDate = await showDatePicker(
                  context: context,
                  initialEntryMode: DatePickerEntryMode.calendarOnly,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(2019),
                  lastDate: DateTime(2050),
                );

                setState(() {
                  selectedDate = pickedDate;
                });
              },
              label: const Text('Pick a date'),
            ),
            Text(
              time == null
                  ? "You haven't picked a time yet."
                  : time.format(context),
            ),
            ElevatedButton.icon(
              icon: const Icon(Icons.calendar_today),
              onPressed: () async {
                var pickedTime = await showTimePicker(
                  context: context,
                  initialEntryMode: TimePickerEntryMode.dial,
                  initialTime: TimeOfDay.now(),
                );

                setState(() {
                  selectedTime = pickedTime;
                });
              },
              label: const Text('Pick a date'),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: items.length,
                padding: const EdgeInsets.symmetric(vertical: 16),
                itemBuilder: (BuildContext context, int index) {
                  return Dismissible(
                    background: Container(
                      color: Colors.green,
                    ),
                    key: ValueKey<int>(items[index]),
                    onDismissed: (DismissDirection direction) {
                      setState(() {
                        items.removeAt(index);
                      });
                    },
                    child: ListTile(
                      title: Text(
                        'Item ${items[index]}',
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
