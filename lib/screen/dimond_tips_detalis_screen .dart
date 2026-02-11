import 'package:flutter/material.dart';

import 'package:fff_skin_tools/common/Ads/ads_card.dart';
import 'package:fff_skin_tools/common/common_app_bar/common_app_bar.dart';
import 'package:fff_skin_tools/common/common_button/common_button.dart';
import 'package:fff_skin_tools/common/global_wrapper.dart';

import 'package:fff_skin_tools/constants/app_colors.dart';
import 'package:fff_skin_tools/constants/app_style.dart';
import 'package:fff_skin_tools/constants/static_decoration.dart';

import 'package:fff_skin_tools/model/home_item_model.dart';

class DimondTipsDetalis extends StatelessWidget {
  final HomeItemModel item;

  const DimondTipsDetalis({
    super.key,
    required this.item,
  });

  @override
  Widget build(BuildContext context) {
    return GlobalWrapper(
      child: CommonWillPopScope(
        child: Scaffold(
          backgroundColor: AppColors.background,

          /// -------------------- APP BAR --------------------
          appBar: CommonAppBar(
            title: item.title,
            showBackButton: true,
          ),

          /// -------------------- BOTTOM AD --------------------
          bottomNavigationBar: const BanerAdsScreen(),

          /// -------------------- BODY --------------------
          body: ListView(
            padding: const EdgeInsets.all(16),
            children: [
              /// TOP BANNER AD
              const BanerAdsScreen(),

              height25,

              /// CONTENT CARD
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: AppColors.card,
                  borderRadius: BorderRadius.circular(18),
                  border: Border.all(color: AppColors.divider),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.15),
                      blurRadius: 14,
                      offset: const Offset(0, 8),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    /// TITLE (CENTERED)
                    Text(
                      item.title,
                      textAlign: TextAlign.center,
                      style: AppTextStyle.bold16.copyWith(
                        color: AppColors.textPrimary,
                        height: 1.3,
                      ),
                    ),

                    height10,

                    /// DIVIDER
                    Container(
                      height: 3,
                      width: 40,
                      decoration: BoxDecoration(
                        color: AppColors.primary,
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),

                    height16,

                    /// DESCRIPTION (CENTERED & READABLE)
                    if (item.subTitle != null)
                      Text(
                        item.subTitle!,
                        textAlign: TextAlign.center,
                        style: AppTextStyle.regular14.copyWith(
                          color: AppColors.textSecondary,
                          height: 1.6,
                        ),
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
