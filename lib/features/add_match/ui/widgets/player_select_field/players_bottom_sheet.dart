import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../logic/cubit/add_match_cubit.dart';
import 'player_tile.dart';
import '../../../../../core/themes/app_texts_style.dart';

class PlayerBottomSheet extends StatefulWidget {
  final String? selectedPlayer;
  final void Function(String id, String name, String imageUrl) onSelect;
  final String? excludedPlayer;

  const PlayerBottomSheet({
    super.key,
    required this.selectedPlayer,
    required this.onSelect,
    this.excludedPlayer,
  });

  @override
  State<PlayerBottomSheet> createState() => _PlayerBottomSheetState();
}

class _PlayerBottomSheetState extends State<PlayerBottomSheet> {
  @override
  void initState() {
    super.initState();
    context.read<AddMatchCubit>().getPlayersList();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.6,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Color(0xFF1A1D26), Color(0xFF141620)],
        ),
        borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha((0.6 * 255).toInt()),
            blurRadius: 24,
            offset: const Offset(0, -8),
          ),
        ],
      ),
      child: Column(
        children: [
          _buildHandleBar(),
          _buildHeader(),
          Expanded(
            child: BlocBuilder<AddMatchCubit, AddMatchState>(
              builder: (context, state) {
                if (state is AddMatchLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is AddMatchFailure) {
                  return _buildError(state.error);
                } else if (state is AddMatchPlayersSuccess) {
                  final filteredPlayers = state.players
                      .where((p) => p['id'] != widget.excludedPlayer)
                      .map(
                        (p) => {
                          'id': p['id'] as String,
                          'name': p['name'] as String,
                          'profile_image': p['profile_image'] as String? ?? '',
                        },
                      )
                      .toList();

                  if (filteredPlayers.isEmpty) {
                    return _buildEmpty();
                  }

                  return ListView.builder(
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    itemCount: filteredPlayers.length,
                    itemBuilder: (context, index) {
                      final player = filteredPlayers[index];
                      final isSelected = widget.selectedPlayer == player['id'];

                      return PlayerTile(
                        playerName: player['name'] as String,
                        isSelected: isSelected,
                        index: index,
                        playerImage: player['profile_image'] ?? '',
                        playerId: player['id'] as String,
                        onSelect: (selectedId, selectedName, selectedImage) {
                          widget.onSelect(
                            selectedId,
                            selectedName,
                            selectedImage,
                          );
                          Navigator.pop(context);
                        },
                      );
                    },
                  );
                }
                return const SizedBox.shrink();
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHandleBar() => Container(
    margin: EdgeInsets.only(top: 12.h),
    width: 40.w,
    height: 4.h,
    decoration: BoxDecoration(
      color: Colors.white.withAlpha((0.15 * 255).toInt()),
      borderRadius: BorderRadius.circular(2.r),
    ),
  );

  Widget _buildHeader() => Padding(
    padding: EdgeInsets.all(20.w),
    child: Row(
      children: [
        Icon(Icons.sports_esports_rounded, color: Colors.blue, size: 24.sp),
        SizedBox(width: 12.w),
        Text('Choose Player', style: BebasTextStyles.whiteBold20),
        const Spacer(),
        BlocBuilder<AddMatchCubit, AddMatchState>(
          builder: (context, state) {
            if (state is AddMatchPlayersSuccess) {
              final filteredCount = state.players
                  .map((p) => p['id'] as String)
                  .where((id) => id != widget.excludedPlayer)
                  .length;
              return Text(
                '$filteredCount players',
                style: TextStyle(
                  color: Colors.white.withAlpha((0.6 * 255).toInt()),
                  fontSize: 12.sp,
                ),
              );
            }
            return const SizedBox.shrink();
          },
        ),
      ],
    ),
  );

  Widget _buildError(String error) => Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(Icons.error_outline, color: Colors.red, size: 48.sp),
        SizedBox(height: 16.h),
        Text(
          'Error loading players',
          style: TextStyle(color: Colors.red, fontSize: 16.sp),
        ),
        SizedBox(height: 8.h),
        Text(
          error,
          style: TextStyle(color: Colors.white, fontSize: 14.sp),
          textAlign: TextAlign.center,
        ),
      ],
    ),
  );

  Widget _buildEmpty() => Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          Icons.person_off_outlined,
          color: Colors.white.withAlpha((0.4 * 255).toInt()),
          size: 48.sp,
        ),
        SizedBox(height: 16.h),
        Text(
          'No players available',
          style: TextStyle(
            color: Colors.white.withAlpha((0.6 * 255).toInt()),
            fontSize: 16.sp,
          ),
        ),
      ],
    ),
  );
}
