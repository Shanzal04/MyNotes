import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import '../firebase_options.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  late final TextEditingController _email;
  late final TextEditingController _password;

  @override
  void initState() {
    _email = TextEditingController();
    _password = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Register'),
      ),
      body: FutureBuilder(
        future: Firebase.initializeApp(
          options: DefaultFirebaseOptions.currentPlatform,
        ),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.done:
              return Column(
                children: [
                  TextField(
                      controller: _email,
                      decoration:
                          InputDecoration(hintText: 'Enter your email')),
                  TextField(
                    controller: _password,
                    decoration:
                        InputDecoration(hintText: 'Enter your password'),
                    obscureText: true, //hides the password
                    enableSuggestions:
                        false, //suggestions which u get in keyborad
                    autocorrect: false, //password me no autocorrect bc
                    keyboardType: TextInputType.emailAddress,
                  ),
                  TextButton(
                    onPressed: () async {
                      final email = _email.text;
                      final password = _password.text;
                      try {
                        final UserCredential = await FirebaseAuth.instance
                            .createUserWithEmailAndPassword(
                                email: email, password: password);
                        print(UserCredential);
                      } on FirebaseAuthException catch (e) {
                        print(e.code);
                        if (e.code == ('weak-password')) {
                          print('Weak-Password');
                        } else if ((e.code) == ('email-already-in-use')) {
                          print('Emial areadt use');
                        } else if (e.code == 'invalid-email') {
                          print('invalid emil');
                        }
                      }
                    },
                    child: const Text('Register'),
                  ),
                ],
              );
            default:
              return const Text(
                  'loading...'); //happening too fast so if the connection
            //is slow then after the future has finished working this rerturn will activate and loading will be shown.
          }
        },
      ),
    );
  }
}
