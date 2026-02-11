// ignore_for_file: use_build_context_synchronously

import 'package:fff_skin_tools/screen/home_screen.dart';
import 'package:flutter/material.dart';

import 'package:fff_skin_tools/common/Ads/ads_card.dart';
import 'package:fff_skin_tools/common/common_app_bar/common_app_bar.dart';
import 'package:fff_skin_tools/common/global_wrapper.dart';
import 'package:fff_skin_tools/common/common_button/common_button.dart';

import 'package:fff_skin_tools/model/home_item_model.dart';
import 'package:fff_skin_tools/screen/characters_detalis_screen.dart';

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

  Color _getAccentColor(int index) {
    final colors = [
      Color(0xFFFFC857),
      Color(0xFFFF5C8A),
      Color(0xFF4ADE80),
      Color(0xFF60A5FA),
      Color(0xFFFBBF24),
      Color(0xFFFB7185),
    ];
    return colors[index % colors.length];
  }

  @override
  Widget build(BuildContext context) {
    final totalGroups = (characters.length / 4).ceil();

    return GlobalWrapper(
      child: CommonWillPopScope(
        child: Scaffold(
          appBar: CommonAppBar(
            title: appBarTitle,
            showBackButton: true,
          ),
          body: ListView.builder(
            padding: const EdgeInsets.fromLTRB(16, 20, 16, 24),
            itemCount: totalGroups + 1,
            itemBuilder: (context, index) {
              /// TOP BANNER
              if (index == 0) {
                return const Padding(
                  padding: EdgeInsets.only(bottom: 16),
                  child: BanerAdsScreen(),
                );
              }

              final groupIndex = index - 1;
              final startIndex = groupIndex * 4;
              final endIndex = (startIndex + 4 <= characters.length)
                  ? startIndex + 4
                  : characters.length;

              final groupItems = characters.sublist(startIndex, endIndex);

              return Column(
                children: [
                  /// ---------------- GRID ----------------
                  GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 16,
                      crossAxisSpacing: 16,
                      childAspectRatio: 0.82,
                    ),
                    itemCount: groupItems.length,
                    itemBuilder: (context, itemIndex) {
                      final item = groupItems[itemIndex];

                      return TrendingItemCard(
                        title: item.title,
                        image: item.image!,
                        accentColor: _getAccentColor(startIndex + itemIndex),
                        onTap: () => _openDetails(
                          context,
                          item,
                          isSquared,
                        ),
                      );
                    },
                  ),

                  /// ---------------- NATIVE AD ----------------
                  if (groupIndex != totalGroups - 1)
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 16),
                      child: NativeAdsScreen(),
                    ),
                ],
              );
            },
          ),
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
