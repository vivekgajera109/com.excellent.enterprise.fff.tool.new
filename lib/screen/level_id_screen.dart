// ignore_for_file: use_build_context_synchronously

import 'package:fff_skin_tools/common/modern_ui.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:fff_skin_tools/Provider/home_provider.dart';
import 'package:fff_skin_tools/common/Ads/ads_card.dart';
import 'package:fff_skin_tools/common/common_app_bar/common_app_bar.dart';
import 'package:fff_skin_tools/common/common_button/common_button.dart';
import 'package:fff_skin_tools/common/global_wrapper.dart';

import 'package:fff_skin_tools/constants/app_colors.dart';
import 'package:fff_skin_tools/model/home_item_model.dart';
import 'package:fff_skin_tools/screen/select_rank_screen.dart';

class LevelIdScreen extends StatelessWidget {
  final HomeItemModel model;

  const LevelIdScreen({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    return GlobalWrapper(
      child: CommonWillPopScope(
        child: Scaffold(
          appBar: const CommonAppBar(
            title: "Player Level",
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
                    final levels = provider.levelId;

                    return ListView.builder(
                      padding: const EdgeInsets.fromLTRB(16, 16, 16, 100),
                      itemCount: levels.length + 1,
                      itemBuilder: (context, index) {
                        if (index == 0) {
                          return const Padding(
                            padding: EdgeInsets.only(bottom: 24),
                            child: BanerAdsScreen(),
                          );
                        }

                        final levelIndex = index - 1;
                        final level = levels[levelIndex];
                        bool showNativeAd =
                            (levelIndex != 0 && levelIndex % 3 == 0);

                        return Column(
                          children: [
                            ModernListTile(
                              title: level,
                              subtitle: "Standard Level Requirement",
                              leading: Icon(
                                Icons.bar_chart_rounded,
                                color: _getLevelColor(levelIndex),
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
                                    builder: (_) =>
                                        SelectRankScreen(model: model),
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

  Color _getLevelColor(int index) {
    const colors = [
      Color(0xFF60A5FA), // Blue
      Color(0xFF8B5CF6), // Purple
      Color(0xFFF472B6), // Pink
      Color(0xFF10B981), // Emerald
      Color(0xFFFBBF24), // Amber
    ];
    return colors[index % colors.length];
  }
}
