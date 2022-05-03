import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:csv/csv.dart' as csv;
import 'package:cloud_firestore/cloud_firestore.dart';

class SelectQuestion extends StatefulWidget {
  const SelectQuestion({Key? key}) : super(key: key);

  @override
  State<SelectQuestion> createState() => _SelectQuestionState();
}

class _SelectQuestionState extends State<SelectQuestion> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.red[800],
          title: Row(
            children: const [
              Text('Select Question'),
            ],
          )),
      body: StreamBuilder<List<Question>>(
          stream: getQuestions(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              print(snapshot.error);
              return const Text('Something went wrong');
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

  Widget buildStudent(Question question) {
    return ListTile(
        title: Text(question.question),
        subtitle: Text(question.answer + "(" + question.options + ")"));
  }

// ignore: non_constant_identifier_names
  Stream<List<Question>> getQuestions() {
    return FirebaseFirestore.instance.collection('questions').snapshots().map(
        (snapshot) => snapshot.docs
            .map((doc) => Question.fromJson(doc.data(), doc.id))
            .toList());
  }
}

class Question {
  String id;
  final String question;
  final String answer;
  final String options;
  Question(
      {required this.id,
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
