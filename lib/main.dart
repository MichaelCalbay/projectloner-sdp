import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:projectloner/firebase_options.dart';
import 'package:projectloner/views/HomePage.dart';
import 'package:projectloner/views/LoginView.dart';
import 'package:projectloner/views/RegisterView.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MainPage(),
      routes: {
        '/login/': (context) => const LoginView(),
        '/register/': (context) => const RegisterView(),
        '/home/': (context) => const HomePage(),
      },
    ),
  );
}

class MainPage extends StatelessWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
      ),
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.done:
            return const LoginView();
          default:
            return const Text('Loading..');
        }
      },
    );
  }
}
