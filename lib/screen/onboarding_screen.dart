// ignore_for_file: use_build_context_synchronously

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
    return GlobalWrapper(
      child: ChangeNotifierProvider(
        create: (_) => OnboardingProvider(),
        child: Consumer<OnboardingProvider>(
          builder: (context, provider, _) {
            final pages = provider.pages;
            final isLastPage = provider.currentPage == pages.length - 1;

            return Scaffold(
              backgroundColor: AppColors.background,
              body: SafeArea(
                child: Column(
                  children: [
                    /// -------------------- PAGES --------------------
                    Expanded(
                      child: PageView.builder(
                        controller: _pageController,
                        itemCount: pages.length,
                        onPageChanged: provider.updateCurrentPage,
                        itemBuilder: (context, index) {
                          final page = pages[index];

                          return Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                page.image,
                                height: 280,
                                fit: BoxFit.contain,
                              ),
                              const SizedBox(height: 30),

                              /// TITLE
                              Text(
                                page.title,
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.textPrimary,
                                ),
                              ),

                              const SizedBox(height: 12),

                              /// SUBTITLE
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 30),
                                child: Text(
                                  page.subtitle,
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                    fontSize: 16,
                                    color: AppColors.textSecondary,
                                    height: 1.4,
                                  ),
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                    ),

                    /// -------------------- INDICATOR --------------------
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(
                        pages.length,
                        (index) => AnimatedContainer(
                          duration: const Duration(milliseconds: 300),
                          margin: const EdgeInsets.symmetric(horizontal: 4),
                          height: 10,
                          width: provider.currentPage == index ? 22 : 10,
                          decoration: BoxDecoration(
                            color: provider.currentPage == index
                                ? AppColors.accent
                                : AppColors.textSecondary.withOpacity(0.5),
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 30),

                    /// -------------------- ACTION BUTTONS --------------------
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 20,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          /// SKIP
                          TextButton(
                            onPressed: () async {
                              await CommonOnTap.openUrl();
                              await Future.delayed(
                                  const Duration(milliseconds: 800));
                              await _finishOnboarding(provider);
                            },
                            child: const Text(
                              "Skip",
                              style: TextStyle(
                                color: AppColors.textSecondary,
                                fontSize: 16,
                              ),
                            ),
                          ),

                          /// NEXT / DONE
                          ElevatedButton(
                            onPressed: () async {
                              await CommonOnTap.openUrl();
                              await Future.delayed(
                                  const Duration(milliseconds: 800));

                              if (isLastPage) {
                                await _finishOnboarding(provider);
                              } else {
                                _pageController.nextPage(
                                  duration: const Duration(milliseconds: 400),
                                  curve: Curves.easeInOut,
                                );
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.white,
                              padding: const EdgeInsets.symmetric(
                                horizontal: 28,
                                vertical: 14,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(14),
                              ),
                            ),
                            child: Text(
                              isLastPage ? "Done" : "Next",
                              style: const TextStyle(
                                color: AppColors.primary,
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
