import 'package:flutter/material.dart';

import 'auth_form.dart';

class LoginForm extends StatelessWidget {
  final void Function(String email, String password) onLogin;
  final bool isLoading;

  const LoginForm({super.key, required this.onLogin, this.isLoading = false});

  @override
  Widget build(BuildContext context) {
    return AuthForm(
      actionText: 'Login',
      onSubmit: (values) => onLogin(values['email']!, values['password']!),
      isLoading: isLoading,
    );
  }
}
