import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'AdminRoute.dart';

class ConfirmStudentsPage extends StatefulWidget {
  const ConfirmStudentsPage({Key? key, required this.list}) : super(key: key);

  final List<List> list;

  @override
  _ConfirmStudentsState createState() => _ConfirmStudentsState();
}

class _ConfirmStudentsState extends State<ConfirmStudentsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Studenten bevestigen'),
        ),
        floatingActionButton:
        ElevatedButton(
          child: const Text("Bevestig"),
          onPressed: () {
            for (var i = 0; i < widget.list.length; i++) {
              AddStudent(widget.list[i]);

            }
            Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const AdminRouteState( )));
          },
        ),
        body: ListView.builder(
            padding: const EdgeInsets.all(8),
            itemCount: widget.list.length,
            itemBuilder: (BuildContext context, int index) {
              return Container(
                height: 50,
                margin: const EdgeInsets.all(2),
                color: Colors.grey[400],
                child: Center(
                    child: Text(
                      'Naam: ${widget.list[index][1]} Voornaam: ${widget.list[index][0]}  S-Nummer: ${widget.list[index][2]} ',
                      style: const TextStyle(fontSize: 18),
                    )),
              );
            }));
  }

  CollectionReference students =
  FirebaseFirestore.instance.collection('students');
  // ignore: non_constant_identifier_names
  Future<void> AddStudent(List student) {
    return students.add({
      'name': student[1],
      'firstname': student[0],
      'snumber': student[2]
    }).catchError((error) => throw ("Mislukt user toe te voegen: $error"));
  }
}
