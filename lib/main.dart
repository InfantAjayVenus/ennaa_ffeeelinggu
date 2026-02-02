import 'package:ennaa_ffeeelinggu/src/providers/journal_provider.dart';
import 'package:ennaa_ffeeelinggu/src/screens/main_screen.dart';
import 'package:ennaa_ffeeelinggu/src/services/notification_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  tz.initializeTimeZones();

  final NotificationService notificationService = NotificationService();
  await notificationService.initialize();
  await notificationService.scheduleHourlyReminder();

  runApp(
    ChangeNotifierProvider(
      create: (context) => JournalProvider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Ennaa Fffeeelinggu',
      theme: ThemeData(
        colorScheme: .fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const MainScreen(),
    );
  }
}

