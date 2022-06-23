import 'package:firebase_cloud_messaging/service/push_notification.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

import 'package:flutter/material.dart';

Future<void> backgroundHandler(RemoteMessage message) async {
  NotificationService.display(message);
  print(message.data.toString());
  print(message.notification!.title);
  // FlutterRingtonePlayer.play(
  //   android: AndroidSounds.ringtone,
  //   ios: IosSounds.glass,
  //   // looping: true, // Android only - API >= 28
  //   volume: 1, // Android only - API >= 28
  //   asAlarm: false, // Android only - all APIs
  // );
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  WidgetsFlutterBinding.ensureInitialized();
  NotificationService.initialize();
  //await Firebase.initializeApp();
  FirebaseMessaging.instance.getInitialMessage();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    print('i am initState');
    super.initState();
    FirebaseMessaging.instance.getInitialMessage();
    FirebaseMessaging.onMessage.listen((message) {
      print('i am message');
      if (message.notification != null) {
        print(message.notification!.body);
        print(message.notification!.title);
      } else {
        print(message);
      }
      NotificationService.display(message);
      // FlutterRingtonePlayer.play(
      //   android: AndroidSounds.ringtone,
      //   ios: IosSounds.glass,
      //   // looping: true, // Android only - API >= 28
      //   volume: 1, // Android only - API >= 28
      //   asAlarm: false, // Android only - all APIs
      // );
    });
// on app breckgroud
    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      NotificationService.display(message);
      // FlutterRingtonePlayer.play(
      //   android: AndroidSounds.ringtone,
      //   ios: IosSounds.glass,
      //   // looping: true, // Android only - API >= 28
      //   volume: 1, // Android only - API >= 28
      //   asAlarm: false, // Android only - all APIs
      // );
    });
// App Backgroud
    FirebaseMessaging.onBackgroundMessage(backgroundHandler);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          child: Text('Push Notificaiton'),
        ),
      ),
    );
  }
}
