import 'package:firstapp/Student/MakeExam.dart';
import 'package:flutter/material.dart';
import 'package:csv/csv.dart' as csv;

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
        body: checkQuestionType(
            answerController, widget.question, context, widget.exam));
  }
}

checkQuestionType(TextEditingController answerController, Question question,
    BuildContext context, Exam examin) {
  if (question.type== 'OQ ') {
    return showOpenQuestion(answerController, question, context, examin);
  } else if (question.type== 'MC') {
    return showMultipleChoiceQuestion(
        answerController, question, context, examin);
  }else if (question.type=='CD') {
    return showCodeCorrection(answerController, question, context, examin);
  }

  return showOpenQuestion(answerController, question, context, examin);
}

showMultipleChoiceQuestion(TextEditingController answerController,
    Question question, BuildContext context, Exam examin) {
  String selectedAnswer = ' ';

  csv.CsvToListConverter c = const csv.CsvToListConverter(fieldDelimiter: ",");
  List listcreated = c.convert(question.options);

  setSelectedAnswer(String answer) {
    selectedAnswer = answer;
  }

  final _formKey = GlobalKey<FormState>();
  List<Widget> createRadioListAnswers() {
    List<Widget> widgets = [];
    for (String answer in listcreated) {
      widgets.add(
        RadioListTile(
          value: answer,
          groupValue: selectedAnswer,
          title: Text(answer),
          onChanged: (currentAnswer) {
            setSelectedAnswer(currentAnswer.toString());
          },
          selected: selectedAnswer == answer,
          activeColor: Colors.green,
        ),
      );
    }
    return widgets;
  }

// In the build method
  return Column(
    children: [
      Row(children: createRadioListAnswers()),
      Row(
        children: [
          const SizedBox(height: 20),
          ElevatedButton(
              style: ElevatedButton.styleFrom(
                  minimumSize: const Size.fromHeight(50)),
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => MakeExam(
                              exam: updateExam(answerController.text.trim(),
                                  examin, question),
                            )),
                  );
                }
              },
              child: const Text(
                "Add",
                style: TextStyle(fontSize: 24),
              ))
        ],
      )
    ],
  );
}

showOpenQuestion(TextEditingController answerController, Question question,
    BuildContext context, Exam examin) {
  final _formKey = GlobalKey<FormState>();

  return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(50.0, 10.0, 50.0, 10.0),
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 40),
            Text(question.question),
            const SizedBox(height: 20),
            TextFormField(
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter some text';
                }
                return null;
              },
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
                  if (_formKey.currentState!.validate()) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => MakeExam(
                                exam: updateExam(answerController.text.trim(),
                                    examin, question),
                              )),
                    );
                  }
                },
                child: const Text(
                  "Add",
                  style: TextStyle(fontSize: 24),
                ))
          ],
        ),
      ));
}

showClosedQuestion(TextEditingController answerController, Question question,
    BuildContext context, Exam examin) {
  final _formKey = GlobalKey<FormState>();
  return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(50.0, 10.0, 50.0, 10.0),
      child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 40),
              Text(question.question),
              const SizedBox(height: 20),
              TextFormField(
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter some text';
                  }
                  return null;
                },
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
                    if (_formKey.currentState!.validate()) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => MakeExam(
                                  exam: updateExam(answerController.text.trim(),
                                      examin, question),
                                )),
                      );
                    }
                  },
                  child: const Text(
                    "Add",
                    style: TextStyle(fontSize: 24),
                  ))
            ],
          )));
}

showCodeCorrection(TextEditingController answerController, Question question,
    BuildContext context, Exam examin) {
  final _formKey = GlobalKey<FormState>();
  final questionController = TextEditingController();
  final answerController = TextEditingController();

  late List<List<dynamic>> nList = [];

  return Center(
      child: Form(
    key: _formKey,
    child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
      const SizedBox(width: 40),
      Expanded(
        child: TextFormField(
          enabled: false,
          controller: questionController,
          cursorColor: Colors.white,
          textInputAction: TextInputAction.done,
          decoration: const InputDecoration(labelText: "Question"),
          minLines: 6,
          keyboardType: TextInputType.multiline,
          maxLines: null,
        ),
      ),
      const SizedBox(width: 20),
      Expanded(
        child: TextFormField(
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter some text';
            }
            return null;
          },
          controller: answerController,
          cursorColor: Colors.white,
          textInputAction: TextInputAction.done,
          decoration: const InputDecoration(labelText: "Answer"),
          minLines: 6,
          keyboardType: TextInputType.multiline,
          maxLines: null,
        ),
      ),
      const SizedBox(width: 20),
      ElevatedButton(
          style:
              ElevatedButton.styleFrom(minimumSize: const Size.fromHeight(50)),
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => MakeExam(
                          exam: updateExam(
                              answerController.text.trim(), examin, question),
                        )),
              );
            }
          },
          child: const Text(
            "Add",
            style: TextStyle(fontSize: 24),
          ))
    ]),
  ));
}

Exam updateExam(String studentAnswer, Exam examin, Question question) {
  Exam updatedExam = Exam(
      studentId: examin.studentId,
      studentAnswers: [],
      lat: examin.lat,
      long: examin.long);
  examin.studentAnswers.forEach((element) {
    updatedExam.studentAnswers.add(element);
  });
  StudentAnswer answerQuestion =
      StudentAnswer(questionId: question.id, answer: studentAnswer);

  updatedExam.studentAnswers.add(answerQuestion);
  return updatedExam;
}

class Question {
  String id;
  final String question;
  final String answer;
  final String options;
  final String type;
  Question(
      {this.id = ' ',
      required this.question,
      this.answer = ' ',
      this.options = ' ',
      required this.type});

  Map<String, dynamic> toJson() =>
      {'id': id, 'question': question, 'answer': answer, 'options': options,'type':type};

  static Question fromJson(Map<String, dynamic> json, String id) {
   
    if (json['answer'] == null) {
      return Question(id: id, question: json['question'],type: json['type']);
    } else if (json['options'] == null) {
      return Question(
        id: id,
        question: json['question'],
        answer: json['answer'],
        type: json['type']
      );
    }
    return Question(
        id: id,
        question: json['question'],
        answer: json['answer'],
        options: json['options'],
        type: json['type']);
  }
}
