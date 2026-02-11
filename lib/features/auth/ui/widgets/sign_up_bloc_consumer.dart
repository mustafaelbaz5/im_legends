import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:im_legends/core/ui/dialogs/app_dialogs.dart';
import 'package:im_legends/core/ui/loaders/overlay_loader.dart';
import 'package:im_legends/core/utils/extensions/context_extensions.dart';

import '../../../../core/router/routes.dart';
import '../../logic/cubit/auth_cubit.dart';
import 'sign_up_form.dart';

class SignUpBlocConsumer extends StatelessWidget {
  const SignUpBlocConsumer({super.key});

  @override
  Widget build(final BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (final context, final state) async {
        if (state is AuthSuccess) {
          context.pushNamedAndRemoveAll(Routes.mainScaffold);
        } else if (state is AuthFailure) {
          AppDialogs.showError(context, message: state.error.messageKey);
        }
      },
      builder: (final context, final state) {
        return OverlayLoader(
          child: const SignUpForm(),
          isLoading: state is AuthLoading,
        );
      },
    );
  }
}
