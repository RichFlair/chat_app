import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';

import '../widgets/auth/auth_form.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final _auth = FirebaseAuth.instance;

  void _submitAuthForm(
    String email,
    String username,
    String password,
    AuthMode authMode,
    BuildContext ctx,
  ) async {
    // implement authentication
    try {
      if (authMode == AuthMode.login) {
        await _auth.signInWithEmailAndPassword(
          email: email,
          password: password,
        );
      } else if (authMode == AuthMode.signup) {
        await _auth.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );
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
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: AuthForm(submitForm: _submitAuthForm),
    );
  }
}
