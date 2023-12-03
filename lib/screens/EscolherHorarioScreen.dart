import 'package:flutter/material.dart';
import 'package:android_alarm_manager/android_alarm_manager.dart';
import 'package:just_audio/just_audio.dart';
import 'package:path_provider/path_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initPathProvider();
  await AndroidAlarmManager.initialize();
  runApp(MyApp());
}

Future<void> initPathProvider() async {
  await PathProviderPlatform.instance.init();
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
  final AudioPlayer player = AudioPlayer();

  @override
  void initState() {
    super.initState();
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
    await AndroidAlarmManager.oneShotAt(
      _nextInstanceOfSelectedTime(),
      0,
      _onAlarm,
      exact: true,
      wakeup: true,
    );
  }

  DateTime _nextInstanceOfSelectedTime() {
    final now = DateTime.now();
    var scheduledDate = DateTime(
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

  void _onAlarm() async {
    print('Alarme disparado em ${DateTime.now()}');
    await _playAudio('assets/audio/alarm_clock_old.mp3');
  }

  Future<void> _playAudio(String assetPath) async {
    try {
      String path = await _getLocalPath(assetPath);
      await player.setFilePath(path);
      await player.play();
    } catch (e) {
      // Erro ao reproduzir o áudio
      print('Erro ao reproduzir o áudio: $e');
    }
  }

  Future<String> _getLocalPath(String assetPath) async {
    final appDir = await getApplicationDocumentsDirectory();
    return '${appDir.path}/$assetPath';
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

  @override
  void dispose() {
    player.dispose();
    super.dispose();
  }
}
