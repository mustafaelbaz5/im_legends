import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:im_legends/core/themes/app_colors.dart';
import 'package:im_legends/core/utils/extensions/context_extensions.dart';
import 'package:im_legends/core/widgets/custom_app_bar.dart';
import 'package:im_legends/features/add_match/logic/cubit/add_match_cubit.dart';
import 'package:im_legends/features/add_match/ui/widgets/add_match_bloc_consumer.dart';
import 'package:im_legends/features/add_match/ui/widgets/player_select_field/player_select_field.dart';
import 'package:im_legends/features/add_match/ui/widgets/score_input_field.dart';

import '../../../core/utils/spacing.dart';

class AddMatchScreen extends StatelessWidget {
  const AddMatchScreen({super.key});

  Future<void> onRefresh(final BuildContext context) async {
    context.read<AddMatchCubit>().resetMatchData();
    context.read<AddMatchCubit>().getPlayersList();
    await Future.delayed(const Duration(milliseconds: 300));
  }

  @override
  Widget build(final BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          CustomAppBar(title: 'add_match.add_match'.tr()),
          Expanded(
            child: RefreshIndicator(
              onRefresh: () => onRefresh(context),
              backgroundColor: context.customColors.background,
              color: context.customColors.textPrimary,
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                padding: EdgeInsets.symmetric(horizontal: responsiveWidth(16)),
                child: BlocBuilder<AddMatchCubit, AddMatchState>(
                  builder: (final context, final state) {
                    return Column(
                      children: [
                        verticalSpacing(20),

                        // Winner
                        PlayerSelectField(
                          hint: 'add_match.select_winner'.tr(),
                          accentColor: AppColors.green100,
                          selectedPlayerId: state.winnerId,
                          selectedName: state.winnerName,
                          selectedImageUrl: state.winnerImage,
                          excludedPlayer: state.loserId, // exclude loser
                          isWinnerField: true,
                          onSelected: (final id, final name, final image) {
                            context.read<AddMatchCubit>().updateWinner(
                              id,
                              name,
                              image,
                            );
                          },
                        ),
                        verticalSpacing(16),
                        const ScoreInputField(
                          accentColor: AppColors.green100,
                          isWinner: true,
                        ),
                        verticalSpacing(80),

                        // Loser

                        /// Loser field
                        PlayerSelectField(
                          hint: 'add_match.select_loser'.tr(),
                          accentColor: AppColors.red100,
                          selectedPlayerId: state.loserId,
                          selectedName: state.loserName,
                          selectedImageUrl: state.loserImage,
                          excludedPlayer: state.winnerId, // exclude winner
                          isWinnerField: false,
                          onSelected: (final id, final name, final image) {
                            context.read<AddMatchCubit>().updateLoser(
                              id,
                              name,
                              image,
                            );
                          },
                        ),
                        verticalSpacing(16),
                        const ScoreInputField(
                          accentColor: AppColors.red100,
                          isWinner: false,
                        ),
                        verticalSpacing(100),

                        // Submit button
                        const AddMatchBlocConsumer(),
                      ],
                    );
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
