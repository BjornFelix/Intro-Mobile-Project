import 'package:flutter/material.dart';
import 'package:csv/csv.dart' as csv;
import 'MakeExam.dart';

class AddMultipleChoiceQuestion extends StatefulWidget {
  const AddMultipleChoiceQuestion({Key? key, required this.list})
      : super(key: key);

  final List<List> list;
  @override
  State<AddMultipleChoiceQuestion> createState() =>
      _AddMultipleChoiceQuestionState();
}

class _AddMultipleChoiceQuestionState extends State<AddMultipleChoiceQuestion> {
  final questionController = TextEditingController();
  final optionsController = TextEditingController();
  final answerController = TextEditingController();

  late List<List<dynamic>> nList = [];

  @override
  void dispose() {
    questionController.dispose();
    optionsController.dispose();
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
                Text('Voeg een multiple choice vraag toe'),
              ],
            )),
        body: SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(50.0, 10.0, 50.0, 10.0),
<<<<<<< Updated upstream
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 40),
                TextField(
                    controller: questionController,
                    cursorColor: Colors.white,
                    textInputAction: TextInputAction.next,
                    decoration: const InputDecoration(labelText: "Question")),
                const SizedBox(height: 4),
                TextField(
                  controller: optionsController,
                  cursorColor: Colors.white,
                  textInputAction: TextInputAction.done,
                  decoration: const InputDecoration(labelText: "Options"),
                ),
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
                      for (var element in widget.list) {
                        nList.add(element);
                      }
                      nList.add([
                        questionController.text.trim(),
                        answerController.text.trim(),
                        csvToList(optionsController.text.trim())
                      ]);

                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => MakeExam(list: nList)),
                      );
                    },
                    child: const Text(
                      "Add",
                      style: TextStyle(fontSize: 24),
                    ))
              ],
=======
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 40),
                  TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Voeg tekst in';
                        }
                        return null;
                      },
                      controller: questionController,
                      cursorColor: Colors.white,
                      textInputAction: TextInputAction.next,
                      decoration: const InputDecoration(labelText: "Vraag")),
                  const SizedBox(height: 4),
                  TextFormField(
                    controller: optionsController,
                    cursorColor: Colors.white,
                    textInputAction: TextInputAction.done,
                    decoration: const InputDecoration(labelText: "Opties"),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Voeg tekst in';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Voeg tekst in';
                      }
                      return null;
                    },
                    controller: answerController,
                    cursorColor: Colors.white,
                    textInputAction: TextInputAction.done,
                    decoration: const InputDecoration(labelText: "Antwoord"),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          minimumSize: const Size.fromHeight(50)),
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          for (var element in widget.list) {
                            nList.add(element);
                          }

                          Question question = Question(
                              question: questionController.text.trim(),
                              answer: answerController.text.trim(),
                              options: optionsController.text.trim(), type: 'MC');

                          nList.add(question);

                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => CreateExam(list: nList)),
                          );
                        }
                      },
                      child: const Text(
                        "Toevoegen",
                        style: TextStyle(fontSize: 24),
                      ))
                ],
              ),
>>>>>>> Stashed changes
            )));
  }

  List<List> csvToList(String string) {
    csv.CsvToListConverter c =
    const csv.CsvToListConverter(fieldDelimiter: ",");
    List<List> listcreated = c.convert(string);
    return listcreated;
  }
}

class AddOpenQuestion extends StatefulWidget {
  const AddOpenQuestion({Key? key, required this.list}) : super(key: key);

  final List<List> list;
  @override
  State<AddOpenQuestion> createState() => _AddOpenQuestionState();
}

class _AddOpenQuestionState extends State<AddOpenQuestion> {
  final questionController = TextEditingController();
  final optionsController = TextEditingController();
  final answerController = TextEditingController();

  late List<List<dynamic>> nList = [];

  @override
  void dispose() {
    questionController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            backgroundColor: Colors.red[800],
            title: Row(
              children: const [
                Text('Voeg een open vraag toe'),
              ],
            )),
        body: SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(50.0, 10.0, 50.0, 10.0),
<<<<<<< Updated upstream
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 60),
                TextField(
                    controller: questionController,
                    cursorColor: Colors.white,
                    textInputAction: TextInputAction.next,
                    decoration: const InputDecoration(labelText: "Question")),
                const SizedBox(height: 20),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        minimumSize: const Size.fromHeight(50)),
                    onPressed: () {
                      for (var element in widget.list) {
                        nList.add(element);
                      }
                      nList.add([questionController.text.trim(), null, null]);

                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => MakeExam(list: nList)),
                      );
                    },
                    child: const Text(
                      "Add",
                      style: TextStyle(fontSize: 24),
                    ))
              ],
=======
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 60),
                  TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Voeg tekst in';
                        }
                        return null;
                      },
                      controller: questionController,
                      cursorColor: Colors.white,
                      textInputAction: TextInputAction.next,
                      decoration: const InputDecoration(labelText: "Vraag")),
                  const SizedBox(height: 20),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          minimumSize: const Size.fromHeight(50)),
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          for (var element in widget.list) {
                            nList.add(element);
                          }
                          nList.add(Question(
                              question: questionController.text.trim(), type: 'OQ'));

                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => CreateExam(list: nList)),
                          );
                        }
                      },
                      child: const Text(
                        "Toevoegen",
                        style: TextStyle(fontSize: 24),
                      ))
                ],
              ),
>>>>>>> Stashed changes
            )));
  }
}

class AddClosedQuestion extends StatefulWidget {
  const AddClosedQuestion({Key? key, required this.list}) : super(key: key);

  final List<List> list;
  @override
  State<AddClosedQuestion> createState() => _AddClosedQuestionState();
}

class _AddClosedQuestionState extends State<AddClosedQuestion> {
  final questionController = TextEditingController();
  final answerController = TextEditingController();

  late List<List<dynamic>> nList = [];

  @override
  void dispose() {
    questionController.dispose();

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
                Text('Voeg gesloten vraag toe'),
              ],
            )),
        body: SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(50.0, 10.0, 50.0, 10.0),
<<<<<<< Updated upstream
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 40),
                TextField(
                    controller: questionController,
                    cursorColor: Colors.white,
                    textInputAction: TextInputAction.next,
                    decoration: const InputDecoration(labelText: "Question")),
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
                      for (var element in widget.list) {
                        nList.add(element);
=======
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 40),
                  TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Voeg tekst in';
                        }
                        return null;
                      },
                      controller: questionController,
                      cursorColor: Colors.white,
                      textInputAction: TextInputAction.next,
                      decoration: const InputDecoration(labelText: "Vraag")),
                  const SizedBox(height: 20),
                  TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Voeg tekst in';
>>>>>>> Stashed changes
                      }
                      nList.add([
                        questionController.text.trim(),
                        answerController.text.trim(),
                        null
                      ]);

                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => MakeExam(list: nList)),
                      );
                    },
<<<<<<< Updated upstream
                    child: const Text(
                      "Add",
                      style: TextStyle(fontSize: 24),
                    ))
              ],
=======
                    controller: answerController,
                    cursorColor: Colors.white,
                    textInputAction: TextInputAction.done,
                    decoration: const InputDecoration(labelText: "Antwoord"),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          minimumSize: const Size.fromHeight(50)),
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          for (var element in widget.list) {
                            nList.add(element);
                          }
                          nList.add(Question(
                              question: questionController.text.trim(),
                              answer: answerController.text.trim(), type: 'CQ'));

                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => CreateExam(list: nList)),
                          );
                        }
                      },
                      child: const Text(
                        "Toevoegen",
                        style: TextStyle(fontSize: 24),
                      ))
                ],
              ),
>>>>>>> Stashed changes
            )));
  }
}

class AddCodeCorrection extends StatefulWidget {
  const AddCodeCorrection({Key? key, required this.list}) : super(key: key);

  final List<List> list;
  @override
  State<AddCodeCorrection> createState() => _AddCodeCorrectionState();
}

class _AddCodeCorrectionState extends State<AddCodeCorrection> {
  final questionController = TextEditingController();
  final answerController = TextEditingController();

  late List<List<dynamic>> nList = [];

  @override
  void dispose() {
    questionController.dispose();

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
                Text('Voeg code correctie vraag toe'),
              ],
            )),
        floatingActionButton: ElevatedButton(
          child: const Text("Toevoegen"),
          onPressed: () {
            for (var element in widget.list) {
              nList.add(element);
            }
            nList.add([
              questionController.text.trim(),
              answerController.text.trim(),
              null
            ]);

            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => MakeExam(list: nList)),
            );
          },
        ),
        body: Center(
<<<<<<< Updated upstream
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  const SizedBox(width: 40),
                  Expanded(
                    child: TextField(
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
                    child: TextField(
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
                ])));
=======
            child: Form(
          key: _formKey,
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
            const SizedBox(width: 40),
            Expanded(
              child: TextFormField(
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Voeg tekst in';
                  }
                  return null;
                },
                controller: questionController,
                cursorColor: Colors.white,
                textInputAction: TextInputAction.done,
                decoration: const InputDecoration(labelText: "Vraag"),
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
                    return 'Voeg tekst in';
                  }
                  return null;
                },
                controller: answerController,
                cursorColor: Colors.white,
                textInputAction: TextInputAction.done,
                decoration: const InputDecoration(labelText: "Antwoord"),
                minLines: 6,
                keyboardType: TextInputType.multiline,
                maxLines: null,
              ),
            ),
            const SizedBox(width: 20),
          ]),
        )));
>>>>>>> Stashed changes
  }
}