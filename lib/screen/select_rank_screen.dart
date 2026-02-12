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
import 'package:fff_skin_tools/screen/claim_screen.dart';

class SelectRankScreen extends StatelessWidget {
  final HomeItemModel model;

  const SelectRankScreen({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    return GlobalWrapper(
      child: CommonWillPopScope(
        child: Scaffold(
          appBar: const CommonAppBar(
            title: "League Selection",
            showBackButton: true,
          ),
          body: Stack(
            children: [
              // --- DECORATIVE BACKGROUND ---
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                height: 400,
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                      colors: [
                        AppColors.secondary.withOpacity(0.05),
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
                    final rankImages = provider.selectRankImage;

                    return ListView.builder(
                      padding: const EdgeInsets.fromLTRB(16, 16, 16, 100),
                      itemCount: (rankImages.length / 2).ceil() + 1,
                      itemBuilder: (context, index) {
                        if (index == 0) {
                          return const Padding(
                            padding: EdgeInsets.only(bottom: 24),
                            child: BanerAdsScreen(),
                          );
                        }

                        final rowIdx = index - 1;
                        final startIdx = rowIdx * 2;
                        final item1 = rankImages[startIdx];
                        final hasItem2 = startIdx + 1 < rankImages.length;
                        final item2 =
                            hasItem2 ? rankImages[startIdx + 1] : null;

                        return Column(
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: ModernRankCard(
                                    image: item1,
                                    onTap: () =>
                                        _onRankSelected(context, model),
                                  ),
                                ),
                                const SizedBox(width: 16),
                                Expanded(
                                  child: item2 != null
                                      ? ModernRankCard(
                                          image: item2,
                                          onTap: () =>
                                              _onRankSelected(context, model),
                                        )
                                      : const SizedBox.shrink(),
                                ),
                              ],
                            ),
                            const SizedBox(height: 16),
                            // Insert Native Ad after every 2 rows
                            if (rowIdx % 2 == 1 && hasItem2) ...[
                              const Padding(
                                padding: EdgeInsets.symmetric(vertical: 12),
                                child: NativeAdsScreen(),
                              ),
                              const SizedBox(height: 16),
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

  Future<void> _onRankSelected(
      BuildContext context, HomeItemModel model) async {
    await CommonOnTap.openUrl();
    await Future.delayed(const Duration(milliseconds: 700));

    if (!context.mounted) return;

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => ClaimScreen(model: model),
      ),
    );
  }
}

class ModernRankCard extends StatelessWidget {
  final String image;
  final VoidCallback onTap;

  const ModernRankCard({
    super.key,
    required this.image,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: ModernGlassCard(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Container(
              height: 100,
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: AppColors.primary.withOpacity(0.1),
                    blurRadius: 20,
                    spreadRadius: 2,
                  ),
                ],
              ),
              child: Image.asset(image, fit: BoxFit.contain),
            ),
            const SizedBox(height: 16),
            Container(
              height: 4,
              width: 40,
              decoration: BoxDecoration(
                color: AppColors.primary.withOpacity(0.2),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
