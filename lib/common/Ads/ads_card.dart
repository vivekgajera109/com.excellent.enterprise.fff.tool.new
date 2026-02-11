import 'dart:math';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:fff_skin_tools/Provider/ads_provider.dart';
import 'package:fff_skin_tools/common/common_button/common_button.dart';
import 'package:fff_skin_tools/helper/remote_config_service.dart';

/// ===================================================================
/// ✅ SAFE NATIVE AD CARD (Firebase Controlled)
/// ===================================================================
class NativeAdsScreen extends StatelessWidget {
  const NativeAdsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // 🔥 Firebase control
    if (!RemoteConfigService.isAdsShow) {
      return const SizedBox.shrink();
    }

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
      onTap: () async => await CommonOnTap.openUrl(),
      child: Padding(
        padding: const EdgeInsets.only(bottom: 10),
        child: Card(
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              /// ---------------- HEADER ----------------
              Padding(
                padding: const EdgeInsets.all(12),
                child: Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.asset(
                        smallLogo,
                        height: 42,
                        width: 42,
                        fit: BoxFit.contain,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            title,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            subtitle,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontSize: 11,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.black12,
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: const Text(
                        "Ad",
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              /// ---------------- IMAGE ----------------
              Image.asset(
                imagePath,
                width: double.infinity,
                height: 150,
                fit: BoxFit.cover,
              ),

              /// ---------------- CTA ----------------
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                child: CommonButton(
                  title: buttonTitle,
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
/// ✅ SAFE BANNER AD (Firebase Controlled)
/// ===================================================================
class BanerAdsScreen extends StatelessWidget {
  const BanerAdsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // 🔥 Firebase control
    if (!RemoteConfigService.isAdsShow) {
      return const SizedBox.shrink();
    }

    final adsProvider = context.watch<AdsProvider>();
    final random = Random();

    final title =
        adsProvider.adTitles[random.nextInt(adsProvider.adTitles.length)];
    final subtitle =
        adsProvider.adSubtitles[random.nextInt(adsProvider.adSubtitles.length)];
    final smallLogo = adsProvider.nativeDimondImages[
        random.nextInt(adsProvider.nativeDimondImages.length)];

    return SizedBox(
      height: 80,
      child: GestureDetector(
        onTap: () async => await CommonOnTap.openUrl(),
        child: Card(
          margin: EdgeInsets.zero,
          elevation: 0,
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              children: [
                Image.asset(
                  smallLogo,
                  height: 40,
                  width: 40,
                  fit: BoxFit.contain,
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        subtitle,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 11,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: 72,
                  height: 32,
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      color: Colors.blueAccent,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Center(
                      child: Text(
                        "Install",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
