import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:full_project/helper/helperfunctions.dart';
import 'package:full_project/screens/main_screen.dart';
import 'package:full_project/screens/nav_screens/home_screen.dart';
import 'package:full_project/services/auth.dart';
import 'package:full_project/services/database.dart';
import 'package:full_project/widgets/widget.dart';

class SignUpScreen extends StatefulWidget {
  final Function toggle;
  SignUpScreen(this.toggle);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  bool isLoading = false;
  String? errorMessage = '';

  Auth auth = Auth();
  DatabaseMethods databaseMethods = DatabaseMethods();
  GlobalKey<FormState> key = GlobalKey<FormState>();

  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  // signMeUp() {
  //   if (key.currentState!.validate()) {
  //     Map<String, dynamic> userInfoMap = {
  //       'email': emailController,
  //       'name': nameController
  //     };
  //
  //     HelperFunctions.saveUserEmailSharedPreference(emailController.text);
  //     HelperFunctions.saveUserNameSharedPreference(nameController.text);
  //
  //     setState(() {
  //       isLoading = true;
  //     });
  //
  //     auth
  //         .createUserWithEmailAndPassword(
  //             email: emailController.text, password: passwordController.text)
  //         .then((val) {
  //       databaseMethods.uploadUserInfo(userInfoMap);
  //       HelperFunctions.saveUserLoggedInSharedPreference(true);
  //       Navigator.pushReplacement(
  //           context, MaterialPageRoute(builder: (context) => HomeScreen()));
  //     });
  //   }
  // }

  Future<void> createUserWithEmailAndPassword() async {
    try {
      await Auth().createUserWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );
    } on FirebaseAuthException catch (e) {
      setState(() {
        errorMessage = e.message;
      });
    }
  }

  signUp() {
    if (key.currentState!.validate()) {
      Map<String, dynamic> userInfoMap = {
        'name': nameController.text,
        'email': emailController.text
      };

      HelperFunctions.saveUserEmailSharedPreference(emailController.text);
      HelperFunctions.saveUserNameSharedPreference(nameController.text);

      setState(() {
        isLoading = true;
      });

      auth
          .createUserWithEmailAndPassword(
              email: emailController.text, password: passwordController.text)
          .then((val) {
        databaseMethods.uploadUserInfo(userInfoMap);
        HelperFunctions.saveUserLoggedInSharedPreference(true);
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => MainScreen()));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff170048),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 100),
          child: Form(
            key: key,
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Sign Up',
                    style: customTextTitle(),
                  ),
                  SizedBox(
                    height: 80,
                  ),
                  TextFormField(
                    validator: (val) {
                      if (val == null || val.isEmpty) {
                        return 'Enter your email';
                      } else if (val.length < 4) {
                        return 'at least enter 4 characters';
                      } else if (val.length > 13) {
                        return 'maximum character is 13';
                      }
                      return null;
                    },
                    controller: nameController,
                    style: customText(),
                    decoration: customTextField('Username'),
                  ),
                  SizedBox(height: 20),
                  TextFormField(
                    validator: (val) {
                      if (val == null || val.isEmpty) {
                        return 'Enter your email';
                      } else if (!val.endsWith('@gmail.com')) {
                        return 'please enter valid gmail';
                      }
                      return null;
                    },
                    controller: emailController,
                    style: customText(),
                    decoration: customTextField('Email'),
                  ),
                  SizedBox(height: 20),
                  TextFormField(
                    validator: (String? val) {
                      RegExp reg = RegExp(
                          r'''(?=(.*[0-9]))(?=.*[\!@#$%^&*()\\[\]{}\-_+=~`|:;"'<>,./?])(?=.*[a-z])(?=(.*[A-Z]))(?=(.*)).{8,}''');
                      if (!reg.hasMatch(val!)) {
                        return 'Enter Validate Password';
                      }
                      return null;
                    },
                    controller: passwordController,
                    style: customText(),
                    decoration: customTextField('Password'),
                  ),
                  SizedBox(height: 40),
                  GestureDetector(
                    onTap: () {
                      signUp();
                    },
                    child: Container(
                      alignment: Alignment.center,
                      width: MediaQuery.of(context).size.width,
                      padding: EdgeInsets.symmetric(vertical: 20),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(30)),
                      child: Text(
                        'Sign Up',
                        style: buttonText(),
                      ),
                    ),
                  ),
                  SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Already have account? ',
                        style: customText(),
                      ),
                      GestureDetector(
                        onTap: () {
                          widget.toggle();
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(vertical: 8),
                          child: Text(
                            'SignIn',
                            style: textBtn(),
                          ),
                        ),
                      ),
                    ],
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
