import 'dart:io';

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

import '../widgets/auth/auth_form.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final _auth = FirebaseAuth.instance;
  var isLoading = false;
  late BuildContext _ctx;

  void _submitAuthForm(
    String email,
    String username,
    String password,
    File userImageFile,
    AuthMode authMode,
  ) async {
    // implement authentication
    try {
      setState(() {
        isLoading = true;
      });
      if (authMode == AuthMode.login) {
        await _auth.signInWithEmailAndPassword(
          email: email,
          password: password,
        );
      } else if (authMode == AuthMode.signup) {
        var authResult = await _auth.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );
        // adding user image to Firebase storage
        final ref = FirebaseStorage.instance
            .ref()
            .child('user_image')
            .child(authResult.user!.uid);

        await ref.putFile(userImageFile).whenComplete(() => null);

        // adding user data to Firestore
        await FirebaseFirestore.instance
            .collection('users')
            .doc(authResult.user?.uid)
            .set({
          'username': username,
          'email': email,
        });
      }
      setState(() {
        isLoading = false;
      });
    } on PlatformException catch (error) {
      var message = 'An error occured, please check your credentials';
      if (error.message != null) {
        message = error.message!;
      }
      _showSnackBar(message);
      setState(() {
        isLoading = false;
      });
    } catch (er) {
      print(er);
      _showSnackBar(er.toString());
      setState(() {
        isLoading = false;
      });
    }
  }

  void _showSnackBar(errorMessage) {
    ScaffoldMessenger.of(_ctx).showSnackBar(
      SnackBar(
        content: Text(errorMessage),
        backgroundColor: Theme.of(_ctx).colorScheme.error,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    _ctx = context;
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: AuthForm(
        submitForm: _submitAuthForm,
        isLoading: isLoading,
      ),
    );
  }
}
