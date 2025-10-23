import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/utils/regex.dart';
import '../../../../core/utils/spacing.dart';
import '../../../../core/widgets/custom_text_button.dart';
import 'app_text_form_field.dart';

class LoginForm extends StatefulWidget {
  final void Function(String email, String password) onLogin;
  final bool isLoading;

  const LoginForm({super.key, required this.onLogin, this.isLoading = false});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  bool _isPasswordVisible = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _submit() {
    if (_formKey.currentState?.validate() ?? false) {
      widget.onLogin(
        _emailController.text.trim(),
        _passwordController.text.trim(),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          /// --- Email Field ---
          AppTextFormField(
            controller: _emailController,
            hintText: 'Email',
            keyboardType: TextInputType.emailAddress,
            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return 'Email is required';
              }
              if (!AppRegex.isEmailValid(value.trim())) {
                return 'Enter a valid email';
              }
              return null;
            },
          ),

          verticalSpacing(16.h),

          /// --- Password Field ---
          AppTextFormField(
            controller: _passwordController,
            hintText: 'Password',
            keyboardType: TextInputType.visiblePassword,
            isObscureText: !_isPasswordVisible,
            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return 'Password is required';
              }
              if (value.length < 6) {
                return 'Password must be at least 6 characters';
              }
              return null;
            },
            suffixIcon: IconButton(
              icon: Icon(
                _isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                color: _isPasswordVisible ? Colors.red : Colors.grey,
              ),
              onPressed: () {
                setState(() => _isPasswordVisible = !_isPasswordVisible);
              },
            ),
          ),

          verticalSpacing(24.h),

          /// --- Login Button ---
          CustomTextButton(
            borderRadius: 12.r,
            buttonText: 'Login',
            onPressed: widget.isLoading ? null : _submit,
            isLoading: widget.isLoading,
          ),
        ],
      ),
    );
  }
}
