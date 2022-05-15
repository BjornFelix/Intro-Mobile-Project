import 'dart:developer';

import 'package:firstapp/Admin/CorrectExam.dart';
import 'package:firstapp/Student/SelectStudent.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:csv/csv.dart' as csv;
import 'package:cloud_firestore/cloud_firestore.dart';

class SelectStudent extends StatefulWidget {
  const SelectStudent({Key? key}) : super(key: key);

  @override
  State<SelectStudent> createState() => _SelectStudentState();
}

class _SelectStudentState extends State<SelectStudent> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.red[800],
          title: Row(
            children: const [
              Text('Selecteer student'),
            ],
          )),
      body: StreamBuilder<List<Student>>(
          stream: getStudents(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return const Text('Een fout heeft zich plaatsgevonden');
            } else if (snapshot.hasData) {
              final students = snapshot.data!;

              return ListView(
                  children: students.map((e) => buildStudent(e)).toList());
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          }),
    );
  }

  Widget buildStudent(Student student) {
    return ListTile(
         onTap: () {
             Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => CorrectExam(student:student ,)));
          },
        title: Text(student.name + student.firstname),
        subtitle: Text(student.snumber));
  }

// ignore: non_constant_identifier_names
  Stream<List<Student>> getStudents() {
    return FirebaseFirestore.instance.collection('students').snapshots().map(
        (snapshot) => snapshot.docs
            .map((doc) => Student.fromJson(doc.data(), doc.id))
            .toList());
  }
}

class Question {
  String id;
  final String question;
  final String answer;
  final String options;
  Question(
      { this.id = ' ',
      required this.question,
      this.answer = ' ',
      this.options = ' '});

  Map<String, dynamic> toJson() =>
      {'id': id, 'question': question, 'answer': answer, 'options': options};

  static Question fromJson(Map<String, dynamic> json, String id) {
    if (json['answer'] == null) {
      return Question(id: id, question: json['question']);
    } else if (json['options'] == null) {
      return Question(
        id: id,
        question: json['question'],
        answer: json['answer'],
      );
    }
    return Question(
        id: id,
        question: json['question'],
        answer: json['answer'],
        options: json['options']);
   }
}
