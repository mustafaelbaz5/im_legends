import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/themes/app_colors.dart';

import '../../../../core/themes/app_texts_style.dart';
import '../../../../core/utils/spacing.dart';

class StatesColumn extends StatelessWidget {
  const StatesColumn({
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
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 16.sp, color: AppColors.goldColor),
            horizontalSpacing(4),
            Text(
              '$value',
              style: BebasTextStyles.whiteBold14,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
        verticalSpacing(2),
        Text(label, style: RobotoTextStyles.greyRegular12),
      ],
    );
  }
}
