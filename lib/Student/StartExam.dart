import 'dart:developer';

import 'package:firstapp/Student/MakeExam.dart';
import 'package:firstapp/Student/SelectQuestion.dart';
import 'package:firstapp/Student/SelectStudent.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:csv/csv.dart' as csv;
import 'package:cloud_firestore/cloud_firestore.dart';

class StartExam extends StatefulWidget {
  const StartExam({Key? key, required this.student}) : super(key: key);

  final Student student;
  @override
  State<StartExam> createState() => _StartExamState();
}

class _StartExamState extends State<StartExam> {
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            backgroundColor: Colors.red[800],
            title: Row(
              children: const [
                Text('Exam'),
              ],
            )),
        body: Center(
          child: Column(
            children: [
              Row(
                children: [
                  Text(widget.student.firstname +
                      " " +
                      widget.student.name +
                      " " +
                      widget.student.snumber)
                ],
              ),
              Row(
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => MakeExam(
                                   exam: Exam(studentId: widget.student.id, studentAnswers: []),
                                )),
                      );
                    },
                    child: const Text('Start Examen'),
                    style: ElevatedButton.styleFrom(
                        primary: Colors.red[800],
                        padding: const EdgeInsets.fromLTRB(
                            338.0, 75.0, 338.0, 75.0)),
                  ),
                ],
              )
            ],
          ),
        ));
  }
}
