import 'dart:async';

import 'package:eventus/screens/auth/auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

import '../../assets/app_color_palette.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String? errorMessage = '';
  bool isLogin = true;

  final _storage = FirebaseStorage.instance;


  final TextEditingController _controllerEmail = TextEditingController();
  final TextEditingController _controllerPassword = TextEditingController();
  final TextEditingController _controllerName = TextEditingController();

  Future<void> signInWithEmailAndPassword() async {
    try {
      await Auth().signInWithEmailAndPassword(
        email: _controllerEmail.text,
        password: _controllerPassword.text,
      );
    } on FirebaseAuthException catch (e) {
      setState(
        () {
          errorMessage = e.message;
        },
      );
    }
  }

  Future<void> createUserWithEmailAndPassword() async {
    try {
      await Auth().createUserWithEmailAndPassword(
        email: _controllerEmail.text,
        password: _controllerPassword.text,
        name: _controllerName.text,
      );
    } on FirebaseAuthException catch (e) {
      setState(
        () {
          errorMessage = e.message;
        },
      );
    }
  }

  Widget _entryField(String title, TextEditingController controller) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 24),
      child: TextField(
          controller: controller,
          decoration: InputDecoration(labelText: title)),
    );
  }

  Widget _errorMessage() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      child: Text(errorMessage == '' ? '' : "Error: $errorMessage"),
    );
  }

  Widget _submitButton() {
    return ElevatedButton(
      onPressed:
          isLogin ? signInWithEmailAndPassword : createUserWithEmailAndPassword,
      child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 6),
          child: Text(
            isLogin ? 'Login' : 'Register',
            style: const TextStyle(fontSize: 16),
          )),
    );
  }

  Widget _loginOrRegisterButton() {
    return TextButton(
      onPressed: () {
        setState(() {
          isLogin = !isLogin;
        });
      },
      child: Text(isLogin ? 'Register Instead' : 'Login Instead'),
    );
  }

  @override
  void initState() {
    super.initState();

    _storageRef = _storage.ref().child('/appAssets');

  }

  late Reference _storageRef;

  @override
Widget build(BuildContext context) {
  return FutureBuilder<String>(
    future: _storageRef.child('appLogo.png').getDownloadURL(),
    builder: (context, snapshot) {
      if (snapshot.connectionState == ConnectionState.waiting) {
        // Display a loading indicator while fetching the image URL
        return const CircularProgressIndicator();
      } else if (snapshot.hasError) {
        // Handle any errors that occurred while fetching the image URL
        return const Text('Error loading image');
      } else {
        // The image URL is available, render the widget with the image
        return SingleChildScrollView(
          child: SizedBox(
            height: MediaQuery.of(context).size.height -
                AppBar().preferredSize.height -
                kBottomNavigationBarHeight,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  margin: const EdgeInsets.only(top: 36, bottom: 8),
                  height: 250,
                  width: 250,
                  child: Stack(
                    children: [
                      Container(
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(40)),
                          gradient: LinearGradient(
                            colors: [
                              TeAppColorPalette.purple,
                              TeAppColorPalette.pink
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: TeAppColorPalette.pink,
                              offset: Offset(2, 2),
                              blurRadius: 12,
                            ),
                            BoxShadow(
                              color: TeAppColorPalette.purple,
                              offset: Offset(-2, -2),
                              blurRadius: 12,
                            ),
                          ],
                        ),
                      ),
                      ClipRRect(
                        borderRadius: const BorderRadius.all(Radius.circular(40)),
                        child: Image.network(
                          snapshot.data!,
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      !isLogin
                          ? _entryField(' Name', _controllerName)
                          : const SizedBox(),
                      _entryField(' Email', _controllerEmail),
                      _entryField(' Password', _controllerPassword),
                      _errorMessage(),
                      _submitButton(),
                      _loginOrRegisterButton(),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      }
    },
  );
}

}
