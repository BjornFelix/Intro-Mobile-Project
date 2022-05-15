import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'AddQuestion.dart';
import 'AdminHome.dart';

class MakeExam extends StatefulWidget {
  const MakeExam({Key? key, required this.list}) : super(key: key);

  final List<List> list;
  @override
  State<MakeExam> createState() => _MakeExamState();
}

class _MakeExamState extends State<MakeExam> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.red[800],
          title: const Text('Add exam questions'),
          actions: [
            ElevatedButton(
<<<<<<< Updated upstream:lib/Admin/MakeExam.dart
                onPressed: () => FirebaseAuth.instance.signOut(),
                child: const Text("Sign out")),
=======
                onPressed: () =>{ FirebaseAuth.instance.signOut().then((value) =>   Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                const AdminRoute()),
                      ))},
                child: const Text("Log uit")),
>>>>>>> Stashed changes:lib/Admin/CreateExam.dart
          ],
        ),
        body: Column(
          children: <Widget>[
            Expanded(
              child: ListView.builder(
                  padding: const EdgeInsets.all(8),
<<<<<<< Updated upstream:lib/Admin/MakeExam.dart
=======
                  itemCount: dbquestion.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                        height: 50,
                        margin: const EdgeInsets.all(2),
                        color: Colors.grey[400],
                        child: Row(
                          children: [
                            Center(
                                child: Text(
                              'Question: ${dbquestion[index].question}       Answer: ${dbquestion[index].answer} ',
                              style: const TextStyle(fontSize: 18),
                            )),
                            ElevatedButton.icon(
                                onPressed: deleteDBQuestion(dbquestion[index]),
                                icon: const Icon(Icons.delete),
                                label: const Text("Delete"))
                          ],
                        ));
                  }),
            ),
            Expanded(
              child: ListView.builder(
                  padding: const EdgeInsets.all(8),
>>>>>>> Stashed changes:lib/Admin/CreateExam.dart
                  itemCount: widget.list.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                      height: 50,
                      margin: const EdgeInsets.all(2),
                      color: Colors.grey[400],
                      child: Center(
                          child: Text(
<<<<<<< Updated upstream:lib/Admin/MakeExam.dart
                            'Question: ${widget.list[index][0]}               Answer: ${widget.list[index][1]} ',
                            style: const TextStyle(fontSize: 18),
                          )),
=======
                        'Question: ${widget.list[index].question}      Answer: ${widget.list[index].answer} ',
                        style: const TextStyle(fontSize: 18),
                      )),
>>>>>>> Stashed changes:lib/Admin/CreateExam.dart
                    );
                  }),
            ),
            Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                AddMultipleChoiceQuestion(list: widget.list)),
                      );
                    },
                    child: const Text('Multiple choice'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                AddOpenQuestion(list: widget.list)),
                      );
                    },
                    child: const Text('Open vraag'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                AddClosedQuestion(list: widget.list)),
                      );
                    },
                    child: const Text('Gesloten vraag'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                AddCodeCorrection(list: widget.list)),
                      );
                    },
                    child: const Text('Code correction'),
                  ),
                  const SizedBox(height: 100),
                  ElevatedButton(
                    child: const Text("Submit exam"),
                    onPressed: () {
                      for (var i = 0; i < widget.list.length; i++) {
                        AddQuestion(widget.list[i]);
                      }
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const AdminRoute()));
                    },
                  ),
                ],
              ),
            )
          ],
        ));
  }

  CollectionReference students = FirebaseFirestore.instance.collection('Exam');
  // ignore: non_constant_identifier_names
  Future<void> AddQuestion(List question) {
    if (question.isEmpty) {
      throw ("Failed to add Question");
    }
    if (question[1] == ' ' || question[1] == null) {
      return students.add({
        'Question': question[0],
      }).catchError((error) => throw ("Failed to add user: $error"));
    } else if (question[2] == null) {
      return students
          .add({'Question': question[0], 'Answer': question[1]}).catchError(
              (error) => throw ("Failed to add user: $error"));
    } else {
      return students.add({
        'Question': question[0],
        'Answer': question[1],
        'Options': question[2]
      }).catchError((error) => throw ("Failed to add user: $error"));
    }
  }
}