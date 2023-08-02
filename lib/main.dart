import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'firebase_options.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MaterialApp(
    title: 'Flutter Demo',
    theme: ThemeData(primarySwatch: Colors.blue),
    home: const HomePage(),
  ));
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      body: FutureBuilder(
        future: Firebase.initializeApp(
          options: DefaultFirebaseOptions.currentPlatform,
        ),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.done:
              final user = FirebaseAuth.instance.currentUser;

              if (user?.emailVerified ?? false) {
                //the user defined here might be null too as discueesd in the null concept so we do this ? thingy  // amd we do ?? to make emailVerified a bool value so we pass it into if
                print('U are a verified user');
              } else {
                print('Verify email first');
              }
              return const Text('Done');
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
