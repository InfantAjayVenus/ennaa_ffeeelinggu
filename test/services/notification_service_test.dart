import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:ennaa_ffeeelinggu/src/services/notification_service.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

import 'notification_service_test.mocks.dart';

@GenerateMocks([FlutterLocalNotificationsPlugin])
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  tz.initializeTimeZones();

  group('NotificationService', () {
    late NotificationService notificationService;
    late MockFlutterLocalNotificationsPlugin mockFlutterLocalNotificationsPlugin;

    setUp(() {
      mockFlutterLocalNotificationsPlugin = MockFlutterLocalNotificationsPlugin();
      notificationService = NotificationService(plugin: mockFlutterLocalNotificationsPlugin);
    });

    test('initialize calls initialize on plugin', () async {
      when(mockFlutterLocalNotificationsPlugin.initialize(
        any,
        onDidReceiveNotificationResponse: anyNamed('onDidReceiveNotificationResponse'),
        onDidReceiveBackgroundNotificationResponse: anyNamed('onDidReceiveBackgroundNotificationResponse'),
      )).thenAnswer((_) async => true);

      await notificationService.initialize();

      verify(mockFlutterLocalNotificationsPlugin.initialize(
        any,
        onDidReceiveNotificationResponse: anyNamed('onDidReceiveNotificationResponse'),
        onDidReceiveBackgroundNotificationResponse: anyNamed('onDidReceiveBackgroundNotificationResponse'),
      )).called(1);
    });

    test('scheduleHourlyReminder schedules a notification', () async {
      when(mockFlutterLocalNotificationsPlugin.zonedSchedule(
        any,
        any,
        any,
        any,
        any,
        androidScheduleMode: anyNamed('androidScheduleMode'),
        uiLocalNotificationDateInterpretation: anyNamed('uiLocalNotificationDateInterpretation'),
        matchDateTimeComponents: anyNamed('matchDateTimeComponents'),
      )).thenAnswer((_) async => {});

      await notificationService.scheduleHourlyReminder();

      verify(mockFlutterLocalNotificationsPlugin.zonedSchedule(
        any,
        'Time to log your mood!',
        'How are you feeling and what are you doing?',
        any,
        any,
        androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
        uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime,
        matchDateTimeComponents: DateTimeComponents.time,
      )).called(1);
    });
  });
}
