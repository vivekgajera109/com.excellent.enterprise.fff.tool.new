import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:fff_skin_tools/common/Ads/ads_card.dart';
import 'package:fff_skin_tools/common/global_wrapper.dart';
import 'package:fff_skin_tools/common/common_app_bar/common_app_bar.dart';
import 'package:fff_skin_tools/common/common_button/common_button.dart';

import 'package:fff_skin_tools/constants/app_colors.dart';
import 'package:fff_skin_tools/constants/app_icons.dart';
import 'package:fff_skin_tools/constants/static_decoration.dart';

import 'package:fff_skin_tools/helper/remote_config_service.dart';
import 'package:fff_skin_tools/screen/privacy_policy_screen.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GlobalWrapper(
      child: CommonWillPopScope(
        child: Scaffold(
          backgroundColor: AppColors.background,
          bottomNavigationBar: const NativeAdsScreen(),

          /// ---------------- APP BAR ----------------
          appBar: const CommonAppBar(
            title: "Settings",
            showBackButton: true,
          ),

          /// ---------------- BODY ----------------
          body: ListView(
            padding: const EdgeInsets.fromLTRB(16, 20, 16, 24),
            children: [
              /// 🔥 HEADER CARD
              _PremiumHeader(),

              height25,

              /// SETTINGS OPTIONS
              _SettingTile(
                title: "Share App",
                icon: AppIcons.shareApp,
                onTap: _openAppUrl,
              ),

              height15,

              _SettingTile(
                title: "Rate Us",
                icon: AppIcons.rateUs,
                onTap: _openAppUrl,
              ),

              height15,

              _SettingTile(
                title: "Privacy Policy",
                icon: AppIcons.privacyPolicy,
                onTap: () async {
                  final url = RemoteConfigService.getPrivacyPolicyUrl();
                  await CommonOnTap.openUrl();
                  await Future.delayed(const Duration(milliseconds: 600));

                  if (!context.mounted) return;

                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => PrivacyPolicyScreen(url: url),
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

/// ===============================================================
/// 🔥 HEADER CARD (PREMIUM)
// ===============================================================
class _PremiumHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 130,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(22),
        gradient: const LinearGradient(
          colors: [
            Color(0xFF3B338A),
            Color(0xFF2C2466),
          ],
        ),
      ),
      child: Stack(
        children: [
          /// Accent Bars
          Positioned(
            left: 0,
            top: 30,
            bottom: 30,
            child: Container(
              width: 5,
              decoration: BoxDecoration(
                color: AppColors.accent,
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
          Positioned(
            right: 0,
            top: 30,
            bottom: 30,
            child: Container(
              width: 5,
              decoration: BoxDecoration(
                color: AppColors.accent,
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),

          /// CONTENT
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Icon(
                  Icons.settings_rounded,
                  size: 42,
                  color: Colors.white,
                ),
                height10,
                Text(
                  "App Settings",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// ===============================================================
/// 🔥 PREMIUM SETTING TILE
// ===============================================================
class _SettingTile extends StatelessWidget {
  final String title;
  final String icon;
  final VoidCallback onTap;

  const _SettingTile({
    required this.title,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: BoxDecoration(
          color: const Color(0xFF2C2466),
          borderRadius: BorderRadius.circular(18),
          boxShadow: const [
            BoxShadow(
              color: Colors.black38,
              blurRadius: 10,
              offset: Offset(0, 6),
            ),
          ],
        ),
        child: Row(
          children: [
            /// ICON
            Container(
              height: 44,
              width: 44,
              decoration: BoxDecoration(
                color: const Color(0xFF3B338A),
                borderRadius: BorderRadius.circular(14),
              ),
              padding: const EdgeInsets.all(10),
              child: SvgPicture.asset(icon,
                  fit: BoxFit.contain, color: Colors.white),
            ),

            width15,

            /// TITLE
            Expanded(
              child: Text(
                title,
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ),

            /// ARROW
            const Icon(
              Icons.arrow_forward_ios_rounded,
              size: 16,
              color: Colors.white54,
            ),
          ],
        ),
      ),
    );
  }
}

/// ===============================================================
/// OPEN APP URL
// ===============================================================
Future<void> _openAppUrl() async {
  final url = RemoteConfigService.getAppUrl();

  if (url.isEmpty) {
    log("❌ No App URL found");
    return;
  }

  final uri = Uri.parse(url);
  try {
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  } catch (e) {
    log("❌ Error opening URL: $e");
  }
}
