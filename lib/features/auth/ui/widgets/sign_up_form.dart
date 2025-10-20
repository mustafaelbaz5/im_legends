import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/models/user_data.dart';
import '../../../../core/utils/spacing.dart';
import '../../../../core/widgets/app_text_form_field.dart';
import 'auth_form.dart';
import 'upload_image_field.dart';

class SignUpForm extends StatefulWidget {
  final void Function(UserData userData, String password, File? profileImage)
  onSignUp;
  final bool isLoading;

  const SignUpForm({super.key, required this.onSignUp, this.isLoading = false});

  @override
  State<SignUpForm> createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _ageController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  File? _profileImage;

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _ageController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _setProfileImage(File? image) {
    setState(() {
      _profileImage = image;
    });
  }

  @override
  Widget build(BuildContext context) {
    return AuthForm(
      actionText: 'Sign Up',
      isLoading: widget.isLoading,
      onSubmit: (values) {
        final password = values['password']!;
        final confirmPassword = _confirmPasswordController.text.trim();

        if (password != confirmPassword) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Passwords do not match')),
          );
          return;
        }

        final userData = UserData(
          name: _nameController.text.trim(),
          email: values['email']!,
          phoneNumber: _phoneController.text.trim(),
          age: int.tryParse(_ageController.text.trim()) ?? 0,
          profileImageUrl: null,
        );

        widget.onSignUp(userData, password, _profileImage);
      },
      extraFields: [
        verticalSpacing(16.h),
        AppTextFormField(
          controller: _confirmPasswordController,
          hintText: 'Confirm Password',
          isObscureText: true,
          validator: (value) => (value == null || value.trim().length < 6)
              ? 'Confirm password must be at least 6 characters'
              : null,
        ),
        verticalSpacing(16.h),
        AppTextFormField(
          controller: _nameController,
          hintText: 'Name',
          validator: (value) => (value == null || value.trim().isEmpty)
              ? 'Name is required'
              : null,
        ),
        verticalSpacing(16.h),
        AppTextFormField(
          controller: _phoneController,
          hintText: 'Phone Number',
          keyboardType: TextInputType.phone,
          validator: (value) => (value == null || value.trim().isEmpty)
              ? 'Phone number is required'
              : null,
        ),
        verticalSpacing(16.h),
        AppTextFormField(
          controller: _ageController,
          hintText: 'Age',
          keyboardType: TextInputType.number,
          validator: (value) =>
              (value == null || int.tryParse(value.trim()) == null)
              ? 'Valid age is required'
              : null,
        ),
        verticalSpacing(16.h),
        UploadImageField(onImageSelected: _setProfileImage),
      ],
    );
  }
}
