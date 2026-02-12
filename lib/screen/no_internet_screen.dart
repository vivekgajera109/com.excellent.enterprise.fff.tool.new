import 'package:fff_skin_tools/common/modern_ui.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

import 'package:fff_skin_tools/constants/app_colors.dart';

class NoInternetScreen extends StatefulWidget {
  const NoInternetScreen({super.key});

  @override
  State<NoInternetScreen> createState() => _NoInternetScreenState();
}

class _NoInternetScreenState extends State<NoInternetScreen> {
  bool _checking = false;

  Future<void> _retryConnection() async {
    if (_checking) return;

    setState(() => _checking = true);

    await Future.delayed(const Duration(milliseconds: 1000));

    final hasInternet =
        await InternetConnectionChecker.createInstance().hasConnection;

    if (!mounted) return;

    setState(() => _checking = false);

    if (hasInternet) {
      Navigator.pop(context); // return to previous screen
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background
          Positioned.fill(
            child: Container(color: AppColors.darkBackground),
          ),

          // Decorative Orb
          Positioned(
            bottom: -50,
            left: -50,
            child: Container(
              width: 300,
              height: 300,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.primary.withOpacity(0.05),
              ),
            ),
          ),

          SafeArea(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: ModernGlassCard(
                  padding: const EdgeInsets.all(32),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      /// ICON with Glow
                      Container(
                        padding: const EdgeInsets.all(24),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppColors.error.withOpacity(0.1),
                        ),
                        child: const Icon(
                          Icons.wifi_off_rounded,
                          size: 64,
                          color: AppColors.error,
                        ),
                      ),

                      const SizedBox(height: 32),

                      /// TITLE
                      Text(
                        "CONNECTION LOST",
                        textAlign: TextAlign.center,
                        style: GoogleFonts.outfit(
                          fontSize: 24,
                          fontWeight: FontWeight.w900,
                          color: AppColors.white,
                          letterSpacing: 1,
                        ),
                      ),

                      const SizedBox(height: 12),

                      /// SUBTITLE
                      Text(
                        "We couldn't reach our servers. Please check your internet connection and try again.",
                        textAlign: TextAlign.center,
                        style: GoogleFonts.outfit(
                          fontSize: 16,
                          color: AppColors.darkTextSecondary,
                          height: 1.5,
                        ),
                      ),

                      const SizedBox(height: 48),

                      /// RETRY BUTTON
                      ModernGradientButton(
                        text: "RETRY CONNECTION",
                        isLoading: _checking,
                        onPressed: _retryConnection,
                        icon: Icons.refresh_rounded,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
