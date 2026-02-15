import 'package:flutter/material.dart';
import 'package:im_legends/core/models/players_states_model.dart';
import 'package:im_legends/core/models/user_data.dart';
import 'package:im_legends/core/utils/spacing.dart';

import 'profile_header.dart';
import 'profile_info_section.dart';
import 'profile_settings/profile_settings.dart';
import 'profile_statistics/profile_stats_section.dart';

class ProfileBody extends StatelessWidget {
  const ProfileBody({super.key});

  @override
  Widget build(final BuildContext context) {
    return CustomScrollView(
      slivers: [
        const SliverToBoxAdapter(child: ProfileHeader(name: 'Mustafa Elbaz')),
        SliverToBoxAdapter(child: verticalSpacing(16)),
        SliverToBoxAdapter(
          child: ProfileStatsSection(
            stats: PlayerStatsModel(
              playerId: '1',
              playerName: 'Mustafa Elbaz',
              matchesPlayed: 12,
              wins: 8,
              losses: 4,
              goalsScored: 20,
              goalsReceived: 10,
              points: 24,
              rank: 1,
            ),
          ),
        ),
        SliverToBoxAdapter(child: verticalSpacing(16)),
        SliverToBoxAdapter(
          child: ProfileInfoSection(
            userDataModel: UserData(
              name: 'Mustafa Elbaz',
              email: '[EMAIL_ADDRESS]',
              phoneNumber: '01010101010',
              age: 25,
            ),
          ),
        ),
        SliverToBoxAdapter(child: verticalSpacing(16)),

        const SliverToBoxAdapter(child: ProfileSettings()),
        SliverToBoxAdapter(child: verticalSpacing(16)),
      ],
    );
  }
}
