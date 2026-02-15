import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:im_legends/features/profile/logic/cubit/profile_cubit.dart';
import 'package:im_legends/features/profile/ui/widgets/profile_body.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(final BuildContext context) {
    return RefreshIndicator(
      onRefresh: () => context.read<ProfileCubit>().refreshProfile(),
      child: const ProfileBody(),
    );
  }
}
