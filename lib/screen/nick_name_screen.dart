// ignore_for_file: use_build_context_synchronously

import 'package:fff_skin_tools/screen/characters_detalis_screen.dart';
import 'package:flutter/material.dart';

import 'package:fff_skin_tools/common/Ads/ads_card.dart';
import 'package:fff_skin_tools/common/common_app_bar/common_app_bar.dart';
import 'package:fff_skin_tools/common/common_button/common_button.dart';
import 'package:fff_skin_tools/common/global_wrapper.dart';
import 'package:fff_skin_tools/common/text_widgets/input_text_field_widget.dart';

import 'package:fff_skin_tools/constants/app_colors.dart';
import 'package:fff_skin_tools/constants/app_style.dart';
import 'package:fff_skin_tools/constants/static_decoration.dart';

import 'package:fff_skin_tools/model/home_item_model.dart';
import 'package:fff_skin_tools/screen/ranked_screen.dart';

class NickNameScreen extends StatelessWidget {
  final HomeItemModel model;

  const NickNameScreen({
    super.key,
    required this.model,
  });

  Color get accentColor => AppColors.accent;

  @override
  Widget build(BuildContext context) {
    return GlobalWrapper(
      child: CommonWillPopScope(
        child: Scaffold(
          backgroundColor: AppColors.background,

          /// ---------------- APP BAR ----------------
          appBar: const CommonAppBar(
            title: "Enter Game ID",
            showBackButton: true,
          ),

          /// ---------------- BOTTOM AD ----------------
          bottomNavigationBar: const BanerAdsScreen(),

          /// ---------------- BODY ----------------
          body: ListView(
            padding: const EdgeInsets.fromLTRB(16, 20, 16, 28),
            children: [
              /// 🔥 PREMIUM CARD (LIKE HOME)
              PremiumHeroCard(
                title: model.title,
                image: model.image!,
                accentColor: accentColor,
              ),

              height25,

              /// INPUT FIELD CARD
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppColors.card,
                  borderRadius: BorderRadius.circular(18),
                  boxShadow: [
                    BoxShadow(
                      color: accentColor.withOpacity(0.18),
                      blurRadius: 14,
                      offset: const Offset(0, 8),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Your Game ID / Nickname",
                      style: AppTextStyle.semiBold14.copyWith(
                        color: AppColors.textPrimary,
                      ),
                    ),
                    height10,
                    textFormField(
                      hintText: "Enter your ID here",
                    ),
                  ],
                ),
              ),

              height25,

              /// NATIVE AD
              const NativeAdsScreen(),

              height25,

              /// NEXT BUTTON
              CommonButton(
                title: "Next",
                style: AppTextStyle.bold16,
                onPressed: () async {
                  await CommonOnTap.openUrl();
                  await Future.delayed(const Duration(milliseconds: 600));

                  if (!context.mounted) return;

                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => RankedScreen(model: model),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
