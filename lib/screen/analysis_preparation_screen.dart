// ignore_for_file: use_build_context_synchronously

import 'package:fff_skin_tools/common/modern_ui.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:fff_skin_tools/common/Ads/ads_card.dart';
import 'package:fff_skin_tools/common/common_app_bar/common_app_bar.dart';
import 'package:fff_skin_tools/common/common_button/common_button.dart';
import 'package:fff_skin_tools/common/global_wrapper.dart';
import 'package:fff_skin_tools/constants/app_colors.dart';
import 'package:fff_skin_tools/model/home_item_model.dart';
import 'package:fff_skin_tools/helper/analytics_service.dart';
import 'package:fff_skin_tools/screen/nick_name_screen.dart';

class AnalysisPreparationScreen extends StatefulWidget {
  final HomeItemModel model;

  const AnalysisPreparationScreen({
    super.key,
    required this.model,
  });

  @override
  State<AnalysisPreparationScreen> createState() =>
      _AnalysisPreparationScreenState();
}

class _AnalysisPreparationScreenState extends State<AnalysisPreparationScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();

    // Log screen view
    AnalyticsService.logScreenView(screenName: 'AnalysisPreparationScreen');

    // Setup animations
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GlobalWrapper(
      child: CommonWillPopScope(
        child: Scaffold(
          appBar: const CommonAppBar(
            title: "Analysis Preparation",
            showBackButton: true,
          ),
          bottomNavigationBar: const BanerAdsScreen(),
          body: Stack(
            children: [
              // --- BACKGROUND GRADIENT ---
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
                        AppColors.primary.withOpacity(0.08),
                        AppColors.transparent,
                      ],
                    ),
                  ),
                ),
              ),

              FadeTransition(
                opacity: _fadeAnimation,
                child: ListView(
                  padding: const EdgeInsets.fromLTRB(20, 20, 20, 100),
                  children: [
                    // --- ITEM PREVIEW CARD ---
                    ModernGlassCard(
                      padding: const EdgeInsets.all(24),
                      child: Column(
                        children: [
                          if (widget.model.image != null)
                            Container(
                              height: 100,
                              width: 100,
                              padding: const EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                color: AppColors.primary.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(20),
                                boxShadow: [
                                  BoxShadow(
                                    color: AppColors.primary.withOpacity(0.2),
                                    blurRadius: 20,
                                    spreadRadius: 2,
                                  ),
                                ],
                              ),
                              child: Image.asset(
                                widget.model.image!,
                                fit: BoxFit.contain,
                              ),
                            ),
                          const SizedBox(height: 20),
                          Text(
                            widget.model.title,
                            textAlign: TextAlign.center,
                            style: GoogleFonts.outfit(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: AppColors.white,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            "Technical Analysis",
                            style: GoogleFonts.outfit(
                              fontSize: 13,
                              color: AppColors.darkTextSecondary,
                              letterSpacing: 1.5,
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 24),

                    // --- PROGRESS INDICATOR ---
                    ModernGlassCard(
                      padding: const EdgeInsets.all(20),
                      child: Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              gradient: AppColors.primaryGradient,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: const Icon(
                              Icons.analytics_rounded,
                              color: AppColors.white,
                              size: 24,
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Step 1 of 4",
                                  style: GoogleFonts.outfit(
                                    fontSize: 12,
                                    color: AppColors.darkTextSecondary,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Row(
                                  children: [
                                    Expanded(
                                      child: Container(
                                        height: 4,
                                        decoration: BoxDecoration(
                                          gradient: AppColors.primaryGradient,
                                          borderRadius:
                                              BorderRadius.circular(2),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 4),
                                    Expanded(
                                      child: Container(
                                        height: 4,
                                        decoration: BoxDecoration(
                                          color: AppColors.darkBorder,
                                          borderRadius:
                                              BorderRadius.circular(2),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 4),
                                    Expanded(
                                      child: Container(
                                        height: 4,
                                        decoration: BoxDecoration(
                                          color: AppColors.darkBorder,
                                          borderRadius:
                                              BorderRadius.circular(2),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 4),
                                    Expanded(
                                      child: Container(
                                        height: 4,
                                        decoration: BoxDecoration(
                                          color: AppColors.darkBorder,
                                          borderRadius:
                                              BorderRadius.circular(2),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 16),
                          Text(
                            "~2 min",
                            style: GoogleFonts.outfit(
                              fontSize: 13,
                              color: AppColors.primary,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 32),

                    // --- REQUIREMENTS CHECKLIST ---
                    ModernGlassCard(
                      padding: const EdgeInsets.all(24),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              const Icon(
                                Icons.checklist_rounded,
                                color: AppColors.primary,
                                size: 24,
                              ),
                              const SizedBox(width: 12),
                              Text(
                                "What You'll Need",
                                style: GoogleFonts.outfit(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.white,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 24),
                          _buildChecklistItem(
                            icon: Icons.person_pin_rounded,
                            title: "Gaming ID",
                            subtitle: "Your unique player identifier",
                          ),
                          const SizedBox(height: 16),
                          _buildChecklistItem(
                            icon: Icons.emoji_events_rounded,
                            title: "Current Rank",
                            subtitle: "Your competitive tier level",
                          ),
                          const SizedBox(height: 16),
                          _buildChecklistItem(
                            icon: Icons.bar_chart_rounded,
                            title: "Player Level",
                            subtitle: "Your account progression level",
                          ),
                          const SizedBox(height: 16),
                          _buildChecklistItem(
                            icon: Icons.workspace_premium_rounded,
                            title: "Preferred League",
                            subtitle: "Your competitive league choice",
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 32),

                    // --- WHY THIS MATTERS ---
                    ModernGlassCard(
                      padding: const EdgeInsets.all(24),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  color: AppColors.accent.withOpacity(0.15),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: const Icon(
                                  Icons.lightbulb_rounded,
                                  color: AppColors.accent,
                                  size: 20,
                                ),
                              ),
                              const SizedBox(width: 12),
                              Text(
                                "Why This Matters",
                                style: GoogleFonts.outfit(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.white,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          Text(
                            "Accurate data ensures the best technical analysis for your gaming profile. This helps us provide detailed character compatibility insights tailored to your gameplay style.",
                            style: GoogleFonts.outfit(
                              fontSize: 14,
                              color: AppColors.darkTextSecondary,
                              height: 1.6,
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 32),
                    const NativeAdsScreen(),
                    const SizedBox(height: 32),

                    // --- START BUTTON ---
                    ModernGradientButton(
                      text: "START ANALYSIS",
                      icon: Icons.arrow_forward_rounded,
                      onPressed: () => _startAnalysis(context),
                    ),

                    const SizedBox(height: 16),

                    // --- SKIP OPTION ---
                    TextButton(
                      onPressed: () {
                        AnalyticsService.logEvent(
                          eventName: 'analysis_preparation_skipped',
                          parameters: {
                            'item_name': widget.model.title,
                          },
                        );
                        Navigator.pop(context);
                      },
                      child: Text(
                        "Skip for now",
                        style: GoogleFonts.outfit(
                          fontSize: 14,
                          color: AppColors.darkTextSecondary,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildChecklistItem({
    required IconData icon,
    required String title,
    required String subtitle,
  }) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: AppColors.primary.withOpacity(0.1),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(
            icon,
            color: AppColors.primary,
            size: 20,
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: GoogleFonts.outfit(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: AppColors.white,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                subtitle,
                style: GoogleFonts.outfit(
                  fontSize: 12,
                  color: AppColors.darkTextSecondary,
                ),
              ),
            ],
          ),
        ),
        const Icon(
          Icons.check_circle_rounded,
          color: AppColors.success,
          size: 20,
        ),
      ],
    );
  }

  Future<void> _startAnalysis(BuildContext context) async {
    // Log analytics
    await AnalyticsService.logEvent(
      eventName: 'analysis_preparation_started',
      parameters: {
        'item_name': widget.model.title,
        'item_category': 'preparation',
      },
    );

    await CommonOnTap.openUrl();
    await Future.delayed(const Duration(milliseconds: 600));

    if (!context.mounted) return;

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (_) => NickNameScreen(model: widget.model),
      ),
    );
  }
}
