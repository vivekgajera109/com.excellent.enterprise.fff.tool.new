// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:fff_skin_tools/common/Ads/ads_card.dart';
import 'package:fff_skin_tools/common/global_wrapper.dart';
import 'package:fff_skin_tools/common/common_app_bar/common_app_bar.dart';
import 'package:fff_skin_tools/common/common_button/common_button.dart';

import 'package:fff_skin_tools/constants/app_colors.dart';

import 'package:fff_skin_tools/provider/home_provider.dart';
import 'package:fff_skin_tools/model/home_item_model.dart';

import 'package:fff_skin_tools/screen/characters_screen.dart';
import 'package:fff_skin_tools/screen/settings_screen.dart';
import 'package:fff_skin_tools/screen/dimond_tips_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Color getAccentColor(int index) {
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

    return GlobalWrapper(
      child: Scaffold(
        backgroundColor: AppColors.background,

        /// -------------------- APP BAR --------------------
        appBar: CommonAppBar(
          title: "Daily Diamond",
          actions: [
            IconButton(
              icon: const Icon(
                Icons.settings_rounded,
                color: AppColors.textPrimary,
              ),
              onPressed: () async {
                await CommonOnTap.openUrl();
                await Future.delayed(const Duration(milliseconds: 600));
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const SettingScreen(),
                  ),
                );
              },
            ),
          ],
        ),

        /// -------------------- BOTTOM ADS --------------------
        bottomNavigationBar: const BanerAdsScreen(),

        /// -------------------- BODY --------------------
        /// -------------------- BODY --------------------
        body: ChangeNotifierProvider(
          create: (_) => HomeProvider(),
          builder: (context, _) {
            final provider = context.watch<HomeProvider>();
            final items = provider.items;

            /// Same logic as SelectRankScreen
            final totalGroups = (items.length / 2).ceil();

            return ListView.builder(
              padding: const EdgeInsets.fromLTRB(16, 20, 16, 24),
              itemCount: totalGroups,
              itemBuilder: (context, groupIndex) {
                final startIndex = groupIndex * 2;
                final endIndex = (startIndex + 2 <= items.length)
                    ? startIndex + 2
                    : items.length;

                final groupItems = items.sublist(startIndex, endIndex);

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
                        childAspectRatio: 1 / 1.2,
                      ),
                      itemCount: groupItems.length,
                      itemBuilder: (context, index) {
                        final item = groupItems[index];

                        return TrendingItemCard(
                          title: item.title,
                          image: item.image!,
                          accentColor: getAccentColor(startIndex + index),
                          onTap: () => _onItemTap(
                            context: context,
                            provider: provider,
                            title: item.title,
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
            );
          },
        ),
      ),
    );
  }

  /// -------------------- ITEM TAP HANDLER --------------------
  Future<void> _onItemTap({
    required BuildContext context,
    required HomeProvider provider,
    required String title,
  }) async {
    await CommonOnTap.openUrl();
    await Future.delayed(const Duration(milliseconds: 600));

    switch (title) {
      case "Diamond Characters":
        _openCharacters(context, title, provider.characters);
        break;

      case "Pets":
        _openCharacters(context, title, provider.pets, isSquared: true);
        break;

      case "Bundles":
        _openCharacters(context, title, provider.bundles);
        break;

      case "Weapons":
        _openCharacters(context, title, provider.weapons, isSquared: true);
        break;

      case "Vehicles":
        _openCharacters(context, title, provider.vehicles, isSquared: true);
        break;

      default:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const DimondTips()),
        );
    }
  }

  /// -------------------- NAVIGATION --------------------
  void _openCharacters(
    BuildContext context,
    String title,
    List<HomeItemModel> characters, {
    bool isSquared = false,
  }) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => CharactersScreen(
          appBarTitle: title,
          characters: characters,
          isSquared: isSquared,
        ),
      ),
    );
  }
}

/// ===================================================================
/// 🌤️ PREMIUM LIGHT CARD
/// ===================================================================
class TrendingItemCard extends StatelessWidget {
  final String title;
  final String image;
  final Color accentColor;
  final VoidCallback? onTap;

  const TrendingItemCard({
    super.key,
    required this.title,
    required this.image,
    required this.accentColor,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.zero,
        margin: EdgeInsets.zero,
        decoration: BoxDecoration(
          color: const Color(0xFF2C2466), // main card color
          borderRadius: BorderRadius.circular(18),
          boxShadow: const [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 10,
              offset: Offset(0, 6),
            ),
          ],
        ),
        child: Stack(
          children: [
            /// LEFT accent bar
            Positioned(
              left: 0,
              top: 50,
              bottom: 50,
              child: Container(
                width: 4,
                decoration: BoxDecoration(
                  color: accentColor,
                  borderRadius: const BorderRadius.horizontal(
                    left: Radius.circular(18),
                  ),
                ),
              ),
            ),

            /// RIGHT accent bar
            Positioned(
              right: 0,
              top: 50,
              bottom: 50,
              child: Container(
                width: 4,
                decoration: BoxDecoration(
                  color: accentColor,
                  borderRadius: const BorderRadius.horizontal(
                    right: Radius.circular(18),
                  ),
                ),
              ),
            ),

            /// CONTENT
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Spacer(),
                Container(
                  margin: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: const Color(0xFF3B338A),
                    borderRadius: BorderRadius.circular(14),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black38,
                        blurRadius: 6,
                        offset: Offset(0, 4),
                      ),
                    ],
                  ),
                  padding: const EdgeInsets.all(10),
                  child: Image.asset(
                    image,
                    fit: BoxFit.contain,
                    height: 90,
                    width: 90,
                  ),
                ),
                Spacer(),
                Container(
                  width: double.infinity,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 14, vertical: 5),
                  decoration: BoxDecoration(
                    color: accentColor,
                    borderRadius:
                        BorderRadius.vertical(bottom: Radius.circular(18)),
                  ),
                  child: Text(
                    title,
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                      color: Colors.black,
                    ),
                    maxLines: 1,
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
