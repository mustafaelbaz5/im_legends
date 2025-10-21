import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/themes/app_colors.dart';
import '../../../core/utils/functions/refresh_page.dart';
import '../../../core/widgets/custom_app_bar.dart';
import '../logic/cubit/match_history_cubit.dart';
import 'widgets/history_list_card.dart';
import 'widgets/history_shimmer_loading.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const CustomAppBar(title: 'History'),
          Expanded(
            child: BlocBuilder<MatchHistoryCubit, MatchHistoryState>(
              builder: (context, state) {
                if (state is MatchHistoryLoading) {
                  return const HistoryShimmerLoading();
                } else if (state is MatchHistorySuccess) {
                  final matches = state.matches;
                  return RefreshIndicator(
                    onRefresh: () => onRefresh(context),
                    backgroundColor: AppColors.lightDarkColor,
                    color: Colors.white,
                    child: ListView.builder(
                      padding: const EdgeInsets.all(16),
                      itemCount: matches.length,
                      itemBuilder: (context, index) =>
                          HistoryListCard(match: matches[index]),
                    ),
                  );
                } else {
                  return const Center(child: Text('No data available'));
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
