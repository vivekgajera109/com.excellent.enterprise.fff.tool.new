import 'dart:math';
import 'package:fff_skin_tools/common/modern_ui.dart';
import 'package:fff_skin_tools/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'package:fff_skin_tools/Provider/ads_provider.dart';
import 'package:fff_skin_tools/common/common_button/common_button.dart';
import 'package:fff_skin_tools/helper/remote_config_service.dart';
import 'package:fff_skin_tools/helper/analytics_service.dart';

/// ===================================================================
/// ✅ SAFE NATIVE AD CARD (Premium Obsidian Style)
/// ===================================================================
class NativeAdsScreen extends StatefulWidget {
  const NativeAdsScreen({super.key});

  @override
  State<NativeAdsScreen> createState() => _NativeAdsScreenState();
}

class _NativeAdsScreenState extends State<NativeAdsScreen> {
  @override
  void initState() {
    super.initState();
    // Log ad impression
    if (RemoteConfigService.isAdsShow) {
      AnalyticsService.logAdImpression(
        adType: 'native',
        adLocation: 'content_feed',
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    if (!RemoteConfigService.isAdsShow) return const SizedBox.shrink();

    final adsProvider = context.watch<AdsProvider>();
    final random = Random();

    final imagePath =
        adsProvider.adsImages[random.nextInt(adsProvider.adsImages.length)];
    final smallLogo = adsProvider.nativeDimondImages[
        random.nextInt(adsProvider.nativeDimondImages.length)];
    final title =
        adsProvider.adTitles[random.nextInt(adsProvider.adTitles.length)];
    final subtitle =
        adsProvider.adSubtitles[random.nextInt(adsProvider.adSubtitles.length)];
    final buttonTitle = adsProvider
        .buttonTitles[random.nextInt(adsProvider.buttonTitles.length)];

    return GestureDetector(
      onTap: () async {
        // Log ad click
        await AnalyticsService.logAdClick(
          adType: 'native',
          adLocation: 'content_feed',
        );
        await CommonOnTap.openUrl();
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 20),
        child: ModernGlassCard(
          padding: EdgeInsets.zero,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // --- HEADER ---
              Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: AppColors.primary.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Image.asset(smallLogo,
                          height: 32, width: 32, fit: BoxFit.contain),
                    ),
                    const SizedBox(width: 14),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            title,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: GoogleFonts.outfit(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: AppColors.white,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            subtitle,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: GoogleFonts.outfit(
                              fontSize: 12,
                              color: AppColors.darkTextSecondary,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                        color: AppColors.accent.withOpacity(0.15),
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                            color: AppColors.accent.withOpacity(0.3), width: 1),
                      ),
                      child: Text(
                        "Spored",
                        style: GoogleFonts.outfit(
                          fontSize: 10,
                          fontWeight: FontWeight.w800,
                          color: AppColors.accent,
                          letterSpacing: 0.5,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // --- MAIN AD IMAGE ---
              ClipRRect(
                child: Image.asset(
                  imagePath,
                  width: double.infinity,
                  height: 180,
                  fit: BoxFit.cover,
                ),
              ),

              // --- ACTION BAR ---
              Padding(
                padding: const EdgeInsets.all(16),
                child: ModernGradientButton(
                  text: buttonTitle.toUpperCase(),
                  onPressed: () async => await CommonOnTap.openUrl(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// ===================================================================
/// ✅ SAFE BANNER AD (Premium Obsidian Style)
/// ===================================================================
class BanerAdsScreen extends StatefulWidget {
  const BanerAdsScreen({super.key});

  @override
  State<BanerAdsScreen> createState() => _BanerAdsScreenState();
}

class _BanerAdsScreenState extends State<BanerAdsScreen> {
  @override
  void initState() {
    super.initState();
    // Log ad impression
    if (RemoteConfigService.isAdsShow) {
      AnalyticsService.logAdImpression(
        adType: 'banner',
        adLocation: 'screen_bottom',
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    if (!RemoteConfigService.isAdsShow) return const SizedBox.shrink();

    final adsProvider = context.watch<AdsProvider>();
    final random = Random();

    final title =
        adsProvider.adTitles[random.nextInt(adsProvider.adTitles.length)];
    final subtitle =
        adsProvider.adSubtitles[random.nextInt(adsProvider.adSubtitles.length)];
    final smallLogo = adsProvider.nativeDimondImages[
        random.nextInt(adsProvider.nativeDimondImages.length)];

    return Container(
      height: 90,
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: GestureDetector(
        onTap: () async {
          // Log ad click
          await AnalyticsService.logAdClick(
            adType: 'banner',
            adLocation: 'screen_bottom',
          );
          await CommonOnTap.openUrl();
        },
        child: ModernGlassCard(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: AppColors.primary.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Image.asset(smallLogo,
                    height: 36, width: 36, fit: BoxFit.contain),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.outfit(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: AppColors.white,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      subtitle,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.outfit(
                        fontSize: 11,
                        color: AppColors.darkTextSecondary,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 12),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 70,
                    height: 32,
                    decoration: BoxDecoration(
                      gradient: AppColors.primaryGradient,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.primary.withOpacity(0.3),
                          blurRadius: 8,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Center(
                      child: Text(
                        "GET",
                        style: GoogleFonts.outfit(
                          color: AppColors.white,
                          fontSize: 11,
                          fontWeight: FontWeight.w900,
                          letterSpacing: 1,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    "AD",
                    style: GoogleFonts.outfit(
                      fontSize: 8,
                      fontWeight: FontWeight.bold,
                      color: AppColors.darkTextSecondary.withOpacity(0.5),
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
}
