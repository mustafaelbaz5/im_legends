import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../../core/themes/text_styles/bebas_text_styles.dart';
import '../../logic/cubit/leader_board_cubit.dart';
import 'leader_board_card.dart';

class LeadBoardListView extends StatelessWidget {
  const LeadBoardListView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LeaderBoardCubit, LeaderBoardState>(
      builder: (context, state) {
        if (state is LeaderBoardFailure) {
          return Center(
            child: Text(state.message, style: BebasTextStyles.whiteBold20),
          );
        } else if (state is LeaderBoardLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is LeaderBoardSuccess) {
          return ListView.builder(
            padding: EdgeInsets.zero,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: state.leaderboard.length,
            itemBuilder: (context, index) {
              final player = state.leaderboard[index];
              final currentUserId =
                  Supabase.instance.client.auth.currentUser?.id;
              player.matchesPlayed;
              return LeaderBoardCard(
                isCurrentUser: currentUserId == player.playerId,
                player: player,
              );
            },
          );
        } else {
          return const Center(child: Text('Something went wrong'));
        }
      },
    );
  }
}
