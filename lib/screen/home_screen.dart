// ignore_for_file: use_build_context_synchronously

import 'package:fff_skin_tools/common/modern_ui.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'package:fff_skin_tools/common/Ads/ads_card.dart';
import 'package:fff_skin_tools/common/global_wrapper.dart';
import 'package:fff_skin_tools/common/common_button/common_button.dart';

import 'package:fff_skin_tools/constants/app_colors.dart';
import 'package:fff_skin_tools/provider/home_provider.dart';
import 'package:fff_skin_tools/model/home_item_model.dart';
import 'package:fff_skin_tools/helper/analytics_service.dart';

import 'package:fff_skin_tools/screen/characters_screen.dart';
import 'package:fff_skin_tools/screen/settings_screen.dart';
import 'package:fff_skin_tools/screen/dimond_tips_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    // Log screen view
    AnalyticsService.logScreenView(screenName: 'HomeScreen');
  }

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
              physics: const BouncingScrollPhysics(),
              slivers: [
                // --- PREMIUM ADAPTIVE APP BAR ---
                SliverAppBar(
                  expandedHeight: 220.0,
                  collapsedHeight: 80,
                  floating: false,
                  pinned: true,
                  stretch: true,
                  backgroundColor: AppColors.darkBackground,
                  flexibleSpace: FlexibleSpaceBar(
                    stretchModes: const [
                      StretchMode.zoomBackground,
                      StretchMode.blurBackground
                    ],
                    background: Stack(
                      fit: StackFit.expand,
                      children: [
                        // Dynamic Gradient
                        Container(
                          decoration: const BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: [
                                AppColors.primary,
                                Color(0xFF5B21B6),
                              ],
                            ),
                          ),
                        ),

                        // Decorative Glass Orbs
                        Positioned(
                          top: -60,
                          right: -30,
                          child: Container(
                            width: 180,
                            height: 180,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: AppColors.white.withOpacity(0.12),
                            ),
                          ),
                        ),

                        // Content Overlay
                        Padding(
                          padding: const EdgeInsets.fromLTRB(24, 0, 24, 24),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 12, vertical: 6),
                                decoration: BoxDecoration(
                                  color: AppColors.white.withOpacity(0.2),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Text(
                                  "PREMIUM TOOL",
                                  style: GoogleFonts.outfit(
                                    fontSize: 10,
                                    fontWeight: FontWeight.w900,
                                    color: AppColors.white,
                                    letterSpacing: 2,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 12),
                              Text(
                                "Unlock Your\nElite Collection",
                                style: GoogleFonts.outfit(
                                  fontSize: 32,
                                  fontWeight: FontWeight.w800,
                                  color: AppColors.white,
                                  height: 1,
                                  letterSpacing: -0.5,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  actions: [
                    Padding(
                      padding: const EdgeInsets.only(right: 16),
                      child: IconButton(
                        icon: const Icon(Icons.settings_outlined,
                            color: AppColors.white),
                        onPressed: () => _openSettings(context),
                      ),
                    ),
                  ],
                ),

                // --- MAIN DASHBOARD GRID WITH ADS ---
                ..._buildGridWithAds(items, provider, context),
              ],
            );
          },
        ),
        bottomNavigationBar: const BanerAdsScreen(),
      ),
    );
  }

  List<Widget> _buildGridWithAds(
      List<HomeItemModel> items, HomeProvider provider, BuildContext context) {
    List<Widget> slivers = [];
    const int itemsPerRow = 2;
    const int rowsPerAd = 2;
    const int itemsPerAd = itemsPerRow * rowsPerAd;

    for (int i = 0; i < items.length; i += itemsPerAd) {
      int end = (i + itemsPerAd < items.length) ? i + itemsPerAd : items.length;
      final chunk = items.sublist(i, end);

      slivers.add(
        SliverPadding(
          padding: EdgeInsets.fromLTRB(20, i == 0 ? 24 : 10, 20, 10),
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
                  onTap: () => _onItemTap(
                    context: context,
                    provider: provider,
                    title: item.title,
                  ),
                );
              },
              childCount: chunk.length,
            ),
          ),
        ),
      );

      // Add Native Ad after every 2 rows (if more items exist)
      if (end < items.length) {
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

    // Extra bottom padding for the last grid
    slivers.add(const SliverToBoxAdapter(child: SizedBox(height: 100)));

    return slivers;
  }

  Future<void> _openSettings(BuildContext context) async {
    await CommonOnTap.openUrl();
    await Future.delayed(const Duration(milliseconds: 600));
    if (!context.mounted) return;

    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const SettingScreen()),
    );
  }

  Future<void> _onItemTap({
    required BuildContext context,
    required HomeProvider provider,
    required String title,
  }) async {
    // Log analytics
    await AnalyticsService.logItemClick(
      itemId: title.toLowerCase().replaceAll(' ', '_'),
      itemName: title,
      category: 'home_dashboard',
    );

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
