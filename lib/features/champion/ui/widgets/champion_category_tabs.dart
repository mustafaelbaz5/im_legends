import 'package:flutter/material.dart';
import '../../../../core/themes/app_colors.dart';
import '../../../../core/themes/app_texts_style.dart';
import '../../../../core/utils/extensions/context_extensions.dart';
import '../../../../core/utils/spacing.dart';
import '../../data/model/champion_player_model.dart';

class ChampionCategoryTabs extends StatelessWidget {
  final StatCategory selected;
  final ValueChanged<StatCategory> onSelected;

  static const _tabs = StatCategory.values;

  const ChampionCategoryTabs({
    super.key,
    required this.selected,
    required this.onSelected,
  });

  @override
  Widget build(final BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: EdgeInsets.symmetric(
        horizontal: responsiveWidth(16),
        vertical: responsiveHeight(8),
      ),
      child: Row(
        children: _tabs.map((final tab) {
          final isSelected = tab == selected;
          return Padding(
            padding: const EdgeInsets.only(right: 8),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              curve: Curves.easeInOut,
              child: GestureDetector(
                onTap: () => onSelected(tab),
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: responsiveWidth(16),
                    vertical: responsiveHeight(8),
                  ),
                  decoration: BoxDecoration(
                    color: isSelected
                        ? AppColors.primary400
                        : context.customColors.background,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    tab.label,
                    style: AppTextStyles.font12Regular.copyWith(
                      color: isSelected
                          ? AppColors.grey0
                          : context.customColors.textPrimary,
                    ),
                  ),
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
