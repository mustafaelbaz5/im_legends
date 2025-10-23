import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/utils/spacing.dart';
import 'states_column.dart';

class StatesSection extends StatelessWidget {
  const StatesSection({
    super.key,
    required this.Match,
    required this.goalDifference,
  });
  final int Match;
  final int goalDifference;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.r),
        color: Colors.black.withAlpha((0.2 * 255).toInt()),
      ),
      child: Row(
        children: [
          StatesColumn(
            label: 'Matches',
            value: Match,
            icon: Icons.sports_esports,
          ),
          horizontalSpacing(8),
          StatesColumn(
            label: 'Goals',
            value: goalDifference,
            icon: Icons.sports_soccer,
          ),
        ],
      ),
    );
  }
}
