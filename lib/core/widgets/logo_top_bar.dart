import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../themes/app_texts_style.dart';
import '../utils/app_assets.dart';

class LogoTopBar extends StatelessWidget {
  const LogoTopBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Logo with subtle glow effect
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: const RadialGradient(
                colors: [Color(0xFF2A3441), Color(0xFF1E2832)],
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withAlpha((0.3 * 255).toInt()),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: SvgPicture.asset(
              AppAssets.appSvgLogo,
              height: 32.h,
              width: 32.w,
            ),
          ),

          const SizedBox(width: 12),

          // App name with gradient text
          ShaderMask(
            shaderCallback: (bounds) => const LinearGradient(
              colors: [Colors.white, Color(0xFFE8E8E8)],
            ).createShader(bounds),
            child: Text('IM Legends', style: FederantTextStyles.whiteBold20),
          ),
        ],
      ),
    );
  }
}
