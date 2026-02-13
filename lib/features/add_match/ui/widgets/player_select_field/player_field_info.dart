import 'package:flutter/material.dart';

import '../../../../../core/themes/app_texts_style.dart';

class PlayerFieldInfo extends StatelessWidget {
  final String? selectedPlayer;
  final String hint;

  const PlayerFieldInfo({super.key, this.selectedPlayer, required this.hint});

  @override
  Widget build(final BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        AnimatedDefaultTextStyle(
          duration: const Duration(milliseconds: 300),
          style: selectedPlayer != null
              ? AppTextStyles.font14SemiBold
              : AppTextStyles.font14Regular,
          child: Text(
            selectedPlayer ?? hint,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}
