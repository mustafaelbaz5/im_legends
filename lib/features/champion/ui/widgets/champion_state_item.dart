import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/themes/app_colors.dart';
import '../../../../core/themes/app_texts_style.dart';

class ChampionStateItem extends StatelessWidget {
  const ChampionStateItem({
    super.key,
    required this.label,
    required this.value,
    required this.icon,
  });
  final String label;
  final int value;
  final IconData icon;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          padding: EdgeInsets.all(8.w),
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: AppColors.darkRedColor,
          ),
          child: Icon(icon, size: 24.sp, color: Colors.white),
        ),
        SizedBox(height: 8.h),
        Text('$value', style: RobotoTextStyles.whiteBold24),
        SizedBox(height: 4.h),
        Text(label, style: BebasTextStyles.whiteBold14),
      ],
    );
  }
}
