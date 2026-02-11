// ignore_for_file: use_build_context_synchronously

import 'package:fff_skin_tools/screen/dimond_tips_detalis_screen%20.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:fff_skin_tools/common/Ads/ads_card.dart';
import 'package:fff_skin_tools/common/common_app_bar/common_app_bar.dart';
import 'package:fff_skin_tools/common/common_button/common_button.dart';
import 'package:fff_skin_tools/common/global_wrapper.dart';

import 'package:fff_skin_tools/constants/app_colors.dart';
import 'package:fff_skin_tools/constants/app_style.dart';

import '../Provider/home_provider.dart';

class DimondTips extends StatelessWidget {
  const DimondTips({super.key});

  Color _accent(int index) {
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
            title: "Diamond Tips & Tricks",
            showBackButton: true,
          ),

          /// ---------------- BODY ----------------
          body: ChangeNotifierProvider(
            create: (_) => HomeProvider(),
            builder: (context, _) {
              final tips = context.read<HomeProvider>().dimondTips;

              return ListView.builder(
                padding: const EdgeInsets.fromLTRB(16, 20, 16, 24),
                itemCount: tips.length + (tips.length ~/ 2),
                itemBuilder: (context, index) {
                  /// AD AFTER EVERY 2 CARDS
                  if ((index + 1) % 3 == 0) {
                    return const Padding(
                      padding: EdgeInsets.symmetric(vertical: 16),
                      child: NativeAdsScreen(),
                    );
                  }

                  final itemIndex = index - (index ~/ 3);
                  final tip = tips[itemIndex];

                  return Column(
                    children: [
                      _DiamondTipHeroCard(
                        title: tip.title,
                        accentColor: _accent(itemIndex),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => DimondTipsDetalis(item: tip),
                            ),
                          );
                        },
                      ),
                      const SizedBox(height: 18),
                    ],
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }
}

class _DiamondTipHeroCard extends StatelessWidget {
  final String title;
  final Color accentColor;
  final VoidCallback onTap;

  const _DiamondTipHeroCard({
    required this.title,
    required this.accentColor,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 120,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(22),
          color: const Color(0xFF2C2466),
        ),
        child: Stack(
          children: [
            /// LEFT ACCENT BAR
            Positioned(
              left: 0,
              top: 30,
              bottom: 30,
              child: Container(
                width: 5,
                decoration: BoxDecoration(
                  color: accentColor,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),

            /// RIGHT ACCENT BAR
            Positioned(
              right: 0,
              top: 30,
              bottom: 30,
              child: Container(
                width: 5,
                decoration: BoxDecoration(
                  color: accentColor,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),

            /// CONTENT
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18),
              child: Row(
                children: [
                  /// LEFT ICON (fixed width)
                  SizedBox(
                    width: 64,
                    child: Container(
                      height: 64,
                      decoration: BoxDecoration(
                        color: accentColor.withOpacity(0.15),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Icon(
                        Icons.lightbulb_rounded,
                        color: accentColor,
                        size: 34,
                      ),
                    ),
                  ),

                  /// CENTER TITLE (true center)
                  Expanded(
                    child: Center(
                      child: Text(
                        title,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.center,
                        style: AppTextStyle.semiBold14.copyWith(
                          color: AppColors.white,
                          height: 1.3,
                        ),
                      ),
                    ),
                  ),

                  /// RIGHT PLACEHOLDER (same width as left)
                  const SizedBox(
                    width: 64,
                    child: Icon(
                      Icons.arrow_forward_ios_rounded,
                      size: 16,
                      color: Colors.white54,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
