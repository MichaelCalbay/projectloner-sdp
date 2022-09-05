import 'package:flutter/material.dart';
import 'package:instabug_flutter/instabug_flutter.dart';
import 'nav_bar.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(

        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  void initState(){
    /*  BUG REPORTING SAM */
    super.initState();
    Instabug.start('204ec6dbacf517d824009b10798d3abd', [InvocationEvent.none]);
    Instabug.show();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavBar(), // nav_bar.dart - sam
      appBar: AppBar(
        title: Text("PROJECT LONER"),
      ),
      body: Center(),
    );
  }
}
