import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

import 'HomePage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: const FirebaseOptions(
          apiKey: 'AIzaSyDmvRKhdCnPR1ZmUmJ6YoNzFZ9wx4998D0',
          appId: 'project-425922472925',
          messagingSenderId: '425922472925',
          projectId: 'intromobile-740ff'));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme:
            ColorScheme.fromSwatch().copyWith(primary: Colors.red[800]),
      ),
      home: const MyHomePage(title: 'Intro Mobile'),
    );
  }
}

