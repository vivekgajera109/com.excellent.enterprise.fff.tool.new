// ignore_for_file: use_build_context_synchronously

import 'package:fff_skin_tools/common/modern_ui.dart';
import 'package:fff_skin_tools/screen/dimond_tips_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'package:fff_skin_tools/common/Ads/ads_card.dart';
import 'package:fff_skin_tools/common/common_button/common_button.dart';
import 'package:fff_skin_tools/common/global_wrapper.dart';

import 'package:fff_skin_tools/constants/app_colors.dart';
import 'package:fff_skin_tools/provider/home_provider.dart';

class DimondTips extends StatelessWidget {
  const DimondTips({super.key});

  @override
  Widget build(BuildContext context) {
    return GlobalWrapper(
      child: Scaffold(
        body: ChangeNotifierProvider(
          create: (_) => HomeProvider(),
          builder: (context, _) {
            final tips = context.read<HomeProvider>().dimondTips;

            return CustomScrollView(
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
                      "EXPERT TIPS",
                      style: GoogleFonts.outfit(
                        fontWeight: FontWeight.w800,
                        color: AppColors.white,
                        fontSize: 18,
                        letterSpacing: 1.5,
                      ),
                    ),
                    centerTitle: true,
                    background: Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            AppColors.primary.withOpacity(0.4),
                            AppColors.darkBackground,
                          ],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                        ),
                      ),
                    ),
                  ),
                ),

                // --- CONTENT LIST ---
                SliverPadding(
                  padding: const EdgeInsets.fromLTRB(20, 10, 20, 40),
                  sliver: SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        if ((index + 1) % 3 == 0) {
                          return const Padding(
                            padding: EdgeInsets.symmetric(vertical: 24),
                            child: NativeAdsScreen(),
                          );
                        }

                        final itemIndex = index - (index ~/ 3);
                        if (itemIndex >= tips.length) return null;

                        final tip = tips[itemIndex];

                        return Padding(
                          padding: const EdgeInsets.only(bottom: 20),
                          child: ModernGlassCard(
                            padding: EdgeInsets.zero,
                            child: ListTile(
                              contentPadding: const EdgeInsets.all(20),
                              onTap: () async {
                                await CommonOnTap.openUrl();
                                await Future.delayed(
                                    const Duration(milliseconds: 600));
                                if (!context.mounted) return;
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) =>
                                        DimondTipsDetalis(item: tip),
                                  ),
                                );
                              },
                              leading: Container(
                                padding: const EdgeInsets.all(12),
                                decoration: BoxDecoration(
                                  gradient: AppColors.primaryGradient
                                      .withOpacity(0.15),
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                child: const Icon(
                                  Icons.tips_and_updates_rounded,
                                  color: AppColors.primary,
                                  size: 28,
                                ),
                              ),
                              title: Text(
                                tip.title,
                                style: GoogleFonts.outfit(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 17,
                                  color: AppColors.white,
                                ),
                              ),
                              subtitle: Padding(
                                padding: const EdgeInsets.only(top: 8),
                                child: Text(
                                  "Tap to unlock secret strategies",
                                  style: GoogleFonts.outfit(
                                    fontSize: 13,
                                    color: AppColors.darkTextSecondary,
                                  ),
                                ),
                              ),
                              trailing: Container(
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  color: AppColors.white.withOpacity(0.05),
                                  shape: BoxShape.circle,
                                ),
                                child: const Icon(
                                  Icons.chevron_right_rounded,
                                  color: AppColors.primary,
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                      childCount: tips.length + (tips.length ~/ 2),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
        bottomNavigationBar: const BanerAdsScreen(),
      ),
    );
  }
}
