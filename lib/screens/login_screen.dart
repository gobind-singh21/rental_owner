import 'package:flutter/material.dart';
import 'package:rental_owner/app_widgets/button.dart';
import 'package:rental_owner/app_widgets/text_widgets/heading_text.dart';
import 'package:rental_owner/utils/auth.dart';
import 'package:rental_owner/screens/signup_screen.dart';
import 'package:rental_owner/global/dimensions.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _passwordNotVisible = true;
  double screenHeight = Dimensions.screenHeight;
  double screenWidth = Dimensions.screenWidth;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> signInWithEmailAndPassword(BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      AlertDialog alert = AlertDialog(
        content: Row(
          children: [
            const CircularProgressIndicator(),
            Container(
                margin: const EdgeInsets.only(left: 7),
                child: const Text("Loging in...")),
          ],
        ),
      );
      showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return alert;
        },
      );
      await Auth().signInWithEmailAndPassword(
          email: _emailController.text.trim(),
          password: _passwordController.text.trim(),
          context: context);
      await Future.delayed(const Duration(milliseconds: 500));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Material(
        color: Colors.white,
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                SizedBox(
                  height: screenHeight / 10,
                ),
                HeadingText(
                  "Welcome",
                  screenHeight / 29.233,
                  null,
                  Colors.black,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: screenHeight / 54.8125,
                    horizontal: screenWidth / 12.84375,
                  ),
                  child: Column(
                    children: [
                      TextFormField(
                        controller: _emailController,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          hintText: "Enter email",
                          labelText: "Email",
                          prefixIcon: Icon(
                            Icons.person_outline,
                            size: screenHeight / 29.2333,
                          ),
                          labelStyle: TextStyle(
                            fontSize: screenHeight / 54.8125,
                          ),
                          hintStyle: TextStyle(
                            fontSize: screenHeight / 53,
                          ),
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Email cannot be empty";
                          }
                          return null;
                        },
                      ),
                      SizedBox(
                        height: screenHeight / 87.7,
                      ),
                      TextFormField(
                        controller: _passwordController,
                        obscureText: _passwordNotVisible,
                        decoration: InputDecoration(
                            hintText: "Enter password",
                            labelText: "Password",
                            prefixIcon: Icon(
                              Icons.lock_outline,
                              size: screenHeight / 29.2333,
                            ),
                            labelStyle: TextStyle(
                              fontSize: screenHeight / 54.8125,
                            ),
                            suffixIcon: IconButton(
                                onPressed: () {
                                  setState(() {
                                    _passwordNotVisible = !_passwordNotVisible;
                                  });
                                },
                                icon: Icon(
                                  _passwordNotVisible
                                      ? Icons.visibility_off
                                      : Icons.visibility,
                                  size: screenHeight / 40,
                                ))),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Password cannot be empty";
                          } else if (value.length < 6) {
                            return "Password must be atleast 6 characters long";
                          }
                          return null;
                        },
                      ),
                      SizedBox(
                        height: screenHeight / 21.925,
                      ),
                      InkWell(
                        onTap: () => signInWithEmailAndPassword(context),
                        child: MyButton(
                          "Login",
                          screenHeight / 17.54,
                          screenWidth / 2.74,
                          screenWidth / 30,
                        ),
                      ),
                      SizedBox(
                        height: screenHeight / 87.7,
                      ),
                      TextButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const SignUpScreen()));
                          },
                          child: const Text(
                            "Don't have an account? Register here.",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ))
                    ],
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
