import 'package:flutter/material.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

import 'package:fff_skin_tools/common/common_button/common_button.dart';
import 'package:fff_skin_tools/common/common_app_bar/common_app_bar.dart';
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

    await Future.delayed(const Duration(milliseconds: 800));

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
      backgroundColor: AppColors.background,

      /// -------------------- APP BAR --------------------
      appBar: const CommonAppBar(
        title: "No Internet",
        showBackButton: false,
      ),

      /// -------------------- BODY --------------------
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              /// ICON
              Icon(
                Icons.wifi_off_rounded,
                size: 96,
                color: AppColors.danger,
              ),

              const SizedBox(height: 24),

              /// TITLE
              const Text(
                "No Internet Connection",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary,
                ),
              ),

              const SizedBox(height: 10),

              /// SUBTITLE
              const Text(
                "Please check your mobile data or Wi-Fi connection and try again.",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14,
                  color: AppColors.textSecondary,
                  height: 1.4,
                ),
              ),

              const SizedBox(height: 36),

              /// RETRY BUTTON
              CommonOutlineButton(
                title: "Retry",
                onTap: _checking ? null : _retryConnection,
                child: _checking
                    ? const SizedBox(
                        width: 22,
                        height: 22,
                        child: CircularProgressIndicator(
                          strokeWidth: 2.5,
                          color: AppColors.accent,
                        ),
                      )
                    : const Text(
                        "Retry",
                        style: TextStyle(
                          color: AppColors.textPrimary,
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
