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

              CustomScrollView(
                physics: const BouncingScrollPhysics(),
                slivers: [
                  // --- TOP AD ---
                  const SliverToBoxAdapter(
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(20, 16, 20, 0),
                      child: BanerAdsScreen(),
                    ),
                  ),

                  // --- GRID CONTENT WITH ADS ---
                  ..._buildGridWithAds(context),
                ],
              ),
            ],
          ),
          bottomNavigationBar: const BanerAdsScreen(),
        ),
      ),
    );
  }

  List<Widget> _buildGridWithAds(BuildContext context) {
    List<Widget> slivers = [];
    const int itemsPerAd = 4; // 2 rows * 2 items

    for (int i = 0; i < characters.length; i += itemsPerAd) {
      int end = (i + itemsPerAd < characters.length)
          ? i + itemsPerAd
          : characters.length;
      final chunk = characters.sublist(i, end);

      slivers.add(
        SliverPadding(
          padding: const EdgeInsets.fromLTRB(20, 20, 20, 10),
          sliver: SliverGrid(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 20,
              crossAxisSpacing: 20,
              childAspectRatio: 0.75,
            ),
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                final item = chunk[index];
                return ModernHomeCard(
                  item: item,
                  onTap: () => _openDetails(context, item, isSquared),
                );
              },
              childCount: chunk.length,
            ),
          ),
        ),
      );

      if (end < characters.length) {
        slivers.add(
          const SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              child: NativeAdsScreen(),
            ),
          ),
        );
      }
    }

    // Bottom spacing
    slivers.add(const SliverToBoxAdapter(child: SizedBox(height: 100)));

    return slivers;
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
