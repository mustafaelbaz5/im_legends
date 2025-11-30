import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../notification/logic/cubit/notifications_cubit.dart';
import '../../logic/cubit/auth_cubit.dart';
import 'login_form.dart';
import '../../../../core/router/route_paths.dart';

class LoginBlocConsumer extends StatelessWidget {
  const LoginBlocConsumer({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<AuthCubit, AuthState>(
          listener: (context, state) async {
            if (state is AuthLoading) {
              // Show loading dialog when loading starts
              _showLoadingDialog(context);
            } else if (state is AuthSuccess) {
              // Close loading dialog
              if (Navigator.canPop(context)) {
                Navigator.pop(context);
              }

              final user = state.authResponse.user;
              if (user != null) {
                try {
                  // Initialize notifications
                  await context
                      .read<NotificationsCubit>()
                      .notificationRepo
                      .initialize(user.id);
                  await context
                      .read<NotificationsCubit>()
                      .sendLoginNotification(
                        userId: user.id,
                        userName:
                            state.userData?.name ??
                            user.email?.split('@').first ??
                            'User',
                        email: user.email ?? '',
                      );
                } catch (e) {
                  debugPrint('❌ Notification error (non-critical): $e');
                }
              }

              // Navigate to home screen
              if (context.mounted) {
                context.go(Routes.homeScreen);
              }
            } else if (state is AuthFailure) {
              // Close loading dialog
              if (Navigator.canPop(context)) {
                Navigator.pop(context);
              }

              // Show error dialog
              if (context.mounted) {
                _showErrorDialog(context, state.errorMessage);
              }
            }
          },
        ),
        BlocListener<NotificationsCubit, NotificationsState>(
          listener: (context, state) {
            if (state is NotificationsFailure) {
              // Don't show error for notifications - it's not critical
              debugPrint('❌ Notification error: ${state.errorMessage}');
            }
          },
        ),
      ],
      child: BlocBuilder<AuthCubit, AuthState>(
        builder: (context, state) {
          return LoginForm(
            onLogin: (email, password) {
              context.read<AuthCubit>().emitLogin(
                email: email,
                password: password,
              );
            },
            isLoading: state is AuthLoading,
          );
        },
      ),
    );
  }

  void _showLoadingDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => const PopScope(
        canPop: false,
        child: const Center(child: CircularProgressIndicator()),
      ),
    );
  }

  void _showErrorDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Login Failed'),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }
}
