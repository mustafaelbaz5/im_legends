import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:im_legends/core/themes/app_texts_style.dart';
import 'package:im_legends/core/utils/extensions/context_extensions.dart';
import 'package:im_legends/core/utils/spacing.dart';
import 'package:im_legends/features/add_match/logic/cubit/add_match_cubit.dart';

class ScoreInputField extends StatelessWidget {
  const ScoreInputField({
    super.key,
    required this.accentColor,
    required this.isWinner,
  });

  final Color accentColor;
  final bool isWinner;

  @override
  Widget build(final BuildContext context) {
    return BlocBuilder<AddMatchCubit, AddMatchState>(
      buildWhen: (final previous, final current) {
        if (isWinner) {
          return previous.winnerScore != current.winnerScore;
        } else {
          return previous.loserScore != current.loserScore ||
              previous.winnerScore != current.winnerScore;
        }
      },
      builder: (final context, final state) {
        final score = isWinner ? state.winnerScore : state.loserScore;
        final isDecrementEnabled = score > 0;
        final isIncrementEnabled = isWinner
            ? true
            : (state.loserScore + 1) < state.winnerScore;

        return AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          height: responsiveHeight(56),
          width: responsiveWidth(320),
          padding: EdgeInsets.symmetric(horizontal: responsiveWidth(12)),
          decoration: BoxDecoration(
            color: context.customColors.background,
            borderRadius: BorderRadius.circular(responsiveRadius(16)),
            border: Border.all(color: accentColor.withValues(alpha: 0.3)),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildControlButton(
                context: context,
                icon: Icons.remove_rounded,
                isEnabled: isDecrementEnabled,
                onTap: () {
                  if (isWinner) {
                    context.read<AddMatchCubit>().updateWinnerScore(-1);
                  } else {
                    context.read<AddMatchCubit>().updateLoserScore(-1);
                  }
                },
              ),
              const Spacer(),
              Center(
                child: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 250),
                  child: Text(
                    score.toString(),
                    key: ValueKey(score),
                    style: AppTextStyles.font20Bold.copyWith(
                      color: context.customColors.textPrimary,
                    ),
                  ),
                ),
              ),
              const Spacer(),
              _buildControlButton(
                context: context,
                icon: Icons.add_rounded,
                isEnabled: isIncrementEnabled,
                onTap: () {
                  if (isWinner) {
                    context.read<AddMatchCubit>().updateWinnerScore(1);
                  } else {
                    context.read<AddMatchCubit>().updateLoserScore(1);
                  }
                },
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildControlButton({
    required final BuildContext context,
    required final IconData icon,
    required final bool isEnabled,
    required final VoidCallback onTap,
  }) {
    return InkWell(
      borderRadius: BorderRadius.circular(12),
      onTap: isEnabled ? onTap : null,
      child: AnimatedScale(
        scale: isEnabled ? 1.0 : 0.95,
        duration: const Duration(milliseconds: 150),
        child: Container(
          height: responsiveHeight(36),
          width: responsiveWidth(36),
          decoration: BoxDecoration(
            color: isEnabled
                ? accentColor.withValues(alpha: 0.3)
                : accentColor.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(
            icon,
            size: responsiveFontSize(24),
            color: isEnabled
                ? context.customColors.textPrimary
                : context.customColors.textSecondary.withValues(alpha: 0.4),
          ),
        ),
      ),
    );
  }
}
