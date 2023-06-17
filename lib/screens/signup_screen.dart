import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:rental_owner/app_widgets/button.dart';
import 'package:rental_owner/app_widgets/text_widgets/heading_text.dart';
import 'dart:io';
import 'package:rental_owner/utils/cropper.dart';
import 'package:rental_owner/utils/auth.dart';
import 'package:rental_owner/global/dimensions.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  bool _passwordNotVisible = true;

  File? pickedFile;
  String? urlDownload;

  Future selectFile() async {
    final result = await FilePicker.platform.pickFiles(type: FileType.image);
    if (result == null) return;

    pickedFile = await Cropper.cropSquareImage(File(result.files.first.path!));

    Fluttertoast.showToast(
      msg: 'File added successfully',
      toastLength: Toast.LENGTH_LONG,
    );
  }

  Future uploadFile() async {
    if (pickedFile == null) {
      Fluttertoast.showToast(
        msg: 'Please select a profile picture',
        toastLength: Toast.LENGTH_LONG,
      );
      return;
    }
    AlertDialog alert = AlertDialog(
      content: Row(
        children: [
          const CircularProgressIndicator(),
          Container(
              margin: const EdgeInsets.only(left: 7),
              child: const Text("Creating your account...")),
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
    if (_formKey.currentState!.validate()) {
      await Auth().createUserWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
        name: _nameController.text.trim(),
        number: _numberController.text.trim(),
        pickedFile: pickedFile,
        context: context,
      );
    }
  }

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _numberController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _nameController.dispose();
    _passwordController.dispose();
    _numberController.dispose();
    super.dispose();
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
                height: Dimensions.screenHeight / 11,
              ),
              HeadingText("Create your account",
                  Dimensions.screenHeight / 29.23, null, Colors.black),
              Padding(
                padding: EdgeInsets.symmetric(
                  vertical: Dimensions.screenHeight / 54.8125,
                  horizontal: Dimensions.screenWidth / 12.84375,
                ),
                child: Column(
                  children: [
                    TextFormField(
                      controller: _nameController,
                      textCapitalization: TextCapitalization.words,
                      keyboardType: TextInputType.name,
                      decoration: InputDecoration(
                        hintText: "Enter user name",
                        labelText: "User name",
                        prefixIcon: Icon(
                          Icons.person_outline,
                          size: Dimensions.screenHeight / 29.2333,
                        ),
                        labelStyle: TextStyle(
                          fontSize: Dimensions.screenHeight / 54.8125,
                        ),
                        hintStyle: TextStyle(
                          fontSize: Dimensions.screenHeight / 53,
                        ),
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "User name cannot be empty";
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: Dimensions.screenHeight / 87.7,
                    ),
                    TextFormField(
                      controller: _emailController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        hintText: "Enter Email",
                        labelText: "Email",
                        prefixIcon: Icon(
                          Icons.mail_outline,
                          size: Dimensions.screenHeight / 29.2333,
                        ),
                        labelStyle: TextStyle(
                          fontSize: Dimensions.screenHeight / 54.8125,
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
                      height: Dimensions.screenHeight / 87.7,
                    ),
                    TextFormField(
                      controller: _numberController,
                      keyboardType: TextInputType.phone,
                      decoration: InputDecoration(
                        hintText: "Enter phone number",
                        labelText: "Phone Number",
                        prefixIcon: Icon(
                          Icons.phone_outlined,
                          size: Dimensions.screenHeight / 29.2333,
                        ),
                        labelStyle: TextStyle(
                          fontSize: Dimensions.screenHeight / 54.8125,
                        ),
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Phone number cannot be empty";
                        } else if (value.length != 10) {
                          return "Invalid phone number";
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: Dimensions.screenHeight / 87.7,
                    ),
                    TextFormField(
                      controller: _passwordController,
                      obscureText: _passwordNotVisible,
                      decoration: InputDecoration(
                          hintText: "Enter password",
                          labelText: "Password",
                          prefixIcon: Icon(
                            Icons.lock_outline,
                            size: Dimensions.screenHeight / 29.2333,
                          ),
                          labelStyle: TextStyle(
                            fontSize: Dimensions.screenHeight / 54.8125,
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
                                size: Dimensions.screenHeight / 40,
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
                      height: Dimensions.screenHeight / 21.925,
                    ),
                    InkWell(
                      onTap: () => selectFile(),
                      child: MyButton(
                        "Select file",
                        Dimensions.screenHeight / 17.54,
                        Dimensions.screenWidth / 2.74,
                        Dimensions.screenWidth / 30,
                      ),
                    ),
                    SizedBox(
                      height: Dimensions.screenHeight / 40,
                    ),
                    InkWell(
                      onTap: () => uploadFile(),
                      child: MyButton(
                        "Sign Up",
                        Dimensions.screenHeight / 17.54,
                        Dimensions.screenWidth / 2.74,
                        Dimensions.screenWidth / 30,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
