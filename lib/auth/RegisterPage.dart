// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';

class RegisterPage extends StatefulWidget {
  final VoidCallback showLoginPage;
  const RegisterPage({Key? key, required this.showLoginPage}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  //Text controller
  late final _fName = TextEditingController();
  late final _lName = TextEditingController();
  late final _email = TextEditingController();
  late final _password = TextEditingController();
  late final _conPassword = TextEditingController();
  late final _mblNo = TextEditingController();
  late final _dob = TextEditingController();

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    _conPassword.dispose();
    _fName.dispose();
    _lName.dispose();
    _mblNo.dispose();
    super.dispose();
  }

  final age = [
    '18',
    '19',
    '20',
    '21',
    '22',
    '23',
    '24',
    '25',
    '26',
    '27',
    '28',
    '29',
    '30',
  ];

  final sex = [
    'Male',
    'Female',
    'Non-Binary',
    'Transgender',
  ];

  final server = [
    'APAC',
    'EU',
    'NA',
    'LATAM',
  ];

  final roles = [
    'Duelist',
    'Controller',
    'Support',
    'Initiator',
  ];

  String? valueAge;
  String? valueSex;
  String? valueServer;
  String? valueRoles;
  bool _obscurePass = true;
  bool _obscureConPass = true;

  DropdownMenuItem<String> ageMenuItem(String age) => DropdownMenuItem(
        value: age,
        child: Text(
          age,
          style: TextStyle(fontSize: 16),
        ),
      );

  DropdownMenuItem<String> sexMenuItem(String sex) => DropdownMenuItem(
        value: sex,
        child: Text(
          sex,
          style: TextStyle(fontSize: 16),
        ),
      );

  DropdownMenuItem<String> serverMenuItem(String server) => DropdownMenuItem(
        value: server,
        child: Text(
          server,
          style: TextStyle(fontSize: 16),
        ),
      );

  DropdownMenuItem<String> rolesMenuItem(String roles) => DropdownMenuItem(
        value: roles,
        child: Text(
          roles,
          style: TextStyle(fontSize: 16),
        ),
      );

  void _showDatePicker() async {
    DateTime? newDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(1970),
        lastDate: DateTime.now());

    if (newDate == null) return;

    setState(() {
      _dob.text = DateFormat('dd-MM-yyyy').format(newDate);
    });
  }

  Future signUp() async {
    try {
      if (_password.text.trim() == _conPassword.text.trim()) {
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: _email.text.trim(),
          password: _password.text.trim(),
        );
      } else {
        Fluttertoast.showToast(
            msg: "Passwords don't match.",
            gravity: ToastGravity.BOTTOM,
            textColor: Colors.red);
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        Fluttertoast.showToast(
            msg: "Password is weak.",
            gravity: ToastGravity.BOTTOM,
            textColor: Colors.red);
      } else if (e.code == 'email-already-in-use') {
        Fluttertoast.showToast(
            msg: "Email already exists.",
            gravity: ToastGravity.BOTTOM,
            textColor: Colors.red);
      } else if (e.code == 'invalid-email') {
        Fluttertoast.showToast(
            msg: "Invalid email.",
            gravity: ToastGravity.BOTTOM,
            textColor: Colors.red);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[300],
        body: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.gamepad_rounded,
                    size: 100,
                  ),
                  SizedBox(height: 50),
                  //Greetings===================================================
                  Text(
                    'Hello There!',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 40,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Ready to be a Loner? Register below!',
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                  SizedBox(height: 50),
                  //Firstname/LastName textfield================================
                  Row(
                    children: [
                      //First name textfield====================================
                      SizedBox(width: 15),
                      Flexible(
                          child: Container(
                        height: 56,
                        padding: EdgeInsets.only(left: 20.0),
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          border: Border.all(color: Colors.white),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: TextField(
                          controller: _fName,
                          enableSuggestions: false,
                          autocorrect: false,
                          style: TextStyle(
                            fontSize: 16,
                          ),
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            labelText: 'First Name',
                          ),
                        ),
                      )),
                      //Last name textfield====================================
                      SizedBox(width: 5),
                      Flexible(
                          child: Container(
                        height: 56,
                        padding: EdgeInsets.only(left: 20.0),
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          border: Border.all(color: Colors.white),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: TextField(
                          controller: _lName,
                          enableSuggestions: false,
                          autocorrect: false,
                          style: TextStyle(
                            fontSize: 16,
                          ),
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            labelText: 'Last Name',
                          ),
                        ),
                      )),
                      SizedBox(width: 15)
                    ],
                  ),
                  SizedBox(height: 10),
                  //Gender & Number fields======================================
                  Row(
                    children: [
                      //Mobile Number field=====================================
                      SizedBox(width: 15),
                      Flexible(
                        child: Container(
                          height: 56,
                          padding: EdgeInsets.only(left: 20.0),
                          decoration: BoxDecoration(
                            color: Colors.grey[200],
                            border: Border.all(color: Colors.white),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: TextField(
                            controller: _mblNo,
                            enableSuggestions: false,
                            autocorrect: false,
                            style: TextStyle(
                              fontSize: 16,
                            ),
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              labelText: 'Mobile Number',
                              icon: Icon(
                                Icons.phone,
                                color: Colors.deepPurple,
                              ),
                            ),
                          ),
                        ),
                      ),
                      //Gender field============================================
                      SizedBox(width: 5),
                      Flexible(
                        child: Container(
                          height: 56,
                          padding: EdgeInsets.only(left: 20.0),
                          decoration: BoxDecoration(
                            color: Colors.grey[200],
                            border: Border.all(color: Colors.white),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: DropdownButtonFormField<String>(
                            value: valueSex,
                            items: sex.map(sexMenuItem).toList(),
                            onChanged: (value) =>
                                setState(() => this.valueSex = value),
                            icon: const Icon(
                              Icons.arrow_drop_down_circle,
                              color: Colors.deepPurple,
                            ),
                            decoration: InputDecoration(
                              labelText: 'Gender',
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 15)
                    ],
                  ),
                  SizedBox(height: 10),
                  //Age & DOB fields============================================
                  Row(
                    children: [
                      //Age field===============================================
                      SizedBox(width: 15),
                      Flexible(
                        child: Container(
                          height: 56,
                          padding: EdgeInsets.only(left: 20.0),
                          decoration: BoxDecoration(
                            color: Colors.grey[200],
                            border: Border.all(color: Colors.white),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: DropdownButtonFormField<String>(
                            value: valueAge,
                            items: age.map(ageMenuItem).toList(),
                            onChanged: (value) =>
                                setState(() => this.valueAge = value),
                            icon: const Icon(
                              Icons.arrow_drop_down_circle,
                              color: Colors.deepPurple,
                            ),
                            decoration: InputDecoration(
                              labelText: 'Age',
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                      ),
                      //DOB field===============================================
                      SizedBox(width: 5),
                      Flexible(
                        child: Container(
                          height: 56,
                          padding: EdgeInsets.only(left: 15.0),
                          decoration: BoxDecoration(
                            color: Colors.grey[200],
                            border: Border.all(color: Colors.white),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: TextField(
                            controller: _dob,
                            decoration: InputDecoration(
                              icon: Icon(
                                Icons.calendar_today_rounded,
                                color: Colors.deepPurple,
                              ),
                              border: InputBorder.none,
                              labelText: 'Birth Date',
                            ),
                            onTap: _showDatePicker,
                          ),
                        ),
                      ),
                      SizedBox(width: 15),
                    ],
                  ),
                  SizedBox(height: 10),
                  //Server & Roles fields=======================================
                  Row(
                    children: [
                      //Server field============================================
                      SizedBox(width: 15),
                      Flexible(
                        child: Container(
                          height: 56,
                          padding: EdgeInsets.only(left: 20.0),
                          decoration: BoxDecoration(
                            color: Colors.grey[200],
                            border: Border.all(color: Colors.white),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: DropdownButtonFormField<String>(
                            value: valueServer,
                            items: server.map(ageMenuItem).toList(),
                            onChanged: (value) =>
                                setState(() => this.valueServer = value),
                            icon: const Icon(
                              Icons.arrow_drop_down_circle,
                              color: Colors.deepPurple,
                            ),
                            decoration: InputDecoration(
                              labelText: 'Server',
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                      ),
                      //Roles field=============================================
                      SizedBox(width: 5),
                      Flexible(
                        child: Container(
                          height: 56,
                          padding: EdgeInsets.only(left: 20.0),
                          decoration: BoxDecoration(
                            color: Colors.grey[200],
                            border: Border.all(color: Colors.white),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: DropdownButtonFormField<String>(
                            value: valueRoles,
                            items: roles.map(sexMenuItem).toList(),
                            onChanged: (value) =>
                                setState(() => this.valueRoles = value),
                            icon: const Icon(
                              Icons.arrow_drop_down_circle,
                              color: Colors.deepPurple,
                            ),
                            decoration: InputDecoration(
                              labelText: 'Roles',
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 15)
                    ],
                  ),
                  SizedBox(height: 10),
                  //Email textfield=============================================
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15.0),
                    child: Container(
                      height: 56,
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        border: Border.all(color: Colors.white),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 20.0),
                        child: TextField(
                          controller: _email,
                          enableSuggestions: false,
                          autocorrect: false,
                          style: TextStyle(
                            fontSize: 16,
                          ),
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            labelText: 'E-mail',
                            icon: Icon(
                              Icons.email_rounded,
                              color: Colors.deepPurple,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  //Password textfield==========================================
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15.0),
                    child: Container(
                      height: 56,
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        border: Border.all(color: Colors.white),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 20.0),
                        child: TextField(
                            controller: _password,
                            obscureText: _obscurePass,
                            enableSuggestions: false,
                            autocorrect: false,
                            style: TextStyle(
                              fontSize: 16,
                            ),
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              labelText: 'Password',
                              suffixIcon: IconButton(
                                onPressed: () => setState(
                                  (() => _obscurePass = !_obscurePass),
                                ),
                                icon: Icon(
                                    _obscurePass
                                        ? Icons.visibility
                                        : Icons.visibility_off,
                                    color: Colors.deepPurple),
                              ),
                            )),
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  //Confirm Password textfield==========================================
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15.0),
                    child: Container(
                      height: 56,
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        border: Border.all(color: Colors.white),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 20.0),
                        child: TextField(
                          controller: _conPassword,
                          obscureText: _obscureConPass,
                          enableSuggestions: false,
                          autocorrect: false,
                          style: TextStyle(
                            fontSize: 16,
                          ),
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            labelText: 'Confirm Password',
                            suffixIcon: IconButton(
                              onPressed: () => setState(
                                (() => _obscureConPass = !_obscureConPass),
                              ),
                              icon: Icon(
                                  _obscureConPass
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                  color: Colors.deepPurple),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  //Register button=============================================
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15.0),
                    child: GestureDetector(
                      onTap: signUp,
                      child: Container(
                        padding: EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: Colors.deepPurple,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Center(
                          child: Text(
                            'Register',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 25),
                  //Login button=============================================
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Already a loner? ',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      GestureDetector(
                        onTap: widget.showLoginPage,
                        child: Text(
                          'Log in',
                          style: TextStyle(
                            color: Colors.blue,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ));
  }
}
