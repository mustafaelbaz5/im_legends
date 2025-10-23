import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/models/user_data.dart';
import '../../../../core/router/route_paths.dart';
import '../../../../core/widgets/custom_text_button.dart';
import '../../../notification/logic/cubit/notifications_cubit.dart';
import '../../logic/cubit/auth_cubit.dart';
import 'sign_up_form.dart';

class SignUpBlocConsumer extends StatelessWidget {
  const SignUpBlocConsumer({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<AuthCubit, AuthState>(
          listener: (context, state) async {
            if (state is AuthLoading) {
              _showLoadingDialog(context);
            } else if (Navigator.canPop(context)) {
              Navigator.pop(context); // Close loading dialog
            }

            if (state is AuthSuccess) {
              final user = state.authResponse.user;
              if (user != null) {
                await context
                    .read<NotificationsCubit>()
                    .notificationRepo
                    .initialize(user.id);
                // Trigger sign-up notification
                await context.read<NotificationsCubit>().sendSignUpNotification(
                  userId: user.id,
                  userName:
                      state.userData?.name ??
                      user.email?.split('@').first ??
                      'User',
                  email: user.email ?? '',
                );
              }
              context.go(Routes.homeScreen);
            } else if (state is AuthFailure) {
              _showErrorDialog(context, state.errorMessage);
            }
          },
        ),
        BlocListener<NotificationsCubit, NotificationsState>(
          listener: (context, state) {
            if (state is NotificationsFailure) {
              _showErrorDialog(context, state.errorMessage);
            }
          },
        ),
      ],
      child: BlocBuilder<AuthCubit, AuthState>(
        builder: (context, state) {
          return SignUpForm(
            onSignUp:
                (UserData userData, String password, File? profileImage) async {
                  context.read<AuthCubit>().emitSignUp(
                    userData: userData,
                    password: password,
                    profileImage: profileImage,
                  );
                },
          );
        },
      ),
    );
  }

  void _showErrorDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Error'),
        content: Text(
          message.isEmpty ? 'An error occurred. Please try again.' : message,
        ),
        actions: [
          CustomTextButton(
            buttonText: 'OK',
            borderRadius: 8.r,
            onPressed: () => Navigator.pop(context),
          ),
        ],
      ),
    );
  }

  void _showLoadingDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => const Center(child: CircularProgressIndicator()),
    );
  }
}
