import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/themes/app_colors.dart';
import '../../../logic/cubit/add_match_cubit.dart';
import 'player_field_animations.dart';
import 'player_field_avatar.dart';
import 'player_field_drop_down_arrow.dart';
import 'player_field_info.dart';
import 'players_bottom_sheet.dart';

class PlayerSelectField extends StatefulWidget {
  final void Function(String id)? onSelected;
  final String hint;
  final String? excludedPlayer;

  const PlayerSelectField({
    super.key,
    this.onSelected,
    this.hint = 'Select Player',
    this.excludedPlayer,
  });

  @override
  State<PlayerSelectField> createState() => _PlayerSelectFieldState();
}

class _PlayerSelectFieldState extends State<PlayerSelectField>
    with TickerProviderStateMixin {
  String? selectedPlayerId;
  String? selectedPlayerName;
  String? selectedPlayerImage;
  bool isPressed = false;

  late PlayerFieldAnimations animations;

  @override
  void initState() {
    super.initState();
    animations = PlayerFieldAnimations(vsync: this);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) animations.startGlow();
    });
  }

  @override
  void dispose() {
    animations.dispose();
    super.dispose();
  }

  void _onTapDown() {
    setState(() => isPressed = true);
    animations.scaleController.forward();
  }

  void _onTapUp() {
    setState(() => isPressed = false);
    animations.scaleController.reverse();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 16.w),
      child: GestureDetector(
        onTapDown: (_) => _onTapDown(),
        onTapUp: (_) => _onTapUp(),
        onTapCancel: _onTapUp,
        onTap: () => _showPlayerDialog(context),
        child: AnimatedBuilder(
          animation: Listenable.merge([
            animations.scaleAnimation,
            animations.glowAnimation,
          ]),
          builder: (context, child) => Transform.scale(
            scale: animations.scaleAnimation.value,
            child: _buildFieldContainer(),
          ),
        ),
      ),
    );
  }

  Widget _buildFieldContainer() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      height: 56.h,
      decoration: BoxDecoration(
        color: AppColors.darkColor,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha((0.2 * 255).toInt()),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          PlayerFieldAvatar(
            isSelected: selectedPlayerId != null,
            imageUrl: selectedPlayerImage,
          ),
          SizedBox(width: 16.w),
          PlayerFieldInfo(
            selectedPlayer: selectedPlayerName,
            hint: widget.hint,
          ),
          PlayerFieldDropdownArrow(
            rotationAnimation: animations.rotationAnimation,
            isSelected: selectedPlayerId != null,
          ),
        ],
      ),
    );
  }

  void _showPlayerDialog(BuildContext context) {
    animations.rotationController.forward();
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (dialogContext) => BlocProvider.value(
        value: context.read<AddMatchCubit>(),
        child: PlayerBottomSheet(
          selectedPlayer: selectedPlayerId,
          excludedPlayer: widget.excludedPlayer,
          onSelect: (id, name, imageUrl) => _selectPlayer(id, name, imageUrl),
        ),
      ),
    ).then((_) => animations.rotationController.reverse());
  }

  void _selectPlayer(String id, String name, String imageUrl) {
    setState(() {
      selectedPlayerId = id;
      selectedPlayerName = name;
      selectedPlayerImage = imageUrl;
    });

    widget.onSelected?.call(id);

    animations.glowController.forward().then(
      (_) => animations.glowController.reverse(),
    );
  }
}
