import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/themes/app_colors.dart';
import 'score_count_animations.dart';
import 'score_input_container.dart';

class ScoreCountField extends StatefulWidget {
  final int initialScore;
  final int minScore;
  final int maxScore;
  final void Function(int)? onScoreChanged;
  final String? label;
  final bool isEditable;
  final Color? accentColor;

  const ScoreCountField({
    super.key,
    this.initialScore = 0,
    this.minScore = 0,
    this.maxScore = 100,
    this.onScoreChanged,
    this.label,
    this.isEditable = true,
    this.accentColor,
  });

  @override
  State<ScoreCountField> createState() => _ScoreCountFieldState();
}

class _ScoreCountFieldState extends State<ScoreCountField>
    with TickerProviderStateMixin {
  late int currentScore;
  late ScoreFieldAnimations animations;

  Color get accentColor => widget.accentColor ?? AppColors.darkRedColor;

  @override
  void initState() {
    super.initState();

    currentScore = widget.initialScore;

    // 1. Create the animations helper
    animations = ScoreFieldAnimations(vsync: this);

    // 2. Start any animations AFTER the first frame
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        animations.startGlow(); // or animations.startScaleDown(), etc.
      }
    });
  }

  @override
  void dispose() {
    animations.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 16.w),
      child: AnimatedBuilder(
        animation: Listenable.merge([
          animations.scaleAnimation,
          animations.glowAnimation,
          animations.scoreChangeAnimation,
        ]),
        builder: (context, child) {
          return Transform.scale(
            scale:
                animations.scaleAnimation.value +
                (animations.scoreChangeAnimation.value * 0.05),
            child: ScoreInputContainer(
              accentColor: accentColor,
              initialScore: widget.initialScore,
              minScore: widget.minScore,
              maxScore: widget.maxScore,
              isEditable: widget.isEditable,
              onScoreChanged: widget.onScoreChanged,
            ),
          );
        },
      ),
    );
  }
}
