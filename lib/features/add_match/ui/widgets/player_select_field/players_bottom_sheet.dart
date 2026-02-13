import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/themes/app_texts_style.dart';
import '../../../../../core/utils/extensions/context_extensions.dart';
import '../../../../../core/utils/spacing.dart';
import '../../../logic/cubit/add_match_cubit.dart';
import 'player_tile.dart';

class PlayerBottomSheet extends StatelessWidget {
  final void Function(String id, String name, String imageUrl) onSelect;
  final String? excludedPlayer;
  final bool isWinnerField;

  const PlayerBottomSheet({
    super.key,
    required this.onSelect,
    this.excludedPlayer,
    required this.isWinnerField, // true for winner field, false for loser field
  });

  @override
  Widget build(final BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.5,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            context.customColors.background,
            context.customColors.background.withAlpha(200),
          ],
        ),
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(responsiveRadius(24)),
        ),
      ),
      child: Column(
        children: [
          // Drag handle
          Container(
            margin: EdgeInsets.only(top: responsiveHeight(12)),
            width: responsiveWidth(40),
            height: responsiveHeight(4),
            decoration: BoxDecoration(
              color: context.customColors.textPrimary.withAlpha(38),
              borderRadius: BorderRadius.circular(responsiveRadius(2)),
            ),
          ),
          _buildHeader(context),
          Expanded(
            child: BlocBuilder<AddMatchCubit, AddMatchState>(
              builder: (final context, final state) {
                if (state.players.isEmpty) {
                  return const Center(child: CircularProgressIndicator());
                }

                final filteredPlayers = state.players
                    .where(
                      (final p) => p['id'] != excludedPlayer,
                    ) 
                    .toList();

                if (filteredPlayers.isEmpty) return _buildEmpty(context);

                return ListView.builder(
                  padding: EdgeInsets.symmetric(
                    horizontal: responsiveWidth(16),
                  ),
                  itemCount: filteredPlayers.length,
                  itemBuilder: (final context, final index) {
                    final player = filteredPlayers[index];

                    // Determine selected player from Cubit
                    final selectedId = isWinnerField
                        ? state.winnerId
                        : state.loserId;
                    final isSelected = selectedId == player['id'];

                    return PlayerTile(
                      playerId: player['id'],
                      playerName: player['name'],
                      playerImage: player['profile_image'] ?? '',
                      isSelected: isSelected,
                      index: index,
                      onSelect: (final id, final name, final image) {
                        onSelect(id, name, image);
                        Navigator.pop(context);
                      },
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader(final BuildContext context) => Padding(
    padding: EdgeInsets.all(responsiveRadius(20)),
    child: Row(
      children: [
        Icon(
          Icons.sports_esports_rounded,
          color: context.customColors.textPrimary,
          size: responsiveFontSize(24),
        ),
        horizontalSpacing(12),
        Text('Choose Player', style: AppTextStyles.font16Bold),
        const Spacer(),
        BlocBuilder<AddMatchCubit, AddMatchState>(
          builder: (final context, final state) {
            final count = state.players
                .where((final p) => p['id'] != excludedPlayer)
                .length;
            return Text(
              '$count players',
              style: AppTextStyles.font12Regular.copyWith(
                color: context.customColors.textPrimary.withAlpha(153),
              ),
            );
          },
        ),
      ],
    ),
  );

  Widget _buildEmpty(final BuildContext context) => Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          Icons.person_off_outlined,
          color: context.customColors.textPrimary.withAlpha(102),
          size: responsiveFontSize(48),
        ),
        verticalSpacing(16),
        Text('No players available', style: AppTextStyles.font16Bold),
      ],
    ),
  );
}
