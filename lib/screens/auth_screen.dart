import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../widgets/auth/auth_form.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final _auth = FirebaseAuth.instance;
  var isLoading = false;

  void _submitAuthForm(
    String email,
    String username,
    String password,
    AuthMode authMode,
    BuildContext ctx,
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
        // after creating the user add data to Firestore
        // FirebaseFirestore.instance
        //     .collection('users')
        //     .doc(authResult.user?.uid)
        //     .set({
        //   'username': username,
        //   'email': email,
        // });
      }
    } on PlatformException catch (error) {
      var message = 'An error occured, please check your credentials';
      if (error.message != null) {
        message = error.message!;
      }
      ScaffoldMessenger.of(ctx).showSnackBar(
        SnackBar(
          content: Text(message),
        ),
      );
      setState(() {
        isLoading = false;
      });
    } catch (er) {
      print(er);
      ScaffoldMessenger.of(ctx).showSnackBar(
        SnackBar(
          content: Text(
            er.toString(),
          ),
          backgroundColor: Theme.of(ctx).colorScheme.error,
        ),
      );
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: AuthForm(
        submitForm: _submitAuthForm,
        isLoading: isLoading,
      ),
    );
  }
}
