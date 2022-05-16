import 'package:firstapp/Admin/SelectStudent.dart';
import 'package:firstapp/HomePage.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'AddStudent.dart';
import 'ChangePassword.dart';
import 'CreateExam.dart';

class AdminRoute extends StatelessWidget {
  const AdminRoute({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const MyHomePage(title: 'Home')));
          return false;
        },
        child: Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.red[800],
              title: const Text('Admin Route'),
              actions: [
                ElevatedButton(
                    onPressed: () => {
                          FirebaseAuth.instance.signOut().then((value) =>
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const MyHomePage(title: 'Home')))),
                        },
                    child: const Text("Log uit")),
              ],
            ),
            body: Center(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const CreateExam(
                                list: [],
                              )),
                    );
                  },
                  child: const Text('Examenvragen aanmaken'),
                  style: ElevatedButton.styleFrom(
                      primary: Colors.red[800],
                      fixedSize: const Size(400, 80),
                      textStyle: const TextStyle(
                          fontSize: 24, fontWeight: FontWeight.bold)),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const AddStudents()),
                    );
                  },
                  child: const Text('Studentenlijst'),
                  style: ElevatedButton.styleFrom(
                      primary: Colors.red[800],
                      fixedSize: const Size(400, 80),
                      textStyle: const TextStyle(
                          fontSize: 24, fontWeight: FontWeight.bold)),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const SelectStudent()),
                    );
                  },
                  child: const Text('Examen verbeteren'),
                  style: ElevatedButton.styleFrom(
                      primary: Colors.red[800],
                      fixedSize: const Size(400, 80),
                      textStyle: const TextStyle(
                          fontSize: 24, fontWeight: FontWeight.bold)),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const ChangePasswordWidget()),
                    );
                  },
                  child: const Text('Wachtwoord Wijzigen'),
                  style: ElevatedButton.styleFrom(
                      primary: Colors.red[800],
                      fixedSize: const Size(400, 80),
                      textStyle: const TextStyle(
                          fontSize: 24, fontWeight: FontWeight.bold)),
                ),
              ],
            ))));
  }
}
