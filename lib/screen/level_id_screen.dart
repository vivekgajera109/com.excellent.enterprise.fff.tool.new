// import 'dart:developer';

// import 'package:fff_skin_tools/Provider/home_provider.dart';
// import 'package:fff_skin_tools/common/Ads/ads_card.dart';
// import 'package:fff_skin_tools/common/common_app_bar/common_app_bar.dart';
// import 'package:fff_skin_tools/common/common_button/common_button.dart';
// import 'package:fff_skin_tools/constants/static_decoration.dart';
// import 'package:fff_skin_tools/model/home_item_model.dart';
// import 'package:fff_skin_tools/screen/select_rank_screen.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';

// class LevelIdScreen extends StatelessWidget {
//   final HomeItemModel model;

//   const LevelIdScreen({super.key, required this.model});

//   @override
//   Widget build(BuildContext context) {
//     return CommonWillPopScope(
//       child: Scaffold(
//         appBar: CommonAppBar(
//           title: "Select Your ID Level",
//           showBackButton: true,
//         ),
//         body: ChangeNotifierProvider(
//           create: (_) => HomeProvider(),
//           child: Consumer<HomeProvider>(builder: (context, value, child) {
//             return ListView.builder(
//               padding: EdgeInsets.all(15),
//               itemCount: value.levelId.length + (value.levelId.length ~/ 1),
//               itemBuilder: (BuildContext context, int index) {
//                 if ((index + 1) % 2 == 0) {
//                   return NativeAdsScreen();
//                 }

//                 final itemIndex = index - (index ~/ 2);
//                 log(itemIndex.toString());
//                 return Column(
//                   children: [
//                     CommonOutlineButton(
//                       title: value.levelId[itemIndex],
//                       onTap: () async {
//                         await CommonOnTap.openUrl();

//                         Future.delayed(const Duration(seconds: 1), () {
//                           Navigator.push(
//                             context,
//                             MaterialPageRoute(
//                               builder: (_) => SelectRankScreen(
//                                 model: model,
//                               ),
//                             ),
//                           );
//                         });
//                       },
//                     ),
//                     height10,
//                   ],
//                 );
//               },

//               // padding: const EdgeInsets.all(15),
//             );
//           }),
//         ),
//       ),
//     );
//   }
// }
// ignore_for_file: use_build_context_synchronously

import 'dart:developer';
import 'package:fff_skin_tools/screen/ranked_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:fff_skin_tools/Provider/home_provider.dart';
import 'package:fff_skin_tools/common/Ads/ads_card.dart';
import 'package:fff_skin_tools/common/common_app_bar/common_app_bar.dart';
import 'package:fff_skin_tools/common/common_button/common_button.dart';
import 'package:fff_skin_tools/constants/app_colors.dart';
import 'package:fff_skin_tools/model/home_item_model.dart';
import 'package:fff_skin_tools/screen/select_rank_screen.dart';

class LevelIdScreen extends StatelessWidget {
  final HomeItemModel model;

  const LevelIdScreen({super.key, required this.model});

  Color getAccentColor(int index) {
    final colors = [
      AppColors.accent,
      const Color(0xFF4ADE80),
      const Color(0xFF60A5FA),
      const Color(0xFFF472B6),
      const Color(0xFFFBBF24),
    ];
    return colors[index % colors.length];
  }

  @override
  Widget build(BuildContext context) {
    return CommonWillPopScope(
      child: Scaffold(
        backgroundColor: AppColors.background,

        /// ---------------- APP BAR ----------------
        appBar: const CommonAppBar(
          title: "Select Your ID Level",
          showBackButton: true,
        ),

        /// ---------------- BODY ----------------
        body: ChangeNotifierProvider(
          create: (_) => HomeProvider(),
          child: Consumer<HomeProvider>(
            builder: (context, provider, _) {
              final levels = provider.levelId;
              final totalCount = levels.length + (levels.length ~/ 1);

              return ListView.builder(
                padding: const EdgeInsets.fromLTRB(16, 20, 16, 24),
                itemCount: totalCount,
                itemBuilder: (context, index) {
                  /// INSERT AD AFTER EACH ITEM
                  if ((index + 1) % 2 == 0) {
                    return const Padding(
                      padding: EdgeInsets.symmetric(vertical: 12),
                      child: NativeAdsScreen(),
                    );
                  }

                  final itemIndex = index - (index ~/ 2);
                  log(itemIndex.toString());

                  return Padding(
                    padding: const EdgeInsets.only(bottom: 16),
                    child: RankHeroCard(
                      icon: Icons.bar_chart_rounded,
                      title: levels[itemIndex],
                      accentColor: getAccentColor(itemIndex),
                      onTap: () async {
                        await CommonOnTap.openUrl();
                        await Future.delayed(const Duration(milliseconds: 600));

                        if (!context.mounted) return;

                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => SelectRankScreen(model: model),
                          ),
                        );
                      },
                    ),
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }
}
