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
            if (state is AuthSuccess) {
              final user = state.authResponse.user;
              if (user != null) {
                // Initialize notifications
                await context
                    .read<NotificationsCubit>()
                    .notificationRepo
                    .initialize(user.id);
                await context.read<NotificationsCubit>().sendLoginNotification(
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
              Navigator.pop(context); // Close loading dialog
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

  void _showErrorDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Error'),
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
