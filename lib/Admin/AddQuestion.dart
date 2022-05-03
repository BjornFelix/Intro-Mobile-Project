import 'package:flutter/material.dart';
import 'package:csv/csv.dart' as csv;
import 'CreateExam.dart';

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
                Text('Add multiple choice question'),
              ],
            )),
        body: SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(50.0, 10.0, 50.0, 10.0),
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
                            builder: (context) => CreateExam(list: nList)),
                      );
                    },
                    child: const Text(
                      "Add",
                      style: TextStyle(fontSize: 24),
                    ))
              ],
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
                Text('Add open question'),
              ],
            )),
        body: SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(50.0, 10.0, 50.0, 10.0),
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
                            builder: (context) => CreateExam(list: nList)),
                      );
                    },
                    child: const Text(
                      "Add",
                      style: TextStyle(fontSize: 24),
                    ))
              ],
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
                Text('Add multiple choice question'),
              ],
            )),
        body: SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(50.0, 10.0, 50.0, 10.0),
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
                      }
                      nList.add([
                        questionController.text.trim(),
                        answerController.text.trim(),
                        null
                      ]);

                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => CreateExam(list: nList)),
                      );
                    },
                    child: const Text(
                      "Add",
                      style: TextStyle(fontSize: 24),
                    ))
              ],
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
                Text('Add code correction question'),
              ],
            )),
        floatingActionButton: ElevatedButton(
          child: const Text("Add"),
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
              MaterialPageRoute(builder: (context) => CreateExam(list: nList)),
            );
          },
        ),
        body: Center(
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
  }
}