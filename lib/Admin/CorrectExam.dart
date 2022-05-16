import 'dart:developer';

import 'package:firstapp/Student/MakeExam.dart';
import 'package:firstapp/Student/SelectStudent.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:csv/csv.dart' as csv;
import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../Student/AnswerQuestion.dart';

class CorrectExam extends StatefulWidget {
  const CorrectExam({Key? key, required this.student}) : super(key: key);

  final Student student;
  @override
  State<CorrectExam> createState() => _CorrectExamState();
}

class _CorrectExamState extends State<CorrectExam> {
  int score = 0;

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
      body: FutureBuilder<List<Exam>>(
          future: getExam(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              debugPrint(snapshot.error.toString());
              return const Text('Een fout heeft zich plaatsgevonden');
            } else if (snapshot.hasData) {
              final exam = snapshot.data!;
              final answers = exam[0].studentAnswers;
              return ListView(
                  children: answers.map((e) => buildExam(e.toJson())).toList());
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          }),
    );
  }

  Widget buildExam(Map<String, dynamic> answer) {
    StudentAnswer ans = StudentAnswer.fromJson(answer, '');
    int points = ans.question.points;

    if (ans.question.type == 'CQ' ||
        ans.question.type == 'CC' ||
        ans.question.type == 'MC') {
      if (ans.answer.toUpperCase() == ans.question.answer) {
        score += points;
        return ListTile(
            title: Text(ans.question.question),
            subtitle:
                Text(ans.answer + points.toString() + "/" + points.toString()));
      } else {
        return ListTile(
            title: Text(ans.question.question),
            subtitle: Text(ans.answer + "0/" + ans.question.points.toString()));
      }
    }
    return ListTile(
        onTap: () {},
        title: Text(ans.question.question),
        subtitle: Text(ans.answer));
  }

  Future<List<Exam>> getExam() async {
    var collection = FirebaseFirestore.instance.collection('exams');
    var querySnapshot = await collection.get();
    List<Exam> result = [];
    for (var queryDocumentSnapshot in querySnapshot.docs) {
      print(queryDocumentSnapshot.data());
      Map<String, dynamic> data = queryDocumentSnapshot.data();

      data["studentId"] = queryDocumentSnapshot.id;
print(queryDocumentSnapshot.data());
      result.add(Exam.fromJson(data, queryDocumentSnapshot.id));
    }

    return result;
  }
}
