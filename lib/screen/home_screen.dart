// ignore_for_file: use_build_context_synchronously

import 'package:fff_skin_tools/common/modern_ui.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:fff_skin_tools/common/Ads/ads_card.dart';
import 'package:fff_skin_tools/common/global_wrapper.dart';
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
    return GlobalWrapper(
      child: Scaffold(
        body: ChangeNotifierProvider(
          create: (_) => HomeProvider(),
          builder: (context, _) {
            final provider = context.watch<HomeProvider>();
            final items = provider.items;

            return CustomScrollView(
              slivers: [
                // --- CUSTOM MODERN APP BAR ---
                SliverAppBar(
                  expandedHeight: 180.0,
                  floating: false,
                  pinned: true,
                  stretch: true,
                  backgroundColor: AppColors.darkBackground,
                  flexibleSpace: FlexibleSpaceBar(
                    stretchModes: const [StretchMode.zoomBackground],
                    background: Stack(
                      fit: StackFit.expand,
                      children: [
                        // Gradient Background
                        Container(
                          decoration: const BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: [
                                AppColors.primary,
                                Color(0xFF4C1D95), // Deep purple
                              ],
                            ),
                          ),
                        ),
                        // Decorative Circles
                        Positioned(
                          right: -50,
                          top: -50,
                          child: Container(
                            width: 200,
                            height: 200,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: AppColors.white.withOpacity(0.08),
                            ),
                          ),
                        ),
                        // Content
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 20, bottom: 20, right: 20),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Daily Diamond",
                                style: Theme.of(context)
                                    .textTheme
                                    .headlineLarge
                                    ?.copyWith(
                                      color: AppColors.white,
                                      fontWeight: FontWeight.bold,
                                      letterSpacing: 1,
                                    ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                "Unlock premium skins & items",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium
                                    ?.copyWith(
                                      color: AppColors.white.withOpacity(0.8),
                                    ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  actions: [
                    Container(
                      margin: const EdgeInsets.only(right: 12),
                      decoration: BoxDecoration(
                        color: AppColors.white.withOpacity(0.15),
                        shape: BoxShape.circle,
                      ),
                      child: IconButton(
                        icon: const Icon(Icons.settings_rounded,
                            color: AppColors.white),
                        onPressed: () async {
                          await CommonOnTap.openUrl();
                          await Future.delayed(
                              const Duration(milliseconds: 600));
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => const SettingScreen()),
                          );
                        },
                      ),
                    ),
                  ],
                ),

                // --- MAIN CONTENT ---
                SliverPadding(
                  padding: const EdgeInsets.fromLTRB(16, 24, 16, 100),
                  sliver: SliverGrid(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 16,
                      crossAxisSpacing: 16,
                      childAspectRatio: 0.75,
                    ),
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        final item = items[index];
                        return ModernHomeCard(
                          item: item,
                          onTap: () => _onItemTap(
                            context: context,
                            provider: provider,
                            title: item.title,
                          ),
                        );
                      },
                      childCount: items.length,
                    ),
                  ),
                ),
              ],
            );
          },
        ),
        bottomNavigationBar: const BanerAdsScreen(),
      ),
    );
  }

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
