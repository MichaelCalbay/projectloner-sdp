// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, unnecessary_new, must_be_immutable

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:projectloner/models/models.dart';
import 'package:intl/intl.dart';

class RegisterPage extends StatefulWidget {
  LonerUser? user;
  final VoidCallback showLoginPage;
  RegisterPage({Key? key, required this.showLoginPage}) : super(key: key);

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
  late final _age = TextEditingController();

  // void initializer() {
  //   widget.user = new UserData(
  //       firstName: _fName.text.trim(),
  //       lastName: _lName.text.trim(),
  //       age: int.parse(_age.text.trim()),
  //       server: valueServer,
  //       role: valueRoles);
  // }

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    _conPassword.dispose();
    _fName.dispose();
    _lName.dispose();
    _mblNo.dispose();
    _age.dispose();
    super.dispose();
  }

  final items = [
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

  String? valueSex;
  String? valueServer;
  String? valueRoles;
  bool _obscurePass = true;
  bool _obscureConPass = true;

  DropdownMenuItem<String> menuItem(String items) => DropdownMenuItem(
        value: items,
        child: Text(
          items,
          style: TextStyle(fontSize: 16),
        ),
      );

  void _showDatePicker() async {
    DateTime? newDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(1972),
        lastDate: DateTime.now());

    if (newDate == null) return;

    setState(() {
      _dob.text = DateFormat('dd-MM-yyyy').format(newDate);
    });
  }

  Future addUserData(
    String fName,
    String lName,
    String mblNo,
    String? items,
    String? age,
    String bDate,
    String? server,
    String? roles,
    String email,
  ) async {
    await FirebaseFirestore.instance.collection('UserData').add({
      'First Name': fName,
      'Last Name': lName,
      'Mobile Number': mblNo,
      'Gender': items,
      'Age': age,
      'Birth Date': bDate,
      'Server': server,
      'Roles': roles,
      'Email': email,
    });
  }

  Future signUp() async {
    try {
      //Input validations
      if (_fName.text.trim() == '' ||
          _lName.text.trim() == '' ||
          _mblNo.text.trim() == '' ||
          _age.text.trim() == '' ||
          _dob.text.trim() == '' ||
          valueSex == null ||
          valueServer == null ||
          valueRoles == null) {
        Fluttertoast.showToast(
            msg: "A field can't be empty.",
            gravity: ToastGravity.BOTTOM,
            textColor: Colors.red);
      } else if (_mblNo.text.trim().length < 10) {
        Fluttertoast.showToast(
            msg: "Mobile Number is too short.",
            gravity: ToastGravity.BOTTOM,
            textColor: Colors.red);
      } else if (int.parse(_age.text.trim()) < 18) {
        Fluttertoast.showToast(
            msg: "You must be 18+",
            gravity: ToastGravity.BOTTOM,
            textColor: Colors.red);
      } else {
        if (_password.text.trim() == _conPassword.text.trim()) {
          //creates user
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
            email: _email.text.trim(),
            password: _password.text.trim(),
          );

          //add user data
          addUserData(
            _fName.text.trim(),
            _lName.text.trim(),
            _mblNo.text.trim(),
            valueSex,
            _age.text.trim(),
            _dob.text.trim(),
            valueServer,
            valueRoles,
            _email.text.trim(),
          );
        } else {
          Fluttertoast.showToast(
              msg: "Passwords don't match.",
              gravity: ToastGravity.BOTTOM,
              textColor: Colors.red);
        }
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
                          keyboardType: TextInputType.number,
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
                    //Age field===============================================
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
                          controller: _age,
                          enableSuggestions: false,
                          autocorrect: false,
                          keyboardType: TextInputType.number,
                          style: TextStyle(
                            fontSize: 16,
                          ),
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            labelText: 'Age',
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 15)
                  ],
                ),
                SizedBox(height: 10),
                //Gender & DOB fields=========================================
                Row(
                  children: [
                    //Gender field============================================
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
                          value: valueSex,
                          items: items.map(menuItem).toList(),
                          onChanged: (value) =>
                              setState(() => valueSex = value),
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
                          items: server.map(menuItem).toList(),
                          onChanged: (value) =>
                              setState(() => valueServer = value),
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
                          items: roles.map(menuItem).toList(),
                          onChanged: (value) =>
                              setState(() => valueRoles = value),
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
                //Confirm Password textfield==================================
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
                SizedBox(height: 15.0),
                //Login button=============================================
                Column(
                  children: [
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
                    ),
                    SizedBox(height: 25),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
