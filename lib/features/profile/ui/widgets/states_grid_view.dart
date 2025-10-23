import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'state_card.dart';

class StatsGridView extends StatelessWidget {
  final List<Map<String, dynamic>> stats;

  const StatsGridView({super.key, required this.stats});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 6.h),
      child: GridView.builder(
        itemCount: stats.length,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          mainAxisSpacing: 12.h,
          crossAxisSpacing: 12.w,
          childAspectRatio: 0.9,
        ),
        itemBuilder: (context, index) {
          final stat = stats[index];
          return StateCard(
            label: stat['label'] as String,
            value: stat['value'],
            icon: stat['icon'] as IconData,
          );
        },
      ),
    );
  }
}
