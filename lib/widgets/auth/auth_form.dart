import 'package:flutter/material.dart';

import '../picker/image_picker_form.dart';

enum AuthMode { signup, login }

class AuthForm extends StatefulWidget {
  final bool isLoading;
  final void Function(
    String email,
    String username,
    String password,
    AuthMode authMode,
    BuildContext ctx,
  ) submitForm;
  const AuthForm({
    super.key,
    required this.submitForm,
    required this.isLoading,
  });

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
      widget.submitForm(
        _email.trim(),
        _username.trim(),
        _password,
        _authMode,
        context,
      );
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
                if (_authMode == AuthMode.signup) const ImagePickerForm(),
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
                if (widget.isLoading)
                  const Center(child: CircularProgressIndicator()),
                if (!widget.isLoading)
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
                if (!widget.isLoading)
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
