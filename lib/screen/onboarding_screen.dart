// ignore_for_file: use_build_context_synchronously

import 'package:fff_skin_tools/common/modern_ui.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'package:fff_skin_tools/common/global_wrapper.dart';
import 'package:fff_skin_tools/constants/app_colors.dart';
import 'package:fff_skin_tools/provider/onboarding_provider.dart';
import 'package:fff_skin_tools/screen/home_screen.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen>
    with SingleTickerProviderStateMixin {
  late final PageController _pageController;
  late final AnimationController _floatController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    _floatController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _pageController.dispose();
    _floatController.dispose();
    super.dispose();
  }

  Future<void> _finishOnboarding(OnboardingProvider provider) async {
    await provider.completeOnboarding();
    if (!mounted) return;

    Navigator.pushAndRemoveUntil(
      context,
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) =>
            const HomeScreen(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return FadeTransition(opacity: animation, child: child);
        },
        transitionDuration: const Duration(milliseconds: 800),
      ),
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return GlobalWrapper(
      child: ChangeNotifierProvider(
        create: (_) => OnboardingProvider(),
        child: Consumer<OnboardingProvider>(
          builder: (context, provider, _) {
            final pages = provider.pages;
            final isLastPage = provider.currentPage == pages.length - 1;

            return Scaffold(
              body: Stack(
                children: [
                  // --- PREMIUM BACKGROUND DECORATION ---
                  Positioned.fill(
                    child: Container(
                      decoration:
                          const BoxDecoration(color: AppColors.darkBackground),
                    ),
                  ),

                  // Animated Blobs
                  AnimatedBuilder(
                    animation: _floatController,
                    builder: (context, child) {
                      return Stack(
                        children: [
                          Positioned(
                            top: -50 + (_floatController.value * 30),
                            right: -50 - (_floatController.value * 20),
                            child: _buildBlob(
                                AppColors.primary.withOpacity(0.15), 300),
                          ),
                          Positioned(
                            bottom: 100 - (_floatController.value * 40),
                            left: -100 + (_floatController.value * 20),
                            child: _buildBlob(
                                AppColors.secondary.withOpacity(0.1), 350),
                          ),
                        ],
                      );
                    },
                  ),

                  // --- MAIN CONTENT ---
                  SafeArea(
                    child: Column(
                      children: [
                        const SizedBox(height: 20),
                        _buildHeader(provider.currentPage + 1, pages.length),

                        Expanded(
                          child: PageView.builder(
                            controller: _pageController,
                            itemCount: pages.length,
                            onPageChanged: provider.updateCurrentPage,
                            itemBuilder: (context, index) {
                              final page = pages[index];
                              return _buildPageContent(context, page, size);
                            },
                          ),
                        ),

                        // --- BOTTOM NAVIGATION OVERLAY ---
                        _buildBottomControls(
                            provider, isLastPage, pages.length),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildBlob(Color color, double size) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: color,
        boxShadow: [
          BoxShadow(
            color: color.withOpacity(0.1),
            blurRadius: 100,
            spreadRadius: 50,
          ),
        ],
      ),
    );
  }

  Widget _buildHeader(int current, int total) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "STEP $current OF $total",
            style: GoogleFonts.outfit(
              color: AppColors.primary,
              fontWeight: FontWeight.bold,
              letterSpacing: 2,
              fontSize: 12,
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: AppColors.white.withOpacity(0.05),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              children: [
                const Icon(Icons.bolt_rounded,
                    color: AppColors.accent, size: 16),
                const SizedBox(width: 4),
                Text(
                  "PREMIUM",
                  style: GoogleFonts.outfit(
                    color: AppColors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 10,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPageContent(BuildContext context, dynamic page, Size size) {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Animated Image Frame
          TweenAnimationBuilder<double>(
            tween: Tween(begin: 0.8, end: 1.0),
            duration: const Duration(milliseconds: 1000),
            curve: Curves.elasticOut,
            builder: (context, value, child) {
              return Transform.scale(scale: value, child: child);
            },
            child: Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  width: size.width * 0.65,
                  height: size.width * 0.65,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: RadialGradient(
                      colors: [
                        AppColors.primary.withOpacity(0.15),
                        Colors.transparent,
                      ],
                    ),
                  ),
                ),
                Image.asset(
                  page.image,
                  height: size.height * 0.35,
                  fit: BoxFit.contain,
                ),
              ],
            ),
          ),
          const SizedBox(height: 48),

          // Content
          Text(
            page.title.toUpperCase(),
            textAlign: TextAlign.center,
            style: GoogleFonts.outfit(
              fontSize: 32,
              fontWeight: FontWeight.w900,
              color: AppColors.white,
              letterSpacing: -0.5,
              height: 1.1,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            page.subtitle,
            textAlign: TextAlign.center,
            style: GoogleFonts.outfit(
              fontSize: 16,
              color: AppColors.darkTextSecondary,
              height: 1.6,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomControls(
      OnboardingProvider provider, bool isLastPage, int totalPages) {
    return ModernGlassCard(
      margin: const EdgeInsets.fromLTRB(24, 0, 24, 24),
      borderRadius: BorderRadius.circular(28),
      padding: const EdgeInsets.all(24),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              totalPages,
              (index) => AnimatedContainer(
                duration: const Duration(milliseconds: 400),
                margin: const EdgeInsets.symmetric(horizontal: 5),
                height: 6,
                width: provider.currentPage == index ? 32 : 8,
                decoration: BoxDecoration(
                  gradient: provider.currentPage == index
                      ? AppColors.primaryGradient
                      : null,
                  color: provider.currentPage == index
                      ? null
                      : AppColors.white.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ),
          const SizedBox(height: 32),
          Row(
            children: [
              Expanded(
                child: TextButton(
                  onPressed: () => _finishOnboarding(provider),
                  child: Text(
                    "SKIP",
                    style: GoogleFonts.outfit(
                      color: AppColors.darkTextSecondary,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.5,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 20),
              Expanded(
                flex: 2,
                child: ModernGradientButton(
                  text: isLastPage ? "GET STARTED" : "CONTINUE",
                  onPressed: () {
                    if (isLastPage) {
                      _finishOnboarding(provider);
                    } else {
                      _pageController.nextPage(
                        duration: const Duration(milliseconds: 600),
                        curve: Curves.easeOutQuart,
                      );
                    }
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
