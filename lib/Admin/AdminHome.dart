import 'package:firstapp/Admin/SelectStudent.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'AddStudent.dart';
import 'ChangePassword.dart';
import 'CreateExam.dart';

class AdminRoute extends StatelessWidget {
  const AdminRoute({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.red[800],
          title: const Text('Admin Route'),
          actions: [
            ElevatedButton(
                onPressed: () => FirebaseAuth.instance.signOut(),
                child: const Text("Sign out")),
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
                      padding: const EdgeInsets.fromLTRB(300.0, 75.0, 300.0, 75.0)),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const AddStudents()),
                    );
                  },
                  child: const Text('Studentenlijst'),
                  style: ElevatedButton.styleFrom(
                      primary: Colors.red[800],
                      padding: const EdgeInsets.fromLTRB(338.0, 75.0, 338.0, 75.0)),
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
                      padding: const EdgeInsets.fromLTRB(315.0, 75.0, 315.0, 75.0)),
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
                      padding: const EdgeInsets.fromLTRB(315.0, 75.0, 315.0, 75.0)),
                ),
              ],
            )));
  }
}
