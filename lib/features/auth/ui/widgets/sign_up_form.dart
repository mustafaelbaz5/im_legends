import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:im_legends/core/utils/app_assets.dart';
import '../../../../core/models/user_data.dart';
import '../../../../core/themes/app_colors.dart';
import '../../../../core/themes/app_texts_style.dart';
import '../../../../core/utils/regex.dart';
import '../../../../core/utils/spacing.dart';
import 'app_text_form_field.dart';
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
  final _formKey = GlobalKey<FormState>();

  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _ageController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  File? _profileImage;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _ageController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _setProfileImage(File? image) {
    setState(() => _profileImage = image);
  }

  void _submit() {
    if (!_formKey.currentState!.validate()) return;

    final password = _passwordController.text.trim();
    final confirmPassword = _confirmPasswordController.text.trim();

    if (password != confirmPassword) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Passwords do not match')));
      return;
    }

    final userData = UserData(
      name: _nameController.text.trim(),
      email: _emailController.text.trim(),
      phoneNumber: _phoneController.text.trim(),
      age: int.tryParse(_ageController.text.trim()) ?? 0,
      profileImageUrl: null,
    );

    widget.onSignUp(userData, password, _profileImage);
  }

  bool _isPasswordVisible = false;
  bool _isConfirmPasswordVisible = false;
  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          // Upload Profile Image
          Center(
            child: Column(
              children: [
                UploadImageField(onImageSelected: _setProfileImage),
                if (_profileImage != null)
                  Padding(
                    padding: EdgeInsets.only(top: 8.h),
                    child: Text(
                      "Profile image selected",
                      style: TajawalTextStyles.greyRegular14.copyWith(
                        color: Colors.greenAccent,
                      ),
                    ),
                  ),
              ],
            ),
          ),

          verticalSpacing(24.h),
          const Divider(color: Colors.white24, thickness: 1),
          verticalSpacing(16.h),

          // Name Field
          AppTextFormField(
            controller: _nameController,
            hintText: 'Full Name',
            validator: (v) =>
                (v == null || v.trim().isEmpty) ? 'Name is required' : null,
            keyboardType: TextInputType.name,
          ),
          verticalSpacing(16.h),

          // Email Field
          AppTextFormField(
            controller: _emailController,
            hintText: 'Email Address',
            validator: _validateEmail,
            keyboardType: TextInputType.emailAddress,
          ),
          verticalSpacing(16.h),

          // Phone Field
          AppTextFormField(
            controller: _phoneController,
            hintText: 'Phone Number',
            validator: (v) => (v == null || v.trim().isEmpty)
                ? 'Phone number is required'
                : null,
            keyboardType: TextInputType.phone,
          ),
          verticalSpacing(16.h),

          // Age Field
          AppTextFormField(
            controller: _ageController,
            hintText: 'Age',
            validator: (v) {
              if (v == null || v.trim().isEmpty) return 'Age is required';
              final age = int.tryParse(v.trim());
              if (age == null || age < 10) return 'Enter a valid age (10+)';
              return null;
            },
            keyboardType: TextInputType.number,
          ),
          verticalSpacing(16.h),

          // Password Field
          AppTextFormField(
            controller: _passwordController,
            hintText: 'Password',
            isObscureText: !_isPasswordVisible,
            validator: _validatePassword,
            keyboardType: TextInputType.visiblePassword,
            suffixIcon: IconButton(
              icon: Icon(
                _isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                color: _isPasswordVisible ? Colors.red : Colors.grey,
              ),
              onPressed: () {
                setState(() {
                  _isPasswordVisible = !_isPasswordVisible;
                });
              },
            ),
          ),
          verticalSpacing(16.h),

          // Confirm Password Field
          AppTextFormField(
            controller: _confirmPasswordController,
            hintText: 'Confirm Password',
            isObscureText: !_isConfirmPasswordVisible,
            validator: (_) {
              final password = _passwordController.text.trim();
              final confirmPassword = _confirmPasswordController.text.trim();
              if (password != confirmPassword) {
                return 'Passwords do not match';
              }
              return null;
            },
            suffixIcon: IconButton(
              icon: Icon(
                _isConfirmPasswordVisible
                    ? Icons.visibility
                    : Icons.visibility_off,
                color: _isConfirmPasswordVisible ? Colors.red : Colors.grey,
              ),
              onPressed: () {
                setState(() {
                  _isConfirmPasswordVisible = !_isConfirmPasswordVisible;
                });
              },
            ),
            keyboardType: TextInputType.visiblePassword,
          ),
          verticalSpacing(24.h),

          const Divider(color: Colors.white24, thickness: 1),
          verticalSpacing(8.h),

          // Submit Button
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: widget.isLoading ? null : _submit,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.darkRedColor,
                padding: EdgeInsets.symmetric(vertical: 14.h),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.r),
                ),
              ),
              child: widget.isLoading
                  ? const CircularProgressIndicator(color: Colors.white)
                  : Text(
                      "Create Account",
                      style: RobotoTextStyles.whiteBold18.copyWith(
                        fontFamily: AppAssets.fontRoboto,
                      ),
                    ),
            ),
          ),

          verticalSpacing(12.h),

          // Terms & Policy
          Text(
            "By signing up, you agree to our Terms of Service & Privacy Policy",
            style: TajawalTextStyles.greyRegular14,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  String? _validateEmail(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Email is required';
    }

    if (!AppRegex.isEmailValid(value.trim())) {
      return 'Enter a valid email';
    }

    return null;
  }

  String? _validatePassword(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Password is required';
    }
    if (value.length < 6) {
      return 'Password must be at least 6 characters';
    }
    return null;
  }
}
