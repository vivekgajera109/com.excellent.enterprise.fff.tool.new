// ignore_for_file: use_build_context_synchronously

import 'dart:developer';
import 'package:fff_skin_tools/common/modern_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:fff_skin_tools/common/Ads/ads_card.dart';
import 'package:fff_skin_tools/common/global_wrapper.dart';
import 'package:fff_skin_tools/common/common_app_bar/common_app_bar.dart';
import 'package:fff_skin_tools/common/common_button/common_button.dart';

import 'package:fff_skin_tools/constants/app_colors.dart';
import 'package:fff_skin_tools/constants/app_icons.dart';
import 'package:fff_skin_tools/helper/remote_config_service.dart';
import 'package:fff_skin_tools/screen/privacy_policy_screen.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GlobalWrapper(
      child: CommonWillPopScope(
        child: Scaffold(
          bottomNavigationBar: const NativeAdsScreen(),
          appBar: const CommonAppBar(
            title: "Settings",
            showBackButton: true,
          ),
          body: Stack(
            children: [
              // --- DECORATIVE BACKGROUND ---
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
                padding: const EdgeInsets.fromLTRB(16, 20, 16, 24),
                children: [
                  // --- PREMIUM HEADER ---
                  ModernGlassCard(
                    padding: const EdgeInsets.symmetric(vertical: 32),
                    child: Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            gradient: AppColors.primaryGradient,
                            boxShadow: [
                              BoxShadow(
                                color: AppColors.primary.withOpacity(0.3),
                                blurRadius: 20,
                                spreadRadius: 2,
                              ),
                            ],
                          ),
                          child: const Icon(
                            Icons.settings_suggest_rounded,
                            size: 40,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 20),
                        Text(
                          "App Configuration",
                          style:
                              Theme.of(context).textTheme.titleLarge?.copyWith(
                                    fontWeight: FontWeight.bold,
                                    letterSpacing: 0.5,
                                  ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          "Version 1.0.4 • 2026 Edition",
                          style:
                              Theme.of(context).textTheme.bodyMedium?.copyWith(
                                    color: AppColors.darkTextSecondary,
                                  ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 32),

                  // --- ACTIONS SECTION ---
                  Text(
                    "Community",
                    style: Theme.of(context).textTheme.labelLarge?.copyWith(
                          color: AppColors.primary,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1,
                        ),
                  ),
                  const SizedBox(height: 16),

                  ModernListTile(
                    title: "Share App",
                    subtitle: "Spread the skins with friends",
                    onTap: _openAppUrl,
                    leading: SvgPicture.asset(AppIcons.shareApp,
                        color: Colors.white, width: 22),
                  ),
                  const SizedBox(height: 12),

                  ModernListTile(
                    title: "Rate Us",
                    subtitle: "Give us 5 stars on PlayStore",
                    onTap: _openAppUrl,
                    leading: SvgPicture.asset(AppIcons.rateUs,
                        color: Colors.white, width: 22),
                  ),

                  const SizedBox(height: 32),

                  Text(
                    "Legal & Information",
                    style: Theme.of(context).textTheme.labelLarge?.copyWith(
                          color: AppColors.primary,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1,
                        ),
                  ),
                  const SizedBox(height: 16),

                  ModernListTile(
                    title: "Privacy Policy",
                    subtitle: "How we protect your data",
                    leading: SvgPicture.asset(AppIcons.privacyPolicy,
                        color: Colors.white, width: 22),
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

                  const SizedBox(height: 40),

                  // Footer info
                  Center(
                    child: Opacity(
                      opacity: 0.5,
                      child: Column(
                        children: [
                          const Icon(Icons.security_rounded, size: 20),
                          const SizedBox(height: 8),
                          Text(
                            "Secure & Encrypted Connection",
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                        ],
                      ),
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
