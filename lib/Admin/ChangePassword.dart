import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';

class ChangePasswordWidget extends StatefulWidget {
  const ChangePasswordWidget({Key? key}) : super(key: key);

  @override
  State<ChangePasswordWidget> createState() => _ChangePasswordWidgetState();
}

class _ChangePasswordWidgetState extends State<ChangePasswordWidget> {
  final passwordController = TextEditingController();
  final repeatController = TextEditingController();

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
                Text('Wachtwoord veranderen'),
              ],
            )),
        body: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
<<<<<<< Updated upstream
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 40),
                TextField(
                  controller: repeatController,
                  cursorColor: Colors.white,
                  textInputAction: TextInputAction.next,
                  decoration: const InputDecoration(labelText: "New password"),
                  obscureText: true,
                ),
                const SizedBox(height: 4),
                TextField(
                  controller: passwordController,
                  cursorColor: Colors.white,
                  textInputAction: TextInputAction.done,
                  decoration:
                  const InputDecoration(labelText: "Repeat password"),
                  obscureText: true,
                ),
                const SizedBox(height: 20),
                ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                        minimumSize: const Size.fromHeight(50)),
                    onPressed: () {
                      updatePAssword();
                    },
                    icon: const Icon(
                      Icons.lock_open,
                      size: 32,
                    ),
                    label: const Text(
                      "Update password",
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
                        return 'Voeg tekst in';
                      }
                      return null;
                    },
                    controller: passwordController,
                    cursorColor: Colors.white,
                    textInputAction: TextInputAction.done,
                    decoration:
                        const InputDecoration(labelText: "Wachtwoord herhalen"),
                    obscureText: true,
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                          minimumSize: const Size.fromHeight(50)),
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          updatePAssword()
                              .then((value) => showToast("Wachtwoord aangepast")).then((value) =>  Navigator.push(
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
>>>>>>> Stashed changes
            )));
  }

  Future updatePAssword() async {
    if (passwordController.text.trim() == repeatController.text.trim()) {
<<<<<<< Updated upstream
      await FirebaseAuth.instance.currentUser!
          .updatePassword(passwordController.text.trim());

      FirebaseAuth.instance.signOut();
=======
      try {
        await FirebaseAuth.instance.currentUser!
            .updatePassword(passwordController.text.trim());
        FirebaseAuth.instance.signOut();
      } catch (e) {
        showToast("Wachtwoord aanpassen mislukt");
      }
>>>>>>> Stashed changes
    }
  }
}