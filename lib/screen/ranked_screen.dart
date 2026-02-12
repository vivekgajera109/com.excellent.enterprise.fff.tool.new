// ignore_for_file: use_build_context_synchronously

import 'package:fff_skin_tools/common/modern_ui.dart';
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

  @override
  Widget build(BuildContext context) {
    return GlobalWrapper(
      child: CommonWillPopScope(
        child: Scaffold(
          appBar: const CommonAppBar(
            title: "Player Rank",
            showBackButton: true,
          ),
          body: Stack(
            children: [
              // --- DECORATIVE BACKGROUND ---
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                height: 300,
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                      colors: [
                        AppColors.primary.withOpacity(0.05),
                        AppColors.transparent,
                      ],
                    ),
                  ),
                ),
              ),

              ChangeNotifierProvider(
                create: (_) => HomeProvider(),
                child: Consumer<HomeProvider>(
                  builder: (context, provider, _) {
                    final ranks = provider.ranked;

                    return ListView.builder(
                      padding: const EdgeInsets.fromLTRB(16, 16, 16, 100),
                      itemCount: ranks.length + 1,
                      itemBuilder: (context, index) {
                        if (index == 0) {
                          return const Padding(
                            padding: EdgeInsets.only(bottom: 24),
                            child: BanerAdsScreen(),
                          );
                        }

                        final rankIndex = index - 1;
                        final rank = ranks[rankIndex];

                        // Insert native ads every 3 items
                        bool showNativeAd =
                            (rankIndex != 0 && rankIndex % 3 == 0);

                        return Column(
                          children: [
                            ModernListTile(
                              title: rank,
                              subtitle: "Unlock rewards for this tier",
                              leading: Icon(
                                Icons.emoji_events_rounded,
                                color: _getRankColor(rankIndex),
                                size: 24,
                              ),
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
                            const SizedBox(height: 12),
                            if (showNativeAd) ...[
                              const Padding(
                                padding: EdgeInsets.symmetric(vertical: 12),
                                child: NativeAdsScreen(),
                              ),
                              const SizedBox(height: 12),
                            ],
                          ],
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
          bottomNavigationBar: const BanerAdsScreen(),
        ),
      ),
    );
  }

  Color _getRankColor(int index) {
    const colors = [
      Color(0xFF8B5CF6), // Bronze -> Purple for our theme
      Color(0xFF06B6D4), // Silver -> Cyan
      Color(0xFFF59E0B), // Gold -> Amber
      Color(0xFF10B981), // Platinum -> Emerald
      Color(0xFFEF4444), // Heroic -> Red
    ];
    return colors[index % colors.length];
  }
}
