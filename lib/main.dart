import 'package:flutter/material.dart';
import 'package:android_alarm_manager/android_alarm_manager.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest.dart' as tzdata;
import 'package:timezone/timezone.dart' as tz;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AndroidAlarmManager.initialize();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Meu App',
      home: EscolherHorarioScreen(),
    );
  }
}

class EscolherHorarioScreen extends StatefulWidget {
  @override
  _EscolherHorarioScreenState createState() => _EscolherHorarioScreenState();
}

class _EscolherHorarioScreenState extends State<EscolherHorarioScreen> {
  TimeOfDay _selectedTime = TimeOfDay.now();
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
  FlutterLocalNotificationsPlugin();

  @override
  void initState() {
    super.initState();
    tzdata.initializeTimeZones();

    final InitializationSettings initializationSettings =
    InitializationSettings(
      android: AndroidInitializationSettings('app_icon'), // Substitua pelo nome do seu ícone de aplicativo
    );
    flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: _selectedTime,
    );

    if (picked != null && picked != _selectedTime) {
      setState(() {
        _selectedTime = picked;
      });

      _scheduleAlarm();
    }
  }

  Future<void> _scheduleAlarm() async {
    tz.TZDateTime scheduledDate = _nextInstanceOfSelectedTime();

    await AndroidAlarmManager.oneShotAt(
      scheduledDate,
      0,
      _onAlarm,
      exact: true,
      wakeup: true,
    );
  }

  tz.TZDateTime _nextInstanceOfSelectedTime() {
    final now = tz.TZDateTime.now(tz.local);
    var scheduledDate = tz.TZDateTime(
      tz.local,
      now.year,
      now.month,
      now.day,
      _selectedTime.hour,
      _selectedTime.minute,
    );

    if (scheduledDate.isBefore(now)) {
      scheduledDate = scheduledDate.add(const Duration(days: 1));
    }

    return scheduledDate;
  }

  void _onAlarm() {
    print('Alarme disparado em ${DateTime.now()}');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal[800],
        title: Text(
          'Escolher Horário',
          style: TextStyle(fontSize: 24, color: Colors.white),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            'Horário Selecionado para Tomar o Remédio: ${_selectedTime.format(context)}',
            style: TextStyle(fontSize: 20),
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () => _selectTime(context),
            child: Text('Selecionar Horário'),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.teal[900],
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
