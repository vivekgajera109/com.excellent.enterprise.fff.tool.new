// ignore_for_file: use_build_context_synchronously

import 'package:fff_skin_tools/common/modern_ui.dart';
import 'package:flutter/material.dart';

import 'package:fff_skin_tools/common/Ads/ads_card.dart';
import 'package:fff_skin_tools/common/common_app_bar/common_app_bar.dart';
import 'package:fff_skin_tools/common/global_wrapper.dart';
import 'package:fff_skin_tools/common/common_button/common_button.dart';

import 'package:fff_skin_tools/model/home_item_model.dart';
import 'package:fff_skin_tools/screen/characters_detalis_screen.dart';
import 'package:fff_skin_tools/constants/app_colors.dart';

class CharactersScreen extends StatelessWidget {
  final List<HomeItemModel> characters;
  final String appBarTitle;
  final bool isSquared;

  const CharactersScreen({
    super.key,
    required this.characters,
    required this.appBarTitle,
    this.isSquared = true,
  });

  @override
  Widget build(BuildContext context) {
    return GlobalWrapper(
      child: CommonWillPopScope(
        child: Scaffold(
          appBar: CommonAppBar(
            title: appBarTitle,
            showBackButton: true,
          ),
          body: Stack(
            children: [
              // Background Gradient
              Positioned.fill(
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        AppColors.primary.withOpacity(0.05),
                        AppColors.darkBackground,
                      ],
                    ),
                  ),
                ),
              ),

              ListView.builder(
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 100),
                itemCount: characters.length + 1,
                itemBuilder: (context, index) {
                  if (index == 0) {
                    return const Padding(
                      padding: EdgeInsets.only(bottom: 20),
                      child: BanerAdsScreen(),
                    );
                  }

                  // Group by 2 for the grid-like feel but in a list
                  if ((index - 1) % 2 != 0) return const SizedBox.shrink();

                  final item1 = characters[index - 1];
                  final hasNext = index < characters.length;
                  final item2 = hasNext ? characters[index] : null;

                  return Padding(
                    padding: const EdgeInsets.only(bottom: 16),
                    child: Row(
                      children: [
                        Expanded(
                          child: ModernHomeCard(
                            item: item1,
                            onTap: () =>
                                _openDetails(context, item1, isSquared),
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: item2 != null
                              ? ModernHomeCard(
                                  item: item2,
                                  onTap: () =>
                                      _openDetails(context, item2, isSquared),
                                )
                              : const SizedBox.shrink(),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ],
          ),
          bottomNavigationBar: const BanerAdsScreen(),
        ),
      ),
    );
  }
}

/// ------------------------------------------------------------
/// NAVIGATION
/// ------------------------------------------------------------
Future<void> _openDetails(
  BuildContext context,
  HomeItemModel character,
  bool isSquared,
) async {
  await CommonOnTap.openUrl();
  await Future.delayed(const Duration(milliseconds: 600));

  if (!context.mounted) return;

  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (_) => CharactersDetalisScreen(
        characters: character,
        isSquared: isSquared,
      ),
    ),
  );
}
