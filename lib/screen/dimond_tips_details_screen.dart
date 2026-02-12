import 'package:fff_skin_tools/common/modern_ui.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:fff_skin_tools/common/Ads/ads_card.dart';
import 'package:fff_skin_tools/common/global_wrapper.dart';

import 'package:fff_skin_tools/constants/app_colors.dart';
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
      child: Scaffold(
        body: Stack(
          children: [
            // Background Gradient
            Positioned.fill(
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      AppColors.primary.withOpacity(0.05),
                      AppColors.darkBackground,
                    ],
                  ),
                ),
              ),
            ),

            CustomScrollView(
              physics: const BouncingScrollPhysics(),
              slivers: [
                // --- PREMIUM APP BAR ---
                SliverAppBar(
                  expandedHeight: 120.0,
                  floating: false,
                  pinned: true,
                  backgroundColor: AppColors.darkBackground,
                  leading: IconButton(
                    icon: const Icon(Icons.arrow_back_ios_new_rounded,
                        color: AppColors.white, size: 20),
                    onPressed: () => Navigator.pop(context),
                  ),
                  flexibleSpace: FlexibleSpaceBar(
                    title: Text(
                      "TIP ANALYSIS",
                      style: GoogleFonts.outfit(
                        fontWeight: FontWeight.w800,
                        color: AppColors.white,
                        fontSize: 16,
                        letterSpacing: 1.5,
                      ),
                    ),
                    centerTitle: true,
                  ),
                ),

                SliverPadding(
                  padding: const EdgeInsets.fromLTRB(20, 10, 20, 100),
                  sliver: SliverList(
                    delegate: SliverChildListDelegate([
                      const BanerAdsScreen(),
                      const SizedBox(height: 24),
                      ModernGlassCard(
                        padding: const EdgeInsets.all(28),
                        child: Column(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: AppColors.primary.withOpacity(0.1),
                              ),
                              child: const Icon(
                                Icons.tips_and_updates_rounded,
                                color: AppColors.primary,
                                size: 40,
                              ),
                            ),
                            const SizedBox(height: 28),
                            Text(
                              item.title,
                              textAlign: TextAlign.center,
                              style: GoogleFonts.outfit(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                                color: AppColors.white,
                                height: 1.2,
                              ),
                            ),
                            const SizedBox(height: 16),
                            Container(
                              height: 3,
                              width: 60,
                              decoration: BoxDecoration(
                                gradient: AppColors.primaryGradient,
                                borderRadius: BorderRadius.circular(2),
                              ),
                            ),
                            const SizedBox(height: 32),
                            if (item.subTitle != null)
                              Text(
                                item.subTitle!,
                                textAlign: TextAlign.center,
                                style: GoogleFonts.outfit(
                                  fontSize: 16,
                                  color: AppColors.darkTextSecondary,
                                  height: 1.6,
                                  letterSpacing: 0.3,
                                ),
                              ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 40),
                      const NativeAdsScreen(),
                    ]),
                  ),
                ),
              ],
            ),
          ],
        ),
        bottomNavigationBar: const BanerAdsScreen(),
      ),
    );
  }
}
