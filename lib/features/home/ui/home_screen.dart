import 'package:flutter/material.dart';
import 'package:im_legends/core/themes/app_texts_style.dart';
import 'package:im_legends/core/utils/extensions/context_extensions.dart';

import '../../../core/utils/functions/refresh_page.dart';
import '../../../core/utils/spacing.dart';
import 'widgets/home_app_bar.dart';
import 'widgets/home_header_container.dart';
import 'widgets/leader_board_list_view.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(final BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          const HomeAppBar(title: 'Mustafa'),
          verticalSpacing(8),
          Expanded(
            child: RefreshIndicator(
              onRefresh: () => refreshData(context),
              backgroundColor: context.customColors.background,
              color: context.customColors.textPrimary,
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: responsiveWidth(8)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const HomeHeaderContainer(),
                      verticalSpacing(8),
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: responsiveWidth(8),
                        ),
                        child: Text(
                          'Leaderboard',
                          style: AppTextStyles.font20Bold,
                        ),
                      ),
                      verticalSpacing(16),

                      const LeadBoardListView(),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
