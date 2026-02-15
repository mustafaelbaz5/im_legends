import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:im_legends/core/ui/dialogs/app_dialogs.dart';
import 'package:im_legends/core/utils/extensions/context_extensions.dart';
import 'package:im_legends/core/utils/functions/refresh_page.dart';
import 'package:im_legends/features/profile/ui/widgets/profile_body.dart';

import '../../../core/router/routes.dart';
import '../logic/cubit/profile_cubit.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(final BuildContext context) {
    return BlocListener<ProfileCubit, ProfileState>(
      listener: (final context, final state) {
        if (state is ProfileLoggedOut) {
          AppDialogs.showConfirm(
            context,
            title: 'Logged Out',
            message: 'Are you sure you want to log out?',
            onConfirm: () {
              context.pushNamedAndRemoveAll(Routes.onBoardingScreen);
            },
          );
        }
      },
      child: RefreshIndicator(
        onRefresh: () => refreshData(context),
        child: const ProfileBody(),
      ),
    );
  }
}
