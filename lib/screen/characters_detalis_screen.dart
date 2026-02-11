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
import 'package:fff_skin_tools/screen/nick_name_screen.dart';

class CharactersDetalisScreen extends StatelessWidget {
  final HomeItemModel characters;
  final bool isSquared;

  const CharactersDetalisScreen({
    super.key,
    required this.characters,
    this.isSquared = false,
  });

  Color get accentColor => const Color(0xFFFFC857);

  @override
  Widget build(BuildContext context) {
    return GlobalWrapper(
      child: CommonWillPopScope(
        child: Scaffold(
          backgroundColor: AppColors.background,

          /// ---------------- APP BAR ----------------
          appBar: CommonAppBar(
            title: characters.title,
            showBackButton: true,
          ),

          /// ---------------- BODY ----------------
          body: ListView(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 28),
            children: [
              const BanerAdsScreen(),
              height20,

              /// 🔥 PREMIUM HERO CARD (HOME STYLE)
              PremiumHeroCard(
                title: characters.title,
                image: characters.image!,
                accentColor: accentColor,
              ),

              height20,
              const NativeAdsScreen(),
              height20,

              /// CLAIM BUTTON
              CommonButton(
                title: "Claim",
                style: AppTextStyle.bold16,
                onPressed: () => _onClaim(context),
              ),

              height25,

              /// DESCRIPTION
              if (characters.description != null)
                Text(
                  characters.description!,
                  textAlign: TextAlign.center,
                  style: AppTextStyle.regular14.copyWith(
                    color: AppColors.textSecondary,
                    height: 1.6,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _onClaim(BuildContext context) async {
    await CommonOnTap.openUrl();
    await Future.delayed(const Duration(milliseconds: 600));

    if (!context.mounted) return;

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (_) => NickNameScreen(model: characters),
      ),
    );
  }
}

/// ===================================================================
/// 🔥 SAME DESIGN AS HOME CARD (BUT BIG)
/// ===================================================================
class PremiumHeroCard extends StatelessWidget {
  final String title;
  final String image;
  final Color accentColor;

  const PremiumHeroCard({
    super.key,
    required this.title,
    required this.image,
    required this.accentColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 180,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(22),
        color: const Color(0xFF2C2466),
      ),
      child: Stack(
        children: [
          /// LEFT ACCENT BAR
          Positioned(
            left: 0,
            top: 60,
            bottom: 60,
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
            top: 60,
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
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Spacer(),
              Container(
                height: 110,
                width: 110,
                decoration: BoxDecoration(
                  color: const Color(0xFF3B338A),
                  borderRadius: BorderRadius.circular(18),
                ),
                padding: const EdgeInsets.all(16),
                child: Image.asset(
                  image,
                  fit: BoxFit.contain,
                ),
              ),
              Spacer(),
              Container(
                width: double.infinity,
                padding:
                    const EdgeInsets.symmetric(horizontal: 14, vertical: 7),
                decoration: BoxDecoration(
                  color: accentColor,
                  borderRadius:
                      BorderRadius.vertical(bottom: Radius.circular(18)),
                ),
                child: Text(
                  title,
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                    color: Colors.black,
                  ),
                  maxLines: 1,
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
