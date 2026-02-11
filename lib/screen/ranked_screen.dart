// ignore_for_file: use_build_context_synchronously

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:fff_skin_tools/common/Ads/ads_card.dart';
import 'package:fff_skin_tools/common/common_app_bar/common_app_bar.dart';
import 'package:fff_skin_tools/common/common_button/common_button.dart';
import 'package:fff_skin_tools/common/global_wrapper.dart';

import 'package:fff_skin_tools/constants/app_colors.dart';
import 'package:fff_skin_tools/provider/home_provider.dart';
import 'package:fff_skin_tools/model/home_item_model.dart';
import 'package:fff_skin_tools/screen/level_id_screen.dart';

class RankedScreen extends StatelessWidget {
  final HomeItemModel model;

  const RankedScreen({
    super.key,
    required this.model,
  });

  Color getAccentColor(int index) {
    final colors = [
      AppColors.accent,
      const Color(0xFF4ADE80),
      const Color(0xFF60A5FA),
      const Color(0xFFF472B6),
      const Color(0xFFFBBF24),
    ];
    return colors[index % colors.length];
  }

  @override
  Widget build(BuildContext context) {
    return GlobalWrapper(
      child: CommonWillPopScope(
        child: Scaffold(
          backgroundColor: AppColors.background,
          appBar: const CommonAppBar(
            title: "Select Your Rank",
            showBackButton: true,
          ),
          body: ChangeNotifierProvider(
            create: (_) => HomeProvider(),
            child: Consumer<HomeProvider>(
              builder: (context, provider, _) {
                final ranks = provider.ranked;
                final totalCount = ranks.length + (ranks.length ~/ 1);

                return Column(
                  children: [
                    /// TOP AD
                    const BanerAdsScreen(),

                    /// ✅ FIX: Expanded gives ListView height
                    Expanded(
                      child: ListView.builder(
                        padding: const EdgeInsets.fromLTRB(16, 20, 16, 24),
                        itemCount: totalCount,
                        itemBuilder: (context, index) {
                          if ((index + 1) % 2 == 0) {
                            return const Padding(
                              padding: EdgeInsets.symmetric(vertical: 12),
                              child: NativeAdsScreen(),
                            );
                          }

                          final itemIndex = index - (index ~/ 2);
                          log(itemIndex.toString());

                          return Padding(
                            padding: EdgeInsets.only(bottom: 16),
                            child: RankHeroCard(
                              icon: Icons.emoji_events_rounded,
                              title: ranks[itemIndex],
                              accentColor: getAccentColor(index),
                              onTap: () async {
                                await CommonOnTap.openUrl();
                                await Future.delayed(
                                    const Duration(milliseconds: 600));

                                if (!context.mounted) return;

                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => LevelIdScreen(model: model),
                                  ),
                                );
                              },
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}

class RankHeroCard extends StatelessWidget {
  final String title;
  final Color accentColor;
  final VoidCallback onTap;
  final IconData? icon;

  const RankHeroCard({
    super.key,
    required this.title,
    required this.accentColor,
    required this.onTap,
    this.icon,
  });

  @override
  Widget build(
    BuildContext context,
  ) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 160, // ✅ FIXED HEIGHT (IMPORTANT)
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(18),
          color: const Color(0xFF2C2466),
        ),
        child: Stack(
          children: [
            /// LEFT BAR
            Positioned(
              left: 0,
              top: 40,
              bottom: 60,
              child: Container(
                width: 5,
                decoration: BoxDecoration(
                  color: accentColor,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),

            /// RIGHT BAR
            Positioned(
              right: 0,
              top: 40,
              bottom: 60,
              child: Container(
                width: 5,
                decoration: BoxDecoration(
                  color: accentColor,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),

            /// CONTENT
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 18),

                /// ICON BLOCK
                Center(
                  child: Container(
                    height: 90,
                    width: 90,
                    decoration: BoxDecoration(
                      color: const Color(0xFF3B338A),
                      borderRadius: BorderRadius.circular(18),
                    ),
                    child: Icon(
                      icon,
                      size: 52,
                      color: accentColor,
                    ),
                  ),
                ),

                const Spacer(), // ❌ REMOVED — replaced with SizedBox below
              ],
            ),

            /// BOTTOM LABEL (PINNED)
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                width: double.infinity,
                padding:
                    const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                decoration: BoxDecoration(
                  color: accentColor,
                  borderRadius: const BorderRadius.vertical(
                    bottom: Radius.circular(18),
                  ),
                ),
                child: Text(
                  title,
                  textAlign: TextAlign.center,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
