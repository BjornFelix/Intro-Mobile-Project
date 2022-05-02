import 'dart:developer';

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
  String dropdownValue = 'One';

  CollectionReference students =
      FirebaseFirestore.instance.collection('students');

  @override
  Widget build(BuildContext context) {
  
  
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.red[800],
          title: Row(
            children: const [
              Text('Student Login'),
            ],
          )),
      body:  StreamBuilder<List<Student>>(stream: getStudents(),
      builder: (context,snapshot){
        if(snapshot.hasError){
          return const Text('Something went wrong');
        }
       else if (snapshot.hasData) {
         
          final students = snapshot.data!;
          print(students);
          return ListView(children: students.map((e) => buildStudent(e)).toList());

        }
        else{
          return const Center(child: CircularProgressIndicator(),);
        }
      } 
      ),
    );
  }

Widget buildStudent(Student student){
  print("hier");
  print(student);
 return ListTile(title: Text(student.name + student.firstname),
  subtitle: Text(student.snumber));
}
// ignore: non_constant_identifier_names
  Stream<List<Student>> getStudents() {

   return FirebaseFirestore.instance.collection('students').snapshots().map((snapshot) => snapshot.docs.map((doc) => Student.fromJson(doc.data())).toList());
 }
 
}

class Student{
  String id;
  final String name;
  final String firstname;
  final String snumber;
  Student({this.id=' ',required this.name,required this.firstname, required this.snumber});

  Map<String,dynamic> toJson()=>{'id':id,'name':name,'firstname':firstname,'snumber':snumber};

  static Student fromJson(Map<String,dynamic>json)=>Student( id:json['id'],name: json['name'], firstname: json['firstname'],snumber: json['snumber']);


}