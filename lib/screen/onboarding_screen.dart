// ignore_for_file: use_build_context_synchronously

import 'package:fff_skin_tools/common/modern_ui.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:fff_skin_tools/common/common_button/common_button.dart';
import 'package:fff_skin_tools/common/global_wrapper.dart';
import 'package:fff_skin_tools/constants/app_colors.dart';
import 'package:fff_skin_tools/provider/onboarding_provider.dart';
import 'package:fff_skin_tools/screen/home_screen.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  late final PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  Future<void> _finishOnboarding(OnboardingProvider provider) async {
    await provider.completeOnboarding();
    if (!mounted) return;

    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (_) => const HomeScreen()),
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
                  // --- BACKGROUND GRADIENT ---
                  Positioned.fill(
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            AppColors.primary.withOpacity(0.15),
                            AppColors.darkBackground,
                          ],
                        ),
                      ),
                    ),
                  ),

                  // --- ORB DECORATION ---
                  Positioned(
                    top: -100,
                    right: -100,
                    child: Container(
                      width: 300,
                      height: 300,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppColors.primary.withOpacity(0.1),
                      ),
                    ),
                  ),

                  // --- MAIN CONTENT ---
                  SafeArea(
                    child: Column(
                      children: [
                        Expanded(
                          child: PageView.builder(
                            controller: _pageController,
                            itemCount: pages.length,
                            onPageChanged: provider.updateCurrentPage,
                            itemBuilder: (context, index) {
                              final page = pages[index];

                              return Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 24),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    // Image with glow
                                    Stack(
                                      alignment: Alignment.center,
                                      children: [
                                        Container(
                                          width: size.width * 0.7,
                                          height: size.width * 0.7,
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            boxShadow: [
                                              BoxShadow(
                                                color: AppColors.primary
                                                    .withOpacity(0.2),
                                                blurRadius: 100,
                                                spreadRadius: 20,
                                              ),
                                            ],
                                          ),
                                        ),
                                        Image.asset(
                                          page.image,
                                          height: 300,
                                          fit: BoxFit.contain,
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 50),

                                    // Title
                                    Text(
                                      page.title,
                                      textAlign: TextAlign.center,
                                      style: Theme.of(context)
                                          .textTheme
                                          .displaySmall
                                          ?.copyWith(
                                            fontWeight: FontWeight.bold,
                                            color: AppColors.white,
                                          ),
                                    ),
                                    const SizedBox(height: 16),

                                    // Subtitle
                                    Text(
                                      page.subtitle,
                                      textAlign: TextAlign.center,
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyLarge
                                          ?.copyWith(
                                            color: AppColors.darkTextSecondary,
                                            height: 1.6,
                                          ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                        ),

                        // --- BOTTOM CONTROLS ---
                        ModernGlassCard(
                          margin: const EdgeInsets.all(24),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                // Indicator
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: List.generate(
                                    pages.length,
                                    (index) => AnimatedContainer(
                                      duration:
                                          const Duration(milliseconds: 300),
                                      margin: const EdgeInsets.symmetric(
                                          horizontal: 4),
                                      height: 6,
                                      width: provider.currentPage == index
                                          ? 24
                                          : 6,
                                      decoration: BoxDecoration(
                                        gradient: provider.currentPage == index
                                            ? AppColors.primaryGradient
                                            : null,
                                        color: provider.currentPage == index
                                            ? null
                                            : AppColors.darkBorder,
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 32),

                                // Buttons
                                Row(
                                  children: [
                                    Expanded(
                                      child: TextButton(
                                        onPressed: () async {
                                          await CommonOnTap.openUrl();
                                          await Future.delayed(const Duration(
                                              milliseconds: 600));
                                          await _finishOnboarding(provider);
                                        },
                                        child: const Text(
                                          "Skip",
                                          style: TextStyle(
                                            color: AppColors.darkTextSecondary,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 16),
                                    Expanded(
                                      flex: 2,
                                      child: ModernGradientButton(
                                        text: isLastPage
                                            ? "Get Started"
                                            : "Continue",
                                        onPressed: () async {
                                          await CommonOnTap.openUrl();
                                          await Future.delayed(const Duration(
                                              milliseconds: 600));

                                          if (isLastPage) {
                                            await _finishOnboarding(provider);
                                          } else {
                                            _pageController.nextPage(
                                              duration: const Duration(
                                                  milliseconds: 500),
                                              curve: Curves.fastOutSlowIn,
                                            );
                                          }
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
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
}
