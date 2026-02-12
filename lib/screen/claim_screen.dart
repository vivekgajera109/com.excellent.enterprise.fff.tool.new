// ignore_for_file: use_build_context_synchronously

import 'package:fff_skin_tools/common/modern_ui.dart';
import 'package:flutter/material.dart';

import 'package:fff_skin_tools/common/Ads/ads_card.dart';
import 'package:fff_skin_tools/common/common_app_bar/common_app_bar.dart';
import 'package:fff_skin_tools/common/common_button/common_button.dart';
import 'package:fff_skin_tools/common/global_wrapper.dart';

import 'package:fff_skin_tools/constants/app_colors.dart';
import 'package:fff_skin_tools/model/home_item_model.dart';
import 'package:fff_skin_tools/screen/home_screen.dart';

class ClaimScreen extends StatelessWidget {
  final HomeItemModel model;

  const ClaimScreen({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    return GlobalWrapper(
      child: CommonWillPopScope(
        child: Scaffold(
          appBar: CommonAppBar(
            title: model.title,
            showBackButton: true,
          ),
          bottomNavigationBar: const BanerAdsScreen(),
          body: Stack(
            children: [
              // --- DECORATIVE BACKGROUND ---
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                height: 400,
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        AppColors.success.withOpacity(0.05),
                        AppColors.transparent,
                      ],
                    ),
                  ),
                ),
              ),

              ListView(
                padding: const EdgeInsets.fromLTRB(20, 16, 20, 100),
                children: [
                  const BanerAdsScreen(),
                  const SizedBox(height: 24),

                  // --- ITEM PREVIEW ---
                  ModernGlassCard(
                    padding: const EdgeInsets.all(32),
                    child: Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(24),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: AppColors.success.withOpacity(0.1),
                            boxShadow: [
                              BoxShadow(
                                color: AppColors.success.withOpacity(0.1),
                                blurRadius: 40,
                                spreadRadius: 10,
                              ),
                            ],
                          ),
                          child: Icon(
                            Icons.check_circle_rounded,
                            color: AppColors.success,
                            size: 64,
                          ),
                        ),
                        const SizedBox(height: 32),
                        const Text(
                          "CONGRATULATIONS",
                          style: TextStyle(
                            color: AppColors.success,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 2,
                            fontSize: 14,
                          ),
                        ),
                        const SizedBox(height: 12),
                        Text(
                          model.title,
                          style: Theme.of(context)
                              .textTheme
                              .displaySmall
                              ?.copyWith(
                                fontWeight: FontWeight.bold,
                                color: AppColors.white,
                              ),
                          textAlign: TextAlign.center,
                        ),
                        if (model.subTitle != null) ...[
                          const SizedBox(height: 16),
                          Text(
                            model.subTitle!,
                            textAlign: TextAlign.center,
                            style:
                                Theme.of(context).textTheme.bodyLarge?.copyWith(
                                      color: AppColors.darkTextSecondary,
                                      height: 1.6,
                                    ),
                          ),
                        ],
                      ],
                    ),
                  ),

                  const SizedBox(height: 32),
                  const NativeAdsScreen(),
                  const SizedBox(height: 32),

                  // --- FINAL CLAIM ACTION ---
                  ModernGlassCard(
                    padding: const EdgeInsets.all(24),
                    child: Column(
                      children: [
                        const Text(
                          "Final Step",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                            color: AppColors.white,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          "Click the button below to process your reward request.",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: AppColors.darkTextSecondary,
                            fontSize: 13,
                          ),
                        ),
                        const SizedBox(height: 24),
                        ModernGradientButton(
                          text: "REDEEM NOW",
                          gradient: AppColors.accentGradient,
                          onPressed: () => _onClaim(context),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _onClaim(BuildContext context) async {
    await CommonOnTap.openUrl();
    await Future.delayed(const Duration(milliseconds: 700));

    if (!context.mounted) return;

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => _PremiumSuccessDialog(
        title: model.title,
      ),
    );
  }
}

class _PremiumSuccessDialog extends StatelessWidget {
  final String title;

  const _PremiumSuccessDialog({required this.title});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      // backgroundColor: Colors.transparent,
      insetPadding: const EdgeInsets.symmetric(horizontal: 24),
      child: ModernGlassCard(
        padding: const EdgeInsets.all(32),
        borderRadius: BorderRadius.circular(32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: AppColors.primaryGradient,
                boxShadow: [
                  BoxShadow(
                    color: AppColors.primary.withOpacity(0.3),
                    blurRadius: 24,
                    offset: const Offset(0, 8),
                  ),
                ],
              ),
              child: const Icon(
                Icons.task_alt_rounded,
                size: 48,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 24),
            const Text(
              "Redemption Success!",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            Text(
              "The item \"$title\" has been queued for delivery. Expect it in your game inbox within 48 hours.",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: AppColors.darkTextSecondary,
                fontSize: 14,
                height: 1.5,
              ),
            ),
            const SizedBox(height: 32),
            ModernGradientButton(
              text: "GREAT!",
              height: 54,
              onPressed: () {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (_) => const HomeScreen()),
                  (_) => false,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
