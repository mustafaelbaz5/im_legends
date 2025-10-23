import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/themes/app_colors.dart';
import '../../../../core/utils/functions/date_formate.dart';

class MatchCardHeader extends StatelessWidget {
  final DateTime matchDate;

  const MatchCardHeader({super.key, required this.matchDate});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Text(
            '${formatSmart(matchDate)}',
            style: TextStyle(
              fontSize: 12.sp,
              color: Colors.white,
              fontStyle: FontStyle.italic,
            ),
            textAlign: TextAlign.left,
          ),
        ),
        Icon(Icons.sports_soccer, color: AppColors.greyColor, size: 24.sp),
      ],
    );
  }
}
