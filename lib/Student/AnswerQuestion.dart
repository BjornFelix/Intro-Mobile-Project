import 'package:firstapp/Student/MakeExam.dart';
import 'package:flutter/material.dart';


class AnswerQuestion extends StatefulWidget {
  const AnswerQuestion({Key? key, required this.exam, required this.question})
      : super(key: key);

  final Question question;
  final Exam exam;
  @override
  State<AnswerQuestion> createState() => _AnswerQuestionState();
}

class _AnswerQuestionState extends State<AnswerQuestion> {
  
  final answerController = TextEditingController();

  @override
  void dispose() {
    answerController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            backgroundColor: Colors.red[800],
            title: Row(
              children: const [
                Text('Answer Question'),
              ],
            )),
        body:checkQuestionType(answerController,widget.question,context,widget.exam) );
  }
}

checkQuestionType(TextEditingController answerController,Question question, BuildContext context,Exam examin){


     return showOpenQuestion(answerController, question, context, examin);
  

}

showOpenQuestion(TextEditingController answerController,Question question, BuildContext context,Exam examin){
   return SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(50.0, 10.0, 50.0, 10.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 40),
                Text(question.question),
                const SizedBox(height: 20),
                TextField(
                  controller: answerController,
                  cursorColor: Colors.white,
                  textInputAction: TextInputAction.done,
                  decoration: const InputDecoration(labelText: "Answer"),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        minimumSize: const Size.fromHeight(50)),
                    onPressed: () {
                     
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => MakeExam(exam: updateExam(answerController.text.trim(), examin, question),)),
                      );
                    },
                    child: const Text(
                      "Add",
                      style: TextStyle(fontSize: 24),
                    ))
              ],
            ));
}




Exam updateExam(String studentAnswer, Exam examin ,Question question ){

  Exam updatedExam = Exam(studentId: examin.studentId, studentAnswers: []);
  examin.studentAnswers.forEach((element) {updatedExam.studentAnswers.add(element);});
  StudentAnswer answerQuestion = StudentAnswer(questionId: question.id, answer: studentAnswer);

  updatedExam.studentAnswers.add(answerQuestion);
  return updatedExam;

 
}

class Question {
  String id;
  final String question;
  final String answer;
  final String options;
  Question(
      {this.id  = ' ',
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

