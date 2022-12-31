// ignore_for_file: file_names

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import './widgets/register.dart';

class LoginUi extends StatefulWidget {
  String who;
  LoginUi({required this.who});

  @override
  _LoginUiState createState() => _LoginUiState();
}

class _LoginUiState extends State<LoginUi> {
  final GlobalKey<FormState> formkey = GlobalKey<FormState>();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: SafeArea(
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Padding(
              padding: EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Enter Your",
                    style: TextStyle(
                      fontSize: 30,
                      color: Colors.grey,
                    ),
                  ),
                  Text(
                    "Credentials",
                    style: TextStyle(
                      fontSize: 45,
                      color: Colors.red,
                    ),
                  ),
                  SizedBox(
                    height: 60,
                  ),
                  Form(
                      key: formkey,
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            Container(
                              padding: EdgeInsets.all(15),
                              width: double.infinity,
                              // height: 70,
                              decoration: BoxDecoration(
                                color: Colors.grey.withOpacity(0.2),
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: TextFormField(
                                controller: email,
                                keyboardType: TextInputType.emailAddress,
                                style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w600,
                                ),
                                validator: (msg) {
                                  if (msg!.isEmpty) {
                                    return "Please enter email";
                                  }
                                  return null;
                                },
                                decoration: InputDecoration(
                                  prefixIcon: Icon(
                                    Icons.email_rounded,
                                  ),
                                  enabledBorder: InputBorder.none,
                                  hintText: "Enter E-mail",
                                  hintStyle: TextStyle(
                                    fontSize: 20,
                                    color: Colors.grey.withOpacity(0.7),
                                    fontWeight: FontWeight.w600,
                                  ),
                                  border: InputBorder.none,
                                ),
                              ),
                            ),
                            SizedBox(height: 40),
                            Container(
                              padding: EdgeInsets.all(15),
                              width: double.infinity,
                              decoration: BoxDecoration(
                                color: Colors.grey.withOpacity(0.2),
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: TextFormField(
                                controller: password,
                                obscureText: true,
                                validator: (msg) {
                                  if (msg!.isEmpty) {
                                    return "Please enter password";
                                  }
                                  return null;
                                },
                                style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w600,
                                ),
                                decoration: InputDecoration(
                                  prefixIcon: Icon(
                                    Icons.password_rounded,
                                  ),
                                  enabledBorder: InputBorder.none,
                                  hintText: "Enter Password",
                                  hintStyle: TextStyle(
                                    fontSize: 20,
                                    color: Colors.grey.withOpacity(0.7),
                                    fontWeight: FontWeight.w600,
                                  ),
                                  border: InputBorder.none,
                                ),
                              ),
                            ),
                          ],
                        ),
                      )),
                  SizedBox(
                    height: 50,
                  ),
                  MaterialButton(
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            "Logging in!",
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                              color: Colors.black,
                            ),
                          ),
                          backgroundColor: Colors.amber,
                        ),
                      );
                      if (formkey.currentState!.validate()) {
                        widget.who == "admin"
                            ? naviagateAdmin(email.text, password.text, context)
                            : naviagateTutor(
                                email.text, password.text, context);
                      }
                    },
                    color: Colors.red,
                    elevation: 0,
                    highlightColor: Colors.amber.withOpacity(0.3),
                    highlightElevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Container(
                      padding: EdgeInsets.all(20),
                      width: double.infinity,
                      child: Center(
                        child: Text(
                          "Login",
                          style: TextStyle(
                            fontSize: 30,
                            color: Colors.white,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
