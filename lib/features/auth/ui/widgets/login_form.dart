import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:im_legends/core/utils/validators.dart';
import 'package:im_legends/core/widgets/custom_text_form_.dart';

import '../../../../core/utils/spacing.dart';
import '../../../../core/widgets/custom_text_button.dart';

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
  Widget build(final BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          /// --- Email Field ---
          CustomTextFormField(
            controller: _emailController,
            hintText: 'auth.email'.tr(),
            keyboardType: TextInputType.emailAddress,
            validator: Validators.email,
          ),
          verticalSpacing(24),

          /// --- Password Field ---
          CustomTextFormField(
            controller: _passwordController,
            hintText: 'auth.password'.tr(),
            keyboardType: TextInputType.visiblePassword,
            isPassword: !_isPasswordVisible,
            validator: Validators.password,
            suffixIcon: IconButton(
              icon: Icon(
                _isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                color: _isPasswordVisible ? Colors.red : Colors.grey,
              ),
              onPressed: () =>
                  setState(() => _isPasswordVisible = !_isPasswordVisible),
            ),
          ),
          verticalSpacing(60),

          /// --- Login Button ---
          CustomTextButton(
            text: 'auth.login'.tr(),
            onPressed: widget.isLoading ? null : _submit,
            isLoading: widget.isLoading,
          ),
        ],
      ),
    );
  }
}
