import 'dart:developer';

import 'package:firstapp/Student/MakeExam.dart';
import 'package:firstapp/Student/SelectStudent.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:csv/csv.dart' as csv;
import 'package:cloud_firestore/cloud_firestore.dart';

import '../Student/AnswerQuestion.dart';

class CorrectExam extends StatefulWidget {
  const CorrectExam({Key? key, required this.student}) : super(key: key);

  final Student student;
  @override
  State<CorrectExam> createState() => _CorrectExamState();
}

class _CorrectExamState extends State<CorrectExam> {
int score=0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.red[800],
          title: Row(
            children: const [
              Text('Select Student'),
            ],
          )),
      body: StreamBuilder<List<Exam>>(
          stream: getExam(widget.student),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return const Text('Something went wrong');
            } else if (snapshot.hasData) {
              final exam = snapshot.data!;
final answers = exam[0].studentAnswers;
              return ListView(
                  children: answers.map((e) => buildExam(e)).toList());
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          }),
    );
  }

  Widget buildExam(StudentAnswer answer) {
    int points= answer.question.points;

if (answer.question.type=='CQ'||answer.question.type=='CC' ||answer.question.type=='MC') {
    if (answer.answer.toUpperCase()==answer.question.answer) {
      score+=points;
        return ListTile(
      
        title: Text(answer.question.question),
        subtitle: Text(answer.answer+ points.toString()+"/"+points.toString())
        );
    }
    else{
    return ListTile(
      
        title: Text(answer.question.question),
        subtitle: Text(answer.answer + "0/"+ answer.question.points.toString())
        );

    }
  }
 return ListTile(
      
      onTap: (){},
        title: Text(answer.question.question),
        subtitle: Text(answer.answer)
        );
  }




  Stream<List<Exam>> getExam(Student student) {
    print(student.id);
    Stream<List<Exam>> exam= FirebaseFirestore.instance
        .collection("exams")
        .where("studentId", isEqualTo: student.id)
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => Exam.fromJson(doc.data(), doc.id))
            .toList());

print(exam.toString());
          return exam;
  }

}
