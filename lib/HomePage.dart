import 'package:flutter/material.dart';

import 'Admin/LoginPage.dart';


class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            backgroundColor: Colors.red[800],
            title: Row(
              children: [
                Image.asset(
                  'assets/AP_logo_basis.png',
                  fit: BoxFit.contain,
                  height: 32,
                ),
                Container(
                    padding: const EdgeInsets.all(20.0),
                    child: Text(widget.title))
              ],
            )),
        body: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const LoginPage()),
                    );
                  },
                  child: const Text("Admin"),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.red[800],
                    padding: const EdgeInsets.all(100.0),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {},
                  child: const Text("Student"),
                  style: ElevatedButton.styleFrom(
                      primary: Colors.red[800],
                      padding: const EdgeInsets.all(100.0)),
                ),
              ],
            )));
  }
}