import 'package:firstapp/HomePage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ChangePasswordWidget extends StatefulWidget {
  const ChangePasswordWidget({Key? key}) : super(key: key);

  @override
  State<ChangePasswordWidget> createState() => _ChangePasswordWidgetState();
}

class _ChangePasswordWidgetState extends State<ChangePasswordWidget> {
  final passwordController = TextEditingController();
  final repeatController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  @override
  void dispose() {
    repeatController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            backgroundColor: Colors.red[800],
            title: Row(
              children: const [
                Text('Wachtwoord wijzigen'),
              ],
            )),
        body: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 40),
                  TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Vul tekst in';
                      }
                      return null;
                    },
                    controller: repeatController,
                    cursorColor: Colors.white,
                    textInputAction: TextInputAction.next,
                    decoration:
                        const InputDecoration(labelText: "Nieuw wachtwoord"),
                    obscureText: true,
                  ),
                  const SizedBox(height: 4),
                  TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Vul tekst in';
                      }
                      return null;
                    },
                    controller: passwordController,
                    cursorColor: Colors.white,
                    textInputAction: TextInputAction.done,
                    decoration:
                        const InputDecoration(labelText: "Herhaal wachtwoord"),
                    obscureText: true,
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                          minimumSize: const Size.fromHeight(50)),
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          updatePAssword()
                              .then((value) => showToast("Aangepaste wachtwoord")).then((value) =>  Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const MyHomePage(title: 'Home',)),
                    ));
                        }
                      },
                      icon: const Icon(
                        Icons.lock_open,
                        size: 32,
                      ),
                      label: const Text(
                        "Wachtwoord aanpassen",
                        style: TextStyle(fontSize: 24),
                      ))
                ],
              ),
            )));
  }

  void showToast(String message) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0);
  }

  Future updatePAssword() async {
    if (passwordController.text.trim() == repeatController.text.trim()) {
      try {
        await FirebaseAuth.instance.currentUser!
            .updatePassword(passwordController.text.trim());
        FirebaseAuth.instance.signOut();
      } catch (e) {
        showToast("Wachtwoord aanpassen mislukt");
      }
    }
  }
}
