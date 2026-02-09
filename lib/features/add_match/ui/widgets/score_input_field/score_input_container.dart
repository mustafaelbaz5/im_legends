import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/utils/spacing.dart';
import 'score_control_button.dart';
import 'score_count_animations.dart';

class ScoreInputContainer extends StatefulWidget {
  const ScoreInputContainer({
    super.key,
    required this.accentColor,
    required this.initialScore,
    required this.minScore,
    required this.maxScore,
    this.onScoreChanged,
    this.label,
    required this.isEditable,
  });

  final int initialScore;
  final int minScore;
  final int maxScore;
  final void Function(int)? onScoreChanged;
  final String? label;
  final bool isEditable;
  final Color accentColor;

  @override
  State<ScoreInputContainer> createState() => _ScoreInputContainerState();
}

class _ScoreInputContainerState extends State<ScoreInputContainer>
    with TickerProviderStateMixin {
  late ScoreFieldAnimations animations;
  late int currentScore;

  @override
  void initState() {
    super.initState();
    currentScore = widget.initialScore;

    // setup animations
    animations = ScoreFieldAnimations(vsync: this);

    // optional: auto-start glow if editable
    if (widget.isEditable) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) animations.startGlow();
      });
    }
  }

  @override
  void dispose() {
    animations.dispose();
    super.dispose();
  }

  void _incrementScore() {
    if (!widget.isEditable || currentScore >= widget.maxScore) return;
    setState(() => currentScore++);
    widget.onScoreChanged?.call(currentScore);

    animations.bumpScore(); // 🎉 trigger pop animation
  }

  void _decrementScore() {
    if (!widget.isEditable || currentScore <= widget.minScore) return;
    setState(() => currentScore--);
    widget.onScoreChanged?.call(currentScore);

    animations.bumpScore();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 16.w),
      decoration: BoxDecoration(
        color: const Color(0xFF1E1E2C),
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(
          color: widget.accentColor.withAlpha((0.4 * 255).toInt()),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha((0.4 * 255).toInt()),
            blurRadius: 6,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          ScoreControlButton(
            icon: Icons.remove_rounded,
            onTap: _decrementScore,
            isEnabled: currentScore > widget.minScore,
            accentColor: widget.accentColor,
          ),
          horizontalSpacing(10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (widget.label != null)
                  Text(
                    widget.label!,
                    style: TextStyle(
                      color: Colors.white.withAlpha((0.7 * 255).toInt()),
                      fontSize: 12.sp,
                    ),
                  ),
                SizedBox(height: 4.h),
                Text(
                  currentScore.toString(),
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 26.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          horizontalSpacing(10),
          ScoreControlButton(
            icon: Icons.add_rounded,
            onTap: _incrementScore,
            isEnabled: currentScore < widget.maxScore,
            accentColor: widget.accentColor,
          ),
        ],
      ),
    );
  }
}
