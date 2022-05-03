import 'package:firstapp/Student/AnswerQuestion.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MakeExam extends StatefulWidget {
  const MakeExam({Key? key, required this.exam})
      : super(key: key);

  final Exam exam;
 
  @override
  State<MakeExam> createState() => _MakeExamState();
}

class _MakeExamState extends State<MakeExam> {

  

  @override
  Widget build(BuildContext context) {
    // ignore: avoid_print
    print(widget.exam.studentAnswers);
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.red[800],
          title: Row(
            children: const [
              Text('Select Question'),
            ],
          )),
      floatingActionButton: ElevatedButton(
        child: const Text("Dien examen in"),
        onPressed: () {
addExam(widget.exam);

        },
      ),
      body: StreamBuilder<List<Question>>(
          stream: getQuestions(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return const Text('Something went wrong');
            } else if (snapshot.hasData) {
              final students = snapshot.data!;

              return ListView(
                  children: students.map((e) => buildStudent(e,widget.exam)).toList());
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          }),
    );
  }

  Widget buildStudent(Question question,Exam exam) {
    return ListTile(
       onTap: () {
             Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) =>  AnswerQuestion(question: question, exam: exam,)));
          },
        title: Text(question.question),
        subtitle: Text(question.answer + "      " + question.options));
  }

// ignore: non_constant_identifier_names
  Stream<List<Question>> getQuestions() {
    Stream<List<Question>> questions = FirebaseFirestore.instance
        .collection('questions')
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => Question.fromJson(doc.data(), doc.id))
            .toList());

    return questions;
  }
}



 CollectionReference examColl =
  FirebaseFirestore.instance.collection('exams');


  Future<void> addExam(Exam exam) {
    return examColl.add(exam.toJson()).catchError((error) => throw ("Failed to add exam: $error"));
  }

class StudentAnswer {
  String id;
  final String questionId;
  final String answer;

  StudentAnswer(
      {this.id = ' ', required this.questionId, this.answer = ' '});

  Map<String, dynamic> toJson() => {
        'id': id,
        'questionId': questionId,
        'answer': answer,
      };

  static StudentAnswer fromJson(Map<String, dynamic> json, String id) {
    return StudentAnswer(
      id: id,
      questionId: json['questionId'],
      answer: json['answer'],
    );
  }
}

class Exam {

  final String studentId;
  final List<StudentAnswer> studentAnswers;

  String id;

  Exam(
      {this.id=' ',
      required this.studentId,
      required this.studentAnswers});

  Map<String, dynamic> toJson() {
    String studentjson='';
for (var element in studentAnswers) {
studentjson+=element.toJson().toString();
};

return {
        'id': id,
        'studentId': studentId,
        'studentAnswers': studentjson,
      };
  }
  static Exam fromJson(Map<String, dynamic> json, String id) {
    return Exam(
      id: id,
      studentId: json['studentId'],
      studentAnswers: json['studentAnswers'],
    );
  }
}
