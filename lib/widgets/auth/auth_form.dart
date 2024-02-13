import 'package:flutter/material.dart';

enum AuthMode { signup, login }

class AuthForm extends StatefulWidget {
  const AuthForm({super.key});

  @override
  State<AuthForm> createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final _formKey = GlobalKey<FormState>();
  var _email = '';
  var _username = '';
  var _password = '';
  AuthMode _authMode = AuthMode.login;

  void _submit() {
    final isValidated = _formKey.currentState!.validate();
    FocusScope.of(context).unfocus();
    if (isValidated) {
      _formKey.currentState!.save();
      print('Validation successful');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(4),
        ),
        margin: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Email textfield
                TextFormField(
                  key: const ValueKey('email'),
                  decoration: const InputDecoration(labelText: 'Email address'),
                  keyboardType: TextInputType.emailAddress,
                  onSaved: (newValue) {
                    _email = newValue!;
                  },
                  validator: (value) {
                    if (value!.isEmpty || !value.contains('@')) {
                      return 'Enter a valid email address';
                    }
                    return null;
                  },
                ),
                // Username textfield
                if (_authMode == AuthMode.signup)
                  TextFormField(
                    key: const ValueKey('username'),
                    decoration: const InputDecoration(labelText: 'Username'),
                    onSaved: (newValue) {
                      _username = newValue!;
                    },
                    validator: (value) {
                      if (value!.isEmpty || value.length < 5) {
                        return 'Username is too short';
                      }
                      return null;
                    },
                  ),
                // Password textfield
                TextFormField(
                  key: const ValueKey('password'),
                  decoration: const InputDecoration(labelText: 'Password'),
                  obscureText: true,
                  enableSuggestions: false,
                  onSaved: (newValue) {
                    _password = newValue!;
                  },
                  validator: (value) {
                    if (value!.isEmpty || value.length < 8) {
                      return 'Password should be more than 8 characters';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStatePropertyAll(
                        Theme.of(context).primaryColor),
                    foregroundColor:
                        const MaterialStatePropertyAll(Colors.white),
                  ),
                  onPressed: _submit,
                  child:
                      Text(_authMode == AuthMode.login ? 'LOGIN' : 'SIGN UP'),
                ),
                TextButton(
                  onPressed: () {
                    // Switching the auth mode between login and signup
                    setState(() {
                      _authMode = _authMode == AuthMode.login
                          ? AuthMode.signup
                          : AuthMode.login;
                    });
                  },
                  child: Text(_authMode == AuthMode.login
                      ? 'CREATE AN ACCOUNT'
                      : 'AlREADY HAVE AN ACCOUNT? LOG IN'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
