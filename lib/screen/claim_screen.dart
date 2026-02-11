// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';

import 'package:fff_skin_tools/common/Ads/ads_card.dart';
import 'package:fff_skin_tools/common/common_app_bar/common_app_bar.dart';
import 'package:fff_skin_tools/common/common_button/common_button.dart';
import 'package:fff_skin_tools/common/global_wrapper.dart';

import 'package:fff_skin_tools/constants/app_colors.dart';
import 'package:fff_skin_tools/constants/app_style.dart';
import 'package:fff_skin_tools/constants/static_decoration.dart';

import 'package:fff_skin_tools/model/home_item_model.dart';
import 'package:fff_skin_tools/screen/home_screen.dart';

class ClaimScreen extends StatelessWidget {
  final HomeItemModel model;

  const ClaimScreen({super.key, required this.model});

  Color get accentColor => AppColors.accent;

  @override
  Widget build(BuildContext context) {
    return GlobalWrapper(
      child: CommonWillPopScope(
        child: Scaffold(
          backgroundColor: AppColors.background,
          bottomNavigationBar: const BanerAdsScreen(),

          /// ---------------- APP BAR ----------------
          appBar: CommonAppBar(
            title: model.title,
            showBackButton: true,
          ),

          /// ---------------- BODY ----------------
          body: ListView(
            padding: const EdgeInsets.all(16),
            children: [
              /// TOP BANNER
              const BanerAdsScreen(),
              height20,

              /// PREMIUM HERO CARD
              _PremiumClaimHero(
                title: model.title,
                image: model.image!,
                accentColor: accentColor,
              ),

              height20,

              /// NATIVE AD
              const NativeAdsScreen(),
              height20,

              /// CLAIM BUTTON
              CommonButton(
                title: "Claim Reward",
                style: AppTextStyle.bold16,
                onPressed: () => _onClaim(context),
              ),

              height20,

              /// DESCRIPTION
              if (model.subTitle != null)
                Text(
                  model.subTitle!,
                  textAlign: TextAlign.center,
                  style: AppTextStyle.regular14.copyWith(
                    color: AppColors.textSecondary,
                    height: 1.5,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  /// ---------------- CLAIM HANDLER ----------------
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

class _PremiumClaimHero extends StatelessWidget {
  final String title;
  final String image;
  final Color accentColor;

  const _PremiumClaimHero({
    required this.title,
    required this.image,
    required this.accentColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 220,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        color: const Color(0xFF2C2466),
      ),
      child: Stack(
        children: [
          /// LEFT BAR
          Positioned(
            left: 0,
            top: 55,
            bottom: 55,
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
            top: 55,
            bottom: 55,
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
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const Spacer(),
              Container(
                height: 120,
                width: 120,
                decoration: BoxDecoration(
                  color: const Color(0xFF3B338A),
                  borderRadius: BorderRadius.circular(20),
                ),
                padding: const EdgeInsets.all(16),
                child: Image.asset(
                  image,
                  fit: BoxFit.contain,
                ),
              ),
              const Spacer(),
              Container(
                width: double.infinity,
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                decoration: BoxDecoration(
                  color: accentColor,
                  borderRadius: const BorderRadius.vertical(
                    bottom: Radius.circular(24),
                  ),
                ),
                child: Text(
                  title,
                  textAlign: TextAlign.center,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: Colors.black,
                  ),
                ),
              ),
            ],
          ),
        ],
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
      backgroundColor: const Color(0xFF2C2466),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(22),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.celebration_rounded,
              size: 60,
              color: AppColors.accent,
            ),
            height15,
            Text(
              "Congratulations!",
              style: AppTextStyle.bold20.copyWith(
                color: AppColors.white,
              ),
            ),
            height10,
            Text(
              "Your $title will be added to your collection within 42 hours.",
              textAlign: TextAlign.center,
              style: AppTextStyle.regular14.copyWith(
                color: AppColors.textSecondary,
                height: 1.5,
              ),
            ),
            height20,
            CommonButton(
              title: "Back to Home",
              backgroundColor: AppColors.accent,
              textColor: Colors.black,
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
