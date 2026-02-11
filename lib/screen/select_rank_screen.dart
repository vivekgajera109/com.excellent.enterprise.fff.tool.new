// ignore_for_file: use_build_context_synchronously

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

          /// ---------------- APP BAR ----------------
          appBar: const CommonAppBar(
            title: "Select Your Rank",
            showBackButton: true,
          ),

          /// ---------------- BODY ----------------
          body: ChangeNotifierProvider(
            create: (_) => HomeProvider(),
            child: Consumer<HomeProvider>(
              builder: (context, provider, _) {
                final ranks = provider.selectRankImage;
                final totalGroups = (ranks.length / 4).ceil();

                return Column(
                  children: [
                    const BanerAdsScreen(),
                    Expanded(
                      child: ListView.builder(
                        padding: const EdgeInsets.all(16),
                        itemCount: totalGroups,
                        itemBuilder: (context, groupIndex) {
                          final startIndex = groupIndex * 4;
                          final endIndex = (startIndex + 4 <= ranks.length)
                              ? startIndex + 4
                              : ranks.length;

                          final groupRanks =
                              ranks.sublist(startIndex, endIndex);

                          return Column(
                            children: [
                              GridView.builder(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  crossAxisSpacing: 16,
                                  mainAxisSpacing: 16,
                                  childAspectRatio: 0.85,
                                ),
                                itemCount: groupRanks.length,
                                itemBuilder: (context, index) {
                                  return RankHeroImageCard(
                                    image: groupRanks[index],
                                    accentColor:
                                        getAccentColor(startIndex + index),
                                    onTap: () => _onRankSelected(
                                      context,
                                      model,
                                    ),
                                  );
                                },
                              ),
                              if (groupIndex != totalGroups - 1)
                                const Padding(
                                  padding: EdgeInsets.symmetric(vertical: 16),
                                  child: NativeAdsScreen(),
                                ),
                            ],
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

  /// ---------------- RANK TAP ----------------
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

class RankHeroImageCard extends StatelessWidget {
  final String image;
  final Color accentColor;
  final VoidCallback onTap;

  const RankHeroImageCard({
    super.key,
    required this.image,
    required this.accentColor,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 190,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(22),
          color: const Color(0xFF2C2466),
        ),
        child: Stack(
          children: [
            /// LEFT BAR
            Positioned(
              left: 0,
              top: 45,
              bottom: 45,
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
              top: 45,
              bottom: 45,
              child: Container(
                width: 5,
                decoration: BoxDecoration(
                  color: accentColor,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),

            /// IMAGE BLOCK
            Center(
              child: Container(
                height: 110,
                width: 110,
                decoration: BoxDecoration(
                  color: const Color(0xFF3B338A),
                  borderRadius: BorderRadius.circular(18),
                ),
                padding: const EdgeInsets.all(14),
                child: Image.asset(
                  image,
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
