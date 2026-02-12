// ignore_for_file: use_build_context_synchronously

import 'package:fff_skin_tools/common/modern_ui.dart';
import 'package:flutter/material.dart';

import 'package:fff_skin_tools/common/Ads/ads_card.dart';
import 'package:fff_skin_tools/common/common_app_bar/common_app_bar.dart';
import 'package:fff_skin_tools/common/common_button/common_button.dart';
import 'package:fff_skin_tools/common/global_wrapper.dart';
import 'package:fff_skin_tools/common/text_widgets/input_text_field_widget.dart';

import 'package:fff_skin_tools/constants/app_colors.dart';
import 'package:fff_skin_tools/model/home_item_model.dart';
import 'package:fff_skin_tools/screen/ranked_screen.dart';

class NickNameScreen extends StatelessWidget {
  final HomeItemModel model;

  const NickNameScreen({
    super.key,
    required this.model,
  });

  @override
  Widget build(BuildContext context) {
    return GlobalWrapper(
      child: CommonWillPopScope(
        child: Scaffold(
          appBar: const CommonAppBar(
            title: "Verification",
            showBackButton: true,
          ),
          bottomNavigationBar: const BanerAdsScreen(),
          body: Stack(
            children: [
              // --- BACKGROUND DECORATION ---
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                height: 300,
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        AppColors.primary.withOpacity(0.1),
                        AppColors.transparent,
                      ],
                    ),
                  ),
                ),
              ),

              ListView(
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 28),
                children: [
                  // --- SUMMARY CARD ---
                  ModernGlassCard(
                    padding: const EdgeInsets.all(16),
                    child: Row(
                      children: [
                        Container(
                          width: 80,
                          height: 80,
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: AppColors.primary.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Image.asset(model.image!, fit: BoxFit.contain),
                        ),
                        const SizedBox(width: 20),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                "Selected Item",
                                style: TextStyle(
                                  color: AppColors.darkTextSecondary,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                model.title,
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 32),

                  // --- INPUT FIELD CARD ---
                  ModernGlassCard(
                    padding: const EdgeInsets.all(24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: const [
                            Icon(Icons.person_pin_rounded,
                                color: AppColors.primary, size: 20),
                            SizedBox(width: 8),
                            Text(
                              "Game Credentials",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 24),
                        Container(
                          decoration: BoxDecoration(
                            color: AppColors.darkBackground.withOpacity(0.5),
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(color: AppColors.darkBorder),
                          ),
                          child: textFormField(
                            hintText: "Enter your Gaming ID",
                            // Pass controller if needed, but textFormField seems to be a custom widget
                          ),
                        ),
                        const SizedBox(height: 12),
                        const Text(
                          "Verified credentials are used for compatibility checks.",
                          style: TextStyle(
                            color: AppColors.darkTextSecondary,
                            fontSize: 11,
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 32),
                  const NativeAdsScreen(),
                  const SizedBox(height: 32),

                  // --- NEXT BUTTON ---
                  ModernGradientButton(
                    text: "CONFRIM & NEXT",
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
            ],
          ),
        ),
      ),
    );
  }
}
